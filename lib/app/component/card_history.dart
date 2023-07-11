import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../routes/app_pages.dart';
import '../theme/colors.dart';

class Card_History extends StatelessWidget {
  const Card_History({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.HISTORY),
          child: Container(
             decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/image/uye1.png'),
              fit: BoxFit.cover,
            ), 
               color: secondaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_edu,
                    color: Colors.white,
                    size: 40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'History',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
