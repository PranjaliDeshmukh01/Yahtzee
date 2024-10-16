import 'package:cs442_mp3/models/dice.dart';
import 'package:flutter/material.dart';

class DiceDisplayWidget extends StatelessWidget {
  final Dice dice;
  final Function(int) holdDice;

  const DiceDisplayWidget(
      {super.key, required this.dice, required this.holdDice});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              dice.numberOfDice,
              (index) => GestureDetector(
                onTap: () => holdDice(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: dice.isHeld(index) ? Colors.amber : Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: _buildDiceFace(dice.values[index]!),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Method to build the visual representation of a dice face
  Widget _buildDiceFace(int value) {
    List<Widget> dots = _getDots(value);
    return GridView.count(
      crossAxisCount: 3,
      children: dots,
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }

  // Returns a list of widgets representing the dots for each dice value
  List<Widget> _getDots(int value) {
    List<bool> positions = List.filled(9, false);

    switch (value) {
      case 1:
        positions[4] = true;
        break;
      case 2:
        positions[0] = true;
        positions[8] = true;
        break;
      case 3:
        positions[0] = true;
        positions[4] = true;
        positions[8] = true;
        break;
      case 4:
        positions[0] = true;
        positions[2] = true;
        positions[6] = true;
        positions[8] = true;
        break;
      case 5:
        positions[0] = true;
        positions[2] = true;
        positions[4] = true;
        positions[6] = true;
        positions[8] = true;
        break;
      case 6:
        positions[0] = true;
        positions[2] = true;
        positions[3] = true;
        positions[5] = true;
        positions[6] = true;
        positions[8] = true;
        break;
    }

    return positions
        .map((isDot) => Center(
              child: isDot
                  ? Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    )
                  : Container(),
            ))
        .toList();
  }
}
