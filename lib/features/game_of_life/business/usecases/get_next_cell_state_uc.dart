import 'package:game_of_life_flutter/features/game_of_life/business/entities/cell.dart';
import 'package:game_of_life_flutter/features/game_of_life/business/enums/cell_state.dart';

class GetNextCellStateUC {
  /// 1.Any live cell with fewer than two live neighbours dies, as if by underpopulation.
  /// 2.Any live cell with two or three live neighbours lives on to the next generation.
  /// 3.Any live cell with more than three live neighbours dies, as if by overpopulation.
  /// 4.Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  CellState call(Cell cell, int quantityNeighbours) {
    switch (cell.state) {
      case CellState.ALIVE:
        if (quantityNeighbours < 2) {
          return CellState.DEAD;
        } else if (quantityNeighbours == 2 || quantityNeighbours == 3) {
          return CellState.ALIVE;
        } else if (quantityNeighbours > 3) {
          return CellState.DEAD;
        } else {
          return CellState.DEAD;
        }
        break;
      case CellState.DEAD:
        if (quantityNeighbours == 3) {
          return CellState.ALIVE;
        } else {
          return CellState.DEAD;
        }
        break;
    }
  }
}
