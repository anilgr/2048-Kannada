import 'package:flutter/material.dart';
import 'package:twenty_fourty_eight_kannada/grid-properties.dart';
import 'package:twenty_fourty_eight_kannada/util.dart';

class Score extends StatefulWidget {
  final Function onAnimationComplete;
  Score({Key key, this.onAnimationComplete}) : super(key: key);

  @override
  ScoreState createState() => ScoreState();
}

class ScoreState extends State<Score> with TickerProviderStateMixin {
  AnimationController controller;
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
          if (widget.onAnimationComplete != null) widget.onAnimationComplete();
          this.score += this.animatedScore;
        }
      });
    });
  }

  void setScore(int score) {
    setState(() {
      this.controller.forward(from: 0);
      this.animatedScore = (score - this.score);
    });
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: ConstrainedBox(
        constraints: new BoxConstraints(minHeight: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "ಅಂಕಗಳು",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 14,
                  fontFamily: "NudiKannada",
                  fontWeight: FontWeight.w700),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    replaceWithKannadaNumber("${this.score}"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontSize: 22 /
                            (this.score.toString().length > 3
                                ? (this.score.toString().length * 0.30)
                                : 1),
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Positioned(
                    bottom: (-40.0 * (1 - this.controller.value)).toDouble(),
                    child: Opacity(
                      opacity: 1 - this.controller.value,
                      child: Text(
                        "+${replaceWithKannadaNumber("${this.animatedScore}")}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 22 /
                                (this.animatedScore.toString().length > 3
                                    ? (this.animatedScore.toString().length *
                                        0.2)
                                    : 1),
                            fontWeight: FontWeight.w700),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
