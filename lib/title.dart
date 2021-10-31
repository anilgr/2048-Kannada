import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert' show utf8;

class GameTitle extends StatelessWidget {
  const GameTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.all(8),
          child:
              // Text(
              //   "Join the numbers and get to the  Join the numbers and get to the ",
              //   style:
              //       TextStyle(color: Colors.brown[400], fontSize: 18, height: 1.5),
              // )
              RichText(
            text: TextSpan(
              text: 'ಸಂಖ್ಯೆಗಳನ್ನು ಜೋಡಿಸಿ',
              style: TextStyle(
                color: Colors.brown[400],
                fontFamily: 'NudiKannada',
                // fontSize: 6 * (MediaQuery.of(context).devicePixelRatio),
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: ' \u{0CE8}\u{0CE6}\u{0CEA}\u{0CEE} ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily:
                            DefaultTextStyle.of(context).style.fontFamily)),
                TextSpan(text: 'ನ್ನು ಪಡೆಯಿರಿ!'),
              ],
            ),
          )),
    );
  }
}
