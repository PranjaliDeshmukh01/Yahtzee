import 'package:cs442_mp3/models/scorecard.dart';
import 'package:flutter/material.dart';

class FinalScoreWidget extends StatelessWidget {
  final ScoreCard scoreCard;

  const FinalScoreWidget({super.key, required this.scoreCard});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: const Color.fromARGB(255, 17, 39, 99),
      child: Container(
        margin: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Current Score',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '${scoreCard.total}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
