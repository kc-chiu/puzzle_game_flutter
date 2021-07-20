import 'space.dart';
import 'dart:math';

class Game {
  Game(this.size)
      : _cells = List.generate(
            size, (x) => List.generate(size, (y) => x * size + y)),
        _space = Space(size * size - 1, size - 1, size - 1);

  // Number of rows and columns
  int size;

  // The last value in cells represents the space/empty cell
  List<List<int>> _cells;
  List<List<int>> get cells => _cells;
  Space _space;

  bool canMoveCell(int x, int y) {
    if ((_space.x - x).abs() == 1 && _space.y == y) {
      return true;
    }
    if ((_space.y - y).abs() == 1 && _space.x == x) {
      return true;
    }
    return false;
  }

  void moveCell(int x, int y) {
    _cells[_space.x][_space.y] = _cells[x][y];
    _cells[x][y] = _space.id;
    _space.x = x;
    _space.y = y;
  }

  // Scramble the cells by moving the space around randomly
  void scramble(int n) {
    for (int i = 0; i < n; i++) {
      _randomSpaceStep();
      if (_space.dx != 0) {
        if (0 <= _space.x + _space.dx && _space.x + _space.dx < size) {
          _moveSpace();
        }
      } else {
        if (0 <= _space.y + _space.dy && _space.y + _space.dy < size) {
          _moveSpace();
        }
      }
    }

    // Move empty space back to the end of the board after scrambling
    _space.dx = 1;
    _space.dy = 0;
    while (_space.x < size - 1) {
      _moveSpace();
    }

    _space.dx = 0;
    _space.dy = 1;
    while (_space.y < size - 1) {
      _moveSpace();
    }
  }

  // Randomly set 1 step in 1 of 4 possible directions along x and y directions
  void _randomSpaceStep() {
    int dx = 0;
    int dy = 0;
    final step = Random().nextInt(4);
    switch (step) {
      case 0:
        dx = -1;
        dy = 0;
        break;
      case 1:
        dx = 1;
        dy = 0;
        break;
      case 2:
        dx = 0;
        dy = -1;
        break;
      case 3:
        dx = 0;
        dy = 1;
        break;
    }
    _space.dx = dx;
    _space.dy = dy;
  }

  void _moveSpace() {
    // either dx or dy must be zero
    moveCell(_space.x + _space.dx, _space.y + _space.dy);
  }
}
