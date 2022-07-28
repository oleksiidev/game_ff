import 'package:flutter/material.dart';
import 'package:game_ff/const.dart';

class NumberKey extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  var buttonColor = Colors.lightBlue;

  NumberKey({Key? key, required this.child, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == 'C') {
      buttonColor = Colors.yellow;
    } else if (child == 'DEL') {
      buttonColor = Colors.yellow;
    } else if (child == '=') {
      buttonColor = Colors.deepPurple;
    }
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              child,
              style: whihteTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
