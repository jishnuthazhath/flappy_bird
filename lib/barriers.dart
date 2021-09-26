import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  final size;
  const Barriers({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: size,
        decoration: BoxDecoration(
            color: Colors.green,
            //border: Border.all(width: 10, color: Colors.green),
            borderRadius: BorderRadius.circular(15)));
  }
}
