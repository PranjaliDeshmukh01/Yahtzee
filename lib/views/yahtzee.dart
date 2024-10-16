import 'package:cs442_mp3/models/dice.dart';
import 'package:cs442_mp3/models/scorecard.dart';
import 'package:cs442_mp3/views/dicedisplay_widget.dart';
import 'package:cs442_mp3/views/finalscore_widget.dart';
import 'package:cs442_mp3/views/scorecard_widget.dart';
import 'package:flutter/material.dart';

class Yahtzee extends StatefulWidget {
  const Yahtzee({super.key});

  @override
  _YahtzeeState createState() => _YahtzeeState();
}

class _YahtzeeState extends State<Yahtzee> {
  Dice dice = Dice(5);
  ScoreCard scoreCard = ScoreCard();
  int _rollsLeft = 3;
  int get rollsLeft => _rollsLeft;
  int _currentRound = 1;

  Map<ScoreCategory, int?> _rounds = {
    ScoreCategory.ones: null,
    ScoreCategory.twos: null,
    ScoreCategory.threes: null,
    ScoreCategory.fours: null,
    ScoreCategory.fives: null,
    ScoreCategory.sixes: null,
    ScoreCategory.threeOfAKind: null,
    ScoreCategory.fourOfAKind: null,
    ScoreCategory.smallStraight: null,
    ScoreCategory.largeStraight: null,
    ScoreCategory.chance: null,
    ScoreCategory.fullHouse: null,
    ScoreCategory.yahtzee: null,
  };

  void _initializeGame() {
    setState(() {
      _currentRound = 1;
      _rollsLeft = 3;
      _rounds.updateAll((key, value) => null); // Reset all round values to null
      scoreCard.clear();
      dice.clear();
    });
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  void startNewRound() {
    setState(() {
      if (_currentRound <= 13) {
        _rollsLeft = 3;
        dice.clear();
      } else {
        final totalScore = scoreCard.total;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: Text('Your total score is $totalScore'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: const Text('Play Again!'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _selectCategory(ScoreCategory category) {
    setState(() {
      if (dice.rolls == 0) {
        return;
      }
      if (_rounds[category] == _currentRound) {
        return;
      }
      scoreCard.registerScore(category, dice.values);
      dice.clear();
      dice.rolls = 0;
      _rounds[category] = _currentRound;
      _currentRound++;
      startNewRound();
    });
  }

  void rollDice() {
    if (_rollsLeft > 0) {
      setState(() {
        final List<int?> originalValues = List.from(dice.values);
        dice.roll();
        for (int i = 0; i < 5; i++) {
          if (dice.isHeld(i)) {
            dice.values[i] = originalValues[i] ?? 0;
          }
        }
        _rollsLeft--;

        if (_rollsLeft == 0) {}
      });
    }
  }

  void _holdDice(int index) {
    setState(() {
      dice.toggleHold(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to set the padding and dimensions based on screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 10, 31, 90),
        foregroundColor: Colors.white,
        title: const Text(
          "Yahtzee",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Make the Column scrollable
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 10),
              DiceDisplayWidget(dice: dice, holdDice: _holdDice),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: rollsLeft > 0 ? rollDice : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(rollsLeft > 0
                    ? 'Roll the Dice ($_rollsLeft)'
                    : 'No More Rolls!!'),
              ),
              const SizedBox(height: 10),
              ScorecardWidget(
                  scoreCard: scoreCard,
                  selectCategory: _selectCategory,
                  dice: dice),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FinalScoreWidget(scoreCard: scoreCard),
                  const SizedBox(width: 50),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(16.0),
                    child: TextButton.icon(
                      onPressed: () {
                        _resetGame();
                      },
                      icon: const Icon(
                        Icons.restore,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Reset Game',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 23, 54, 138),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
