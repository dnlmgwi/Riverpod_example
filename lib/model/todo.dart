
import 'dart:math';

import 'package:flutter/cupertino.dart';

@immutable
class TodoModel {
  final String title;
  final bool isCompleted;

  const TodoModel({required this.title, required this.isCompleted});

  TodoModel copyWith({
    String? title,
    bool? isCompleted,
}) {
    return TodoModel(title: title ?? this.title, isCompleted: isCompleted ?? this.isCompleted);
  }
}

String getRandomString(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  return List.generate(length, (index) => charset[random.nextInt(charset.length)]).join();
}