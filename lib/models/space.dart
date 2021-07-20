class Space {
  Space(this.id, this.x, this.y);
  final int id; // original last value of cells
  int x; // current row of Space
  int y; // current column of Space
  var dx =
      0; // number of steps along x-direction, +/= signs represent opposite directions
  var dy =
      0; // number of steps along y-direction, +/= signs represent opposite directions
}
