import 'package:flutter/material.dart';

// import 'package:twenty_fourty_eight_kannada/grid-properties.dart';
class Instructions extends StatelessWidget {
  const Instructions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
          // decoration: BoxDecoration(border: Border.all()),
          child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                TextSpan(
                    style: TextStyle(
                        color: Colors.brown[500],
                        fontFamily: 'NudiKannada',
                        fontSize: 18 *
                            (screenWidth >= 768
                                ? 2.0
                                : screenWidth <= 375
                                    ? 0.7
                                    : 1.0)),
                    text:
                        "ಹೇಗೆ ಆಡುವುದು: ಅಂಚುಗಳನ್ನು ಸರಿಸಲು ಸ್ವೈಪ್ ಮಾಡಿ. ಒಂದೇ ಸಂಖ್ಯೆಯ ಎರಡು ಅಂಚುಗಳು ತಾಗಿದಾಗ ಅವುಗಳು ಒಂದಾಗಿ, ಸಂಖ್ಯೆಗಳು ಕೂಡುತ್ತವೆ !")
              ]))),
    );
  }
}
//ಅಂಚುಗಳನ್ನು ಸರಿಸಲು ಸ್ವೈಪ್ ಮಾಡಿ. ಒಂದೇ ಸಂಖ್ಯೆಯ ಎರಡು ಅಂಚುಗಳು ಸ್ಪರ್ಶಿಸಿದಾಗ, ಅವು ಒಂದರಲ್ಲಿ ವಿಲೀನಗೊಳ್ಳುತ್ತವೆ !
  