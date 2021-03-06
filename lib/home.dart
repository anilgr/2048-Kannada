import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:twenty_fourty_eight_kannada/best-score.dart';
import 'package:twenty_fourty_eight_kannada/credits.dart';
import 'package:twenty_fourty_eight_kannada/grid-properties.dart';
import 'package:twenty_fourty_eight_kannada/grid.dart';
import 'package:twenty_fourty_eight_kannada/instructions.dart';
import 'package:twenty_fourty_eight_kannada/preference.dart';
import 'package:twenty_fourty_eight_kannada/score.dart';
import 'package:twenty_fourty_eight_kannada/title.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  GlobalKey<TwentyFortyEightState> twentyFortyEightKey = GlobalKey();
  GlobalKey<ScoreState> scoreKey = GlobalKey();

  int bestScore = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    Preference.load().then((prefs) {
      int score = prefs.getInt("best_score");
      this.setState(() {
        this.bestScore = score == null ? 0 : score;
      });
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Preference.load().then(
        (prefs) async => await prefs.setInt('best_score', this.bestScore));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = screenWidth <= 375 ? 0.9 : 1;
    return Scaffold(
        backgroundColor: tan,
        body: SafeArea(
          child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: tan,
                // border: Border.all(width: 2, color: Colors.greenAccent)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // decoration: BoxDecoration(color: Colors.red),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0 * (screenWidth >= 768 ? 2.0 : 0)),
                    child: Column(
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
                                            (screenWidth / 100) *
                                            (screenWidth <= 280 ? 0.9 : 1.0),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Score(
                                key: this.scoreKey,
                                onAnimationComplete: () {
                                  if (this.score > this.bestScore) {
                                    setState(() {
                                      this.bestScore = this.score;
                                    });
                                  }
                                },
                              ),
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 14),
                                      textStyle: TextStyle(
                                          fontSize: fontScaleFactor *
                                              16.0 *
                                              (MediaQuery.of(context)
                                                          .size
                                                          .width >=
                                                      768
                                                  ? 2.0
                                                  : 1.0),
                                          fontFamily: 'NudiKannada',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () => {
                                          this.setState(() {
                                            this
                                                .twentyFortyEightKey
                                                .currentState
                                                .won = false;
                                            this
                                                .twentyFortyEightKey
                                                .currentState
                                                .setupNewGame();
                                          })
                                        },
                                    child: Text("????????? ??????")),
                              )
                            ],
                          ),
                        ),
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
                  Expanded(
                    flex: 0,
                    child: Container(
                      // decoration: BoxDecoration(color: Colors.red),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: (screenWidth >= 768 ? 32.0 : 0.0)),
                        child: Column(
                          children: [Instructions(), Credits()],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
