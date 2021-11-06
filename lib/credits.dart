import 'package:flutter/material.dart';

// import 'package:twenty_fourty_eight_kannada/grid-properties.dart';
class Credits extends StatelessWidget {
  const Credits({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
          // decoration: BoxDecoration(border: Border.all()),
          child: RichText(
              text: TextSpan(children: [
        TextSpan(
            style: TextStyle(
                color: Colors.brown[500],
                fontSize: 10 *
                    (MediaQuery.of(context).size.width >= 768 ? 2.0 : 1.0)),
            text:
                "Cloned to Kannada by Anil G.R. | Created by Gabriele Cirulli. Based on 1024 by Veewo Studio and conceptually similar to Threes by Asher Vollmer.")
      ]))),
    );
  }
}
