import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_ff/const.dart';
import 'package:game_ff/util/number_key.dart';
import 'package:game_ff/util/result_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//number pad
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',
  ];

  int numberA = 1;
  int numberB = 1;

//user answer
  String userAnswer = '';

// user tapped a button
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        //calculate if user is correct or incorect
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        userAnswer += button;
      }
    });
  }

  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
                message: 'Correct!',
                icon: Icons.arrow_forward,
                onTap: goToNextQuestion);
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Sorry try again',
              icon: Icons.arrow_back,
              onTap: goBackToQuestion,
            );
          });
    }
  }

  //create random numbers
  var randomNumber = Random();

  void goToNextQuestion() {
    Navigator.of(context).pop();

    setState(() {
      userAnswer = '';
    });

    //create a new question
    numberA = randomNumber.nextInt(100);
    numberB = randomNumber.nextInt(100);
  }

  void goBackToQuestion() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //question
                    Text(
                      numberA.toString() + ' + ' + numberB.toString() + ' = ',
                      style: whihteTextStyle,
                    ),

                    // answer box
                    Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.lime,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: whihteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            // mark
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                itemCount: numberPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return NumberKey(
                    child: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
