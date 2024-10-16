import 'dart:math';

class Dice {
  final int numberOfDice;
  final List<int?> _values;
  final List<bool> _held;
  int rolls = 0;

  Dice(this.numberOfDice)
      : _values = List<int?>.filled(numberOfDice, 0),
        _held = List<bool>.filled(numberOfDice, false);

  List<int?> get values => _values;

  void roll() {
    if (rolls < 3) {
      for (int i = 0; i < _values.length; i++) {
        if (!_held[i]) {
          _values[i] = Random().nextInt(6) + 1;
        }
      }
      rolls++;
    }
  }

  void toggleHold(int index) {
    _held[index] = !_held[index];
  }

  void clear() {
    for (var i = 0; i < _values.length; i++) {
      _values[i] = 0;
      _held[i] = false;
    }
  }

  bool isHeld(int index) {
    return _held[index];
  }
}
