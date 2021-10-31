import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:twenty_fourty_eight_kannada/grid-properties.dart';
import 'package:twenty_fourty_eight_kannada/grid.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController controller;
  // double floatScoreOffset = 0.0;
  int animatedScore = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    this.controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    // this.translateScore = new Tween(begin: -1.0, end: 1.0).animate(controller);
    this.controller.forward();
    this.controller.addListener(() {
      setState(() {
        // this.floatScoreOffset = this.controller.value;
        if (this.controller.isCompleted) {
          this.score += this.animatedScore;
        }
      });
    });
  }

  void addScore() {}

  @override
  Widget build(BuildContext context) {
    final buttonColor = Colors.brown[200];
    return Scaffold(
        body: SafeArea(
      child: Container(
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: tan,
          ),
          // border: Border.all(color: Colors.black38, width: 2.0)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1),
                            // color: Colors.yellow[700]
                            ),
                        child: Text(
                          "2048",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 48,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      // width: 100,
                      // height: 50,
                      margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(3.0))),
                      child: ConstrainedBox(
                        constraints: new BoxConstraints(minWidth: 100),
                        child: Column(
                          children: [
                            Text(
                              "SCORE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Text(
                                  "${this.score}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                Positioned(
                                    bottom:
                                        (-40.0 * (1 - this.controller.value))
                                            .toDouble(),
                                    child: Opacity(
                                      opacity: 1 - this.controller.value,
                                      child: Text(
                                        "+${this.animatedScore}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // width: 100,
                      // height: 50,
                      margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(3.0))),
                      child: ConstrainedBox(
                        constraints: new BoxConstraints(minWidth: 100),
                        child: Column(
                          children: [
                            Text(
                              "BEST",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[50],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "400",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      // padding: const EdgeInsets.all(8.0),
                      child: Container(
                          // decoration:
                          //     BoxDecoration(border: Border.all(width: 1)),
                          margin: EdgeInsets.all(4),
                          child: RichText(
                            text: TextSpan(
                              text: 'Join the numbers and get to the ',
                              style: TextStyle(
                                  color: Colors.brown[400],
                                  fontSize: 18,
                                  height: 1.5),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '2048 tile !',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: ' world!'),
                              ],
                            ),
                          )),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 150, minHeight: 42),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.all(8),
                            backgroundColor: Colors.brown[300],
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => {
                                this.setState(() {
                                  this.animatedScore += 100000;
                                  this.controller.reset();
                                  this.controller.forward();
                                })
                              },
                          child: Text("New Game")),
                    )
                  ],
                ),
              ),
              TwentyFortyEight()
            ],
          )),
    ));
  }
}
