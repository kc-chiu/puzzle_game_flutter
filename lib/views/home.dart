import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class Home extends StatelessWidget {
  final myTextStyle = TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    final cells = context.watch<AppState>().cells;
    final size = cells.length;
    final length = size * size;

    late List<Color> colors;
    if (length % 2 == 1) {
      colors = List.generate(length, (index) {
        if (index == length - 1) {
          return Colors.grey[350]!;
        }
        if (index % 2 == 0) {
          return Colors.red[300]!;
        } else {
          return Colors.yellow[300]!;
        }
      });
    } else {
      colors = List.generate(length, (index) {
        if (index == length - 1) {
          return Colors.grey[350]!;
        }
        if ((index + index ~/ size) % 2 == 0) {
          return Colors.red[300]!;
        } else {
          return Colors.yellow[300]!;
        }
      });
    }

    // Prepare to show values of cells as children of GridView
    final gridCells = <Widget>[];
    for (int x = 0; x < size; x++) {
      for (int y = 0; y < size; y++) {
        gridCells.add(InkWell(
          onTap: () => context.read<AppState>().move(x, y),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors[cells[x][y]],
              border: Border.all(),
            ),
            child: Text(
              cells[x][y] != size * size - 1 ? '${cells[x][y] + 1}' : '',
              style: TextStyle(fontSize: 42),
            ),
          ),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Moving Puzzle')),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: size,
              children: gridCells,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<AppState>().scramble(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Scramble',
                      style: myTextStyle,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => context.read<AppState>().startGame(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Reset',
                      style: myTextStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text('Puzzle Size:', style: myTextStyle),
          ),
          Container(
            color: Colors.yellow,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  3,
                  (i) => ElevatedButton(
                      onPressed: () => context.read<AppState>().setSize(i + 3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${i + 3} X ${i + 3}',
                          style: myTextStyle,
                        ),
                      ))),
            ),
          ),
        ],
        // children: children,
      ),
    );
  }
}
