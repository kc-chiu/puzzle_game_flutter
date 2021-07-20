import 'package:flutter/material.dart';
import 'models/models.dart';

class AppState with ChangeNotifier {
  AppState() {
    startGame();
  }

  late Game _game;
  List<List<int>> get cells => _game.cells;

  // Default number of rows/columns
  int _size = 4;

  void startGame() {
    _game = Game(_size);
    notifyListeners();
  }

  void setSize(int size) {
    _size = size;
    startGame();
  }

  void move(int x, int y) {
    if (_game.canMoveCell(x, y)) {
      _game.moveCell(x, y);
      notifyListeners();
    }
  }

  void scramble() {
    _game.scramble(_size * 100);
    notifyListeners();
  }
}
