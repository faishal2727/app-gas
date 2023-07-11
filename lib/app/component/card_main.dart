import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/gas.dart';
import '../routes/app_pages.dart';

class CardGas extends StatelessWidget {
  final Gas gas;

  CardGas({
    required this.gas,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("LOG_$gas");
        Get.toNamed(Routes.DETAIL, arguments: gas);
      },
      child: Card(
        margin: EdgeInsets.only(top: 10),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/bg_card2.png'),
              fit: BoxFit.cover,
            ), 
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'data_${gas.id}',
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(gas.image),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        gas.gasName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(gas.size),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
