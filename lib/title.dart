import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.all(8),
          child: RichText(
            text: TextSpan(
              text: 'ಸಂಖ್ಯೆಗಳನ್ನು ಜೋಡಿಸಿ',
              style: TextStyle(
                color: Colors.brown[400],
                fontFamily: 'NudiKannada',
                // fontSize: 6 * (MediaQuery.of(context).devicePixelRatio),
                fontSize:
                    18 * (MediaQuery.of(context).size.width >= 768 ? 2.0 : 1.0),
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
