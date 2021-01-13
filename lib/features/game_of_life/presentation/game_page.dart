import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_of_life_flutter/features/game_of_life/presentation/cell_square.dart';
import 'package:game_of_life_flutter/features/game_of_life/presentation/game_controller.dart';

class GamePage extends StatefulWidget {
  final GameController gameController;

  const GamePage(
    this.gameController, {
    Key key,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  GameForm get _state => this.widget.gameController.state;

  Timer timer;
  AnimationController animationController;
  bool playing;

  @override
  void initState() {
    super.initState();
    this.playing = false;
    this.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );

    this.widget.gameController.saveInitGameState();
  }

  @override
  void dispose() {
    this._cancelTimer();
    this.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._buildAppBar(),
      body: this._buildBody(),
      bottomNavigationBar: this._buildControllerButtons(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Game page"),
    );
  }

  Widget _buildBody() {
    return GridView.count(
      crossAxisCount: 10,
      children: this._state.cells.map((cell) => CellSquare(cell)).toList(),
    );
  }

  Widget _buildControllerButtons() {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          this._buildResetButton(),
          this._buildPlayGameButton(),
          this._buildNextFrameButton(),
          ...this._buildSpeedControllersButton(),
        ],
      ),
    );
  }

  Widget _buildResetButton() {
    return Tooltip(
      message: "Restart the game",
      child: IconButton(
        icon: Icon(
          Icons.rotate_left,
          size: 35,
        ),
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() => this.widget.gameController.loadInitGameState());
          if (this.playing) {
            this.animationController.reverse();
            this._cancelTimer();
            this.playing = !this.playing;
          }
        },
      ),
    );
  }

  Widget _buildPlayGameButton() {
    return Tooltip(
      message: "${this.playing ? 'Pause' : 'Start'}",
      child: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          size: 50,
          progress: this.animationController,
        ),
        padding: EdgeInsets.zero,
        onPressed: () {
          if (this.playing) {
            this.animationController.reverse();
            this._cancelTimer();
          } else {
            this.animationController.forward();
            this._makeNextMove();
            this._playTimer();
          }

          this.playing = !this.playing;
        },
      ),
    );
  }

  Widget _buildNextFrameButton() {
    return Tooltip(
      message: "Next frame",
      child: IconButton(
        icon: Icon(
          Icons.forward,
          size: 35,
        ),
        onPressed: this._makeNextMove,
      ),
    );
  }

  List<Widget> _buildSpeedControllersButton() {
    return [
      IconButton(
        icon: Icon(Icons.exposure_minus_1),
        onPressed: () {
          if (this.widget.gameController.state.ticksPerSecond > 1) {
            setState(() => this.widget.gameController.state.ticksPerSecond--);
          }
        },
      ),
      Tooltip(
        child: Text(
          "${this._state.ticksPerSecond.toString().padLeft(2, '0')}",
          style: TextStyle(fontSize: 30),
        ),
        message: "Ticks per second",
      ),
      IconButton(
        icon: Icon(Icons.plus_one),
        onPressed: () {
          if (this.widget.gameController.state.ticksPerSecond < 10) {
            setState(() => this.widget.gameController.state.ticksPerSecond++);
          }
        },
      ),
    ];
  }

  void _makeNextMove() {
    setState(() {
      this.widget.gameController.calcNextMove();
    });
  }

  void _playTimer() {
    double durationMilliseconds =
        1000 / this.widget.gameController.state.ticksPerSecond;

    Duration duration = Duration(milliseconds: durationMilliseconds.toInt());
    this.timer = Timer(duration, () {
      this._makeNextMove();
      this._playTimer();
    });
  }

  void _cancelTimer() {
    if (this.timer != null) this.timer.cancel();
  }
}
