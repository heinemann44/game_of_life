import 'package:flutter/material.dart';
import 'package:game_of_life_flutter/features/game_of_life/presentation/game_controller.dart';
import 'package:game_of_life_flutter/features/game_of_life/presentation/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameController gameController;

@override
  void initState() {
    super.initState();
    this.gameController = GameController();
    this.gameController.initState();
    this.gameController.loadGameDefault();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: this._buildSendToGamePageButton(),
    );
  }

  Widget _buildSendToGamePageButton() {
    return FlatButton(
      onPressed: this._sendToGamePage,
      color: Colors.lightGreen,
      child: Text(
        "Start the game!",
        style: TextStyle(
          color: Colors.white,
          fontSize: 26.0,
        ),
      ),
    );
  }

  void _sendToGamePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GamePage(this.gameController),
      ),
    );
  }
}
