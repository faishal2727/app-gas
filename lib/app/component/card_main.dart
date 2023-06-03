import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../data/model/gas.dart';
import '../data/model/gas_model.dart';
import '../routes/app_pages.dart';

class Card_Gas extends StatelessWidget {

  Gas gas;

  Card_Gas({
    super.key,
    required this.gas,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("LOG_$gas");
        Get.toNamed(Routes.DETAIL, arguments: gas);
      },
      child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: Text('data'),
            child: Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(gas.image, width: 100,),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    gas.gasName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(gas.size),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
