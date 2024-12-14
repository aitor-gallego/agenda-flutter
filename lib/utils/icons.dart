import 'package:flutter/material.dart';

IconData icons(String value) {
  IconData icon = Icons.question_mark;
  switch (value) {
    case "amistad":
      icon = Icons.emoji_emotions;
      break;
    case "familia":
      icon = Icons.family_restroom;
      break;
    case "trabajo":
      icon = Icons.business;
      break;
    case "deporte":
      icon = Icons.fitness_center;
      break;
  }
  return icon;
}
