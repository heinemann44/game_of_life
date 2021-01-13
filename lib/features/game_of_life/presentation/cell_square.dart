import 'package:flutter/material.dart';
import 'package:game_of_life_flutter/features/game_of_life/business/entities/cell.dart';
import 'package:game_of_life_flutter/features/game_of_life/business/enums/cell_state.dart';

class CellSquare extends StatefulWidget {
  final Cell cell;

  const CellSquare(
    this.cell, {
    Key key,
  }) : super(key: key);

  @override
  _CellSquareState createState() => _CellSquareState();
}

class _CellSquareState extends State<CellSquare> {
  bool get alive => this.widget.cell.state == CellState.ALIVE;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this._changeStateCell,
      child: Container(
        decoration: BoxDecoration(
          color: this.alive ? Colors.green : Colors.black,
          border: Border.all(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }

  void _changeStateCell() {
    setState(() {
      if (this.alive) {
        this.widget.cell.state = CellState.DEAD;
      } else {
        this.widget.cell.state = CellState.ALIVE;
      }
    });
  }
}
