import 'package:flutter/material.dart';

Map<int, List<String>> chipData = {
  5: ["Excellent!", "Superb!", "Marvellous!", "Wonderful!", "Sharing It Now!"],
  4: ["Great!", "Worth", "Very Good", "Satisfactory"],
  3: ["Not Bad", "Good", "Ok", "Acceptable"],
  2: ["Unhappy", "Worse", "Could Improve", "Not Satisfied"],
  1: ["Worst", "Bad", "Poor", "Terrible"]
};
Map<int, IconData> emojis = {
  5: Icons.sentiment_very_satisfied_rounded,
  4: Icons.sentiment_satisfied_rounded,
  3: Icons.sentiment_neutral_rounded,
  2: Icons.sentiment_dissatisfied_rounded,
  1: Icons.sentiment_very_dissatisfied_rounded,
};
Map<int, Color> emojiColor = {
  5: Colors.green.shade900,
  4: Colors.lightGreen.shade400,
  3: Colors.amber,
  2: Colors.orange.shade800,
  1: Colors.red,
};
