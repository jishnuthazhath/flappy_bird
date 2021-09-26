// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool isGameStarted = false;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });

      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.05;
        }
      });

      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3.5;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYaxis > 1) {
        timer.cancel();
        isGameStarted = false;
      }

      if (isBirdDead()) {
        _showDialog();
      }
    });
  }

  void resetGame() {
    Navigator.pop(context); // dismisses the alert dialog
    setState(() {
      birdYaxis = 0;
      isGameStarted = false;
      time = 0;
      initialHeight = birdYaxis;
      barrierXOne = 2;
      barrierXTwo = 2 + 1.5;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  bool isBirdDead() {
    if (birdYaxis <= -1 || birdYaxis > 1) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isGameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(children: [
                AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  duration: Duration(milliseconds: 0),
                  color: Colors.blue,
                  child: Bird(),
                ),
                Container(
                  alignment: Alignment(0, -0.3),
                  child: isGameStarted
                      ? Text(" ")
                      : Text(
                          "T A P  T O  P L A Y",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
                AnimatedContainer(
                    duration: Duration(microseconds: 0),
                    alignment: Alignment(barrierXOne, 1.1),
                    child: Barriers(
                      size: 170.0,
                    )),
                AnimatedContainer(
                    duration: Duration(microseconds: 0),
                    alignment: Alignment(barrierXOne, -1.1),
                    child: Barriers(
                      size: 150.0,
                    )),
                AnimatedContainer(
                    duration: Duration(microseconds: 0),
                    alignment: Alignment(barrierXTwo, 1.1),
                    child: Barriers(
                      size: 250.0,
                    )),
                AnimatedContainer(
                    duration: Duration(microseconds: 0),
                    alignment: Alignment(barrierXTwo, -1.1),
                    child: Barriers(
                      size: 200.0,
                    )),
              ]),
            ),
            Container(height: 15, color: Colors.green),
            Expanded(
              child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SCORE",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "0",
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "BEST",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "0",
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
