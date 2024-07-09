import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake.io/logic/shared_pref.dart';
import 'package:snake.io/screens/home_screen.dart';
import 'package:snake.io/provider/color_provider_list.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List snakePostion = [45, 65, 85, 105, 125];
  int numOfSquares = 840;
  static var randomNum = Random();
  int food = randomNum.nextInt(700);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame();
  }

  void genrateNewFood() {
    food = randomNum.nextInt(700);
  }

  void startGame() async {
    snakePostion = [45, 65, 85, 105, 125];
    // var timeStart = TimeOfDay.now();
    const duration = Duration(milliseconds: 400);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScrean();
      }
    });
  }

  var direction = 'down';
  updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePostion.last > numOfSquares) {
            snakePostion.add(snakePostion.last + 20 - numOfSquares);
          } else {
            snakePostion.add(snakePostion.last + 20);
          }
          break;
        case 'up':
          if (snakePostion.last < 20) {
            snakePostion.add(snakePostion.last - 20 + numOfSquares);
          } else {
            snakePostion.add(snakePostion.last - 20);
          }
          break;
        case 'left':
          if (snakePostion.last % 20 == 0) {
            snakePostion.add(snakePostion.last - 1 + 20);
          } else {
            snakePostion.add(snakePostion.last - 1);
          }
          break;
        case 'right':
          if ((snakePostion.last + 1) % 20 == 0) {
            snakePostion.add(snakePostion.last + 1 - 20);
          } else {
            snakePostion.add(snakePostion.last + 1);
          }
          break;
        default:
      }

      if (snakePostion.last == food) {
        genrateNewFood();
      } else {
        snakePostion.removeAt(0);
      }
    });
  }

  bool gameOver() {
    for (int i = 0; i < snakePostion.length; i++) {
      int count = 0;
      for (var j = 0; j < snakePostion.length; j++) {
        if (snakePostion[i] == snakePostion[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }

  _showGameOverScrean() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over ! 🙄'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Opps,it seems that you hitted urself'),
                Text(
                    'Your Score: ${snakePostion.length} \n Eaten Apples: ${snakePostion.length - 5} \n Earned Coins: ${(snakePostion.length - 5) * 6} \n Time Taken: --:--'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okk !'),
              onPressed: () {
                setCoin((snakePostion.length - 5) * 6);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (direction != 'up' && details.delta.dy > 0) {
                direction = 'down';
              } else if (direction != 'down' && details.delta.dy < 0) {
                direction = 'up';
              }
            },
            onHorizontalDragUpdate: (details) {
              if (direction != 'left' && details.delta.dx > 0) {
                direction = 'right';
              } else if (direction != 'right' && details.delta.dx < 0) {
                direction = 'left';
              }
            },
            child: FutureBuilder(
                future: getColor(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Container(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 20,
                      ),
                      itemCount: numOfSquares,
                      itemBuilder: (BuildContext context, int index) {
                        if (snakePostion.contains(index)) {
                          return Container(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  color: Color(colors[snapshot.data])),
                            ),
                          );
                        }

                        if (index == food) {
                          return Container(
                            padding: EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  color: Color.fromARGB(255, 154, 18, 0)),
                            ),
                          );
                        } else {
                          return Container(
                            padding: EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  color: Color.fromARGB(255, 45, 45, 45)),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }),
          )),
        ],
      ),
    );
  }
}
