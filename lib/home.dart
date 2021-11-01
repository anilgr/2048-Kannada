import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:twenty_fourty_eight_kannada/best-score.dart';
import 'package:twenty_fourty_eight_kannada/credits.dart';
import 'package:twenty_fourty_eight_kannada/grid-properties.dart';
import 'package:twenty_fourty_eight_kannada/grid.dart';
import 'package:twenty_fourty_eight_kannada/instructions.dart';
import 'package:twenty_fourty_eight_kannada/score.dart';
import 'package:twenty_fourty_eight_kannada/title.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// class _HomeState extends State<Home> with RestorationMixin {
class _HomeState extends State<Home> {
  GlobalKey<TwentyFortyEightState> twentyFortyEightKey = GlobalKey();
  GlobalKey<ScoreState> scoreKey = GlobalKey();
  // RestorableInt bestScore = RestorableInt(0);
  int bestScore = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // this.bestScore.dispose();
    super.dispose();
  }

  // @override
  // String get restorationId => "best-score";

  // @override
  // void restoreState(RestorationBucket oldBucket, bool initialRestore) {
  //   registerForRestoration(this.bestScore, this.restorationId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tan,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: tan,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(),
                              child: Text(
                                "\u{0CE8}\u{0CE6}\u{0CEA}\u{0CEE}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    letterSpacing: 5,
                                    color: Colors.black54,
                                    fontSize: 12 *
                                        (MediaQuery.of(context).size.width /
                                            100),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Score(
                            key: this.scoreKey,
                            onAnimationComplete: () {
                              // if (this.score > this.bestScore.value) {
                              if (this.score > this.bestScore) {
                                setState(() {
                                  // this.bestScore.value = this.score;
                                  this.bestScore = this.score;
                                });
                              }
                            },
                          ),
                          // BestScore(value: this.bestScore.value),
                          BestScore(value: this.bestScore),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GameTitle(),
                          Container(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.brown[300],
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 14),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'NudiKannada',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => {
                                      this.setState(() {
                                        this
                                            .twentyFortyEightKey
                                            .currentState
                                            .setupNewGame();
                                      })
                                    },
                                child: Text("ಹೊಸ ಆಟ")),
                          )
                        ],
                      ),
                    ),
                    TwentyFortyEight(
                      key: twentyFortyEightKey,
                      onScoreChange: (score) => {
                        this.score = score,
                        this.scoreKey.currentState.setScore(score)
                      },
                    ),
                    Instructions(),
                    Credits()
                  ],
                )),
          ),
        ));
  }
}
