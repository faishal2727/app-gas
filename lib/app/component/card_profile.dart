import 'package:flutter/material.dart';

import '../theme/colors.dart';


class Card_Profile extends StatelessWidget {
  const Card_Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(10),
      child: Icon(
        Icons.settings,
        color: primaryColor,
      ),
    );
  }
}
