import 'package:game_of_life_flutter/features/game_of_life/business/enums/cell_state.dart';

class Cell {
  CellState state;
  int position;

  Cell({
    this.state,
    this.position,
  });

  Cell.copy(Cell cell) {
    this.state = cell.state;
    this.position = cell.position;
  }
}
