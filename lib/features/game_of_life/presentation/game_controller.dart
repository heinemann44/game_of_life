
import 'package:game_of_life_flutter/features/game_of_life/business/entities/cell.dart';
import 'package:game_of_life_flutter/features/game_of_life/business/enums/cell_state.dart';
import 'package:game_of_life_flutter/features/game_of_life/business/usecases/get_next_cell_state_uc.dart';

class GameForm {
  List<Cell> cells;
  List<Cell> initGameState;
  List<List<Cell>> cellsMatrix;
  int quantityHorizontalCells;
  int quantityVerticalCells;
  int ticksPerSecond;
}

class GameController {
  GameForm state;

  void initState() {
    this.state = GameForm();
  }

  void clearGame() {
    int quantityCells =
        this.state.quantityHorizontalCells * this.state.quantityVerticalCells;
    this.state.cells = List.generate(
      quantityCells,
      (index) => Cell(position: index, state: CellState.DEAD),
    );

    this._fillMatrixOfCells();
  }

  void _fillMatrixOfCells() {
    this.state.cellsMatrix = List();
    int index = 0;
    for (int i = 0; i < this.state.quantityVerticalCells; i++) {
      List<Cell> row = List();
      for (int j = 0; j < this.state.quantityHorizontalCells; j++) {
        row.add(this.state.cells[index++]);
      }
      this.state.cellsMatrix.add(row);
    }
  }

  void calcNextMove() {
    List<Cell> nextCycle = List();

    this.state.cells.forEach((cell) {
      int neighbours = this._countQuantityNeighbours(cell);
      CellState nextState = GetNextCellStateUC()(cell, neighbours);

      Cell nextCell = Cell.copy(cell);
      nextCell.state = nextState;
      nextCycle.add(nextCell);
    });

    this.state.cells = nextCycle;
    this._fillMatrixOfCells();
  }

  int _countQuantityNeighbours(Cell cell) {
    int livedNeighbours = 0;

    int x = cell.position % this.state.quantityHorizontalCells;
    int y = cell.position ~/ this.state.quantityHorizontalCells;

    x--;
    y--;
    livedNeighbours += this._neighbourLived(x, y);
    x++;
    livedNeighbours += this._neighbourLived(x, y);
    x++;
    livedNeighbours += this._neighbourLived(x, y);
    y++;
    livedNeighbours += this._neighbourLived(x, y);
    y++;
    livedNeighbours += this._neighbourLived(x, y);
    x--;
    livedNeighbours += this._neighbourLived(x, y);
    x--;
    livedNeighbours += this._neighbourLived(x, y);
    y--;
    livedNeighbours += this._neighbourLived(x, y);

    return livedNeighbours;
  }

  int _neighbourLived(int x, int y) {
    if (x >= 0 &&
        x < this.state.quantityHorizontalCells &&
        y >= 0 &&
        y < this.state.quantityVerticalCells) {
      Cell neighbour = this.state.cellsMatrix[y][x];
      if (neighbour.state == CellState.ALIVE) {
        return 1;
      }
    }
    return 0;
  }

  void loadGameDefault() {
    this.state.quantityVerticalCells = 15;
    this.state.quantityHorizontalCells = 10;
    this.state.ticksPerSecond = 1;

    int quantityCells =
        this.state.quantityHorizontalCells * this.state.quantityVerticalCells;
    this.state.cells = List.generate(
      quantityCells,
      (index) => Cell(position: index, state: CellState.DEAD),
    );

    this.state.cells[23].state = CellState.ALIVE;
    this.state.cells[34].state = CellState.ALIVE;
    this.state.cells[42].state = CellState.ALIVE;
    this.state.cells[43].state = CellState.ALIVE;
    this.state.cells[44].state = CellState.ALIVE;

    this._fillMatrixOfCells();
  }

  void saveInitGameState() {
    this.state.initGameState =
        this.state.cells.map((e) => Cell.copy(e)).toList();
  }

  void loadInitGameState() {
    this.state.cells =
        this.state.initGameState.map((e) => Cell.copy(e)).toList();
    this._fillMatrixOfCells();
  }
}
