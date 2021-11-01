import 'package:flutter/material.dart';
import 'package:twenty_fourty_eight_kannada/grid-properties.dart';
import 'package:twenty_fourty_eight_kannada/util.dart';

class BestScore extends StatefulWidget {
  int value = 0;
  BestScore({Key key, this.value}) : super(key: key);

  @override
  _BestScoreState createState() => _BestScoreState();
}

class _BestScoreState extends State<BestScore> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ಅತ್ಯುತ್ತಮ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[50],
                  fontSize: 14,
                  fontFamily: "NudiKannada",
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Text(
                replaceWithKannadaNumber("${widget.value}"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontSize: 22 /
                        (widget.value.toString().length > 3
                            ? (widget.value.toString().length * 0.30)
                            : 1),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
