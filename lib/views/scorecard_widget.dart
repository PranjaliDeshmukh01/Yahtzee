import 'package:cs442_mp3/models/dice.dart';
import 'package:cs442_mp3/models/scorecard.dart';
import 'package:flutter/material.dart';

class ScorecardWidget extends StatefulWidget {
  final ScoreCard scoreCard;
  final Function(ScoreCategory) selectCategory;
  final Dice dice;

  const ScorecardWidget({
    super.key,
    required this.scoreCard,
    required this.selectCategory,
    required this.dice,
  });

  @override
  _ScorecardWidgetState createState() => _ScorecardWidgetState();
}

class _ScorecardWidgetState extends State<ScorecardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryColumn(ScoreCategory.values.take(6)),
            _buildCategoryColumn(ScoreCategory.values.skip(6)),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryColumn(Iterable<ScoreCategory> categories) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categories.map((category) => _buildScoreRow(category)).toList(),
    );
  }

  Widget _buildScoreRow(ScoreCategory category) {
    bool canSelectScore = !widget.scoreCard.completed &&
        widget.dice.rolls > 0 &&
        widget.scoreCard[category] == null;

    return Card(
      elevation: 8,
      child: Row(
        children: [
          _buildCategoryLabel(category),
          const SizedBox(width: 20),
          _buildScoreOrButton(category, canSelectScore),
        ],
      ),
    );
  }

  Widget _buildCategoryLabel(ScoreCategory category) {
    return SizedBox(
      width: 150,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(category.name),
      )),
    );
  }

  Widget _buildScoreOrButton(ScoreCategory category, bool canSelectScore) {
    return widget.scoreCard[category] != null
        ? _buildScoreDisplay('${widget.scoreCard[category]}')
        : _buildPickButton(canSelectScore, category);
  }

  Widget _buildScoreDisplay(String score) {
    return SizedBox(
      width: 70,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(score, style: const TextStyle(fontSize: 16)),
      )),
    );
  }

  Widget _buildPickButton(bool canSelectScore, ScoreCategory category) {
    return SizedBox(
      width: 90,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed:
              canSelectScore ? () => widget.selectCategory(category) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          child: const Text('Pick', style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}
