import 'package:flutter/material.dart';
import '../theme/colors.dart';

class Arrow_Back extends StatelessWidget {
  const Arrow_Back({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: itemColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10),
      child: Icon(
        Icons.arrow_back_ios_new_sharp,
        color: primaryColor,
      ),
    );
  }
}
