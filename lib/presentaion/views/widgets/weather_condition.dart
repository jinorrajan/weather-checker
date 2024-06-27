import 'package:flutter/widgets.dart';

import '../../../utlis/constants/colors/colors.dart';

class WeatherCondition extends StatelessWidget {
  final String text;
  final String num;
  const WeatherCondition({
    super.key,
    required this.text,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            text,
            style: TextStyle(color: Ccolors().whiteColor, fontSize: 13),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          num,
          style: TextStyle(
              color: Ccolors().whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}