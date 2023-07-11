import 'package:flutter/material.dart';
import 'package:gas_ku/app/data/model/inventory.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../component/arrow_back.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/colors.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: bodyHeight * 0.1,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Arrow_Back(),
                  ),
                  Text(
                    'Riwayat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.short_text_outlined,
                        color: bgColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                width: Get.width,
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Lottie.asset('assets/lottie/load.json',
                          width: 100, height: 100),
                    );
                  } else if (controller.history.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Center(
                        child: Column(
                          children: [
                            Lottie.asset('assets/lottie/not-result.json',
                                width: 250, height: 250),
                            Text(
                              "Hmmm ... Sepertinya Data Tidak Ada",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: controller.history.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card_History(
                            history: controller.history[index],
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Card_History extends StatelessWidget {
  final Inventory history;

  Card_History({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(4, 8), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Laporan hari: ${history.createdAt.toUtc().toString().substring(0, 16)}"),
            Text("Gas Ijo: ${history.gasIjo}"),
            Text("Bright Gas: ${history.brightGas}"),
            Text("Blue Gas: ${history.blueGas}"),
          ],
        ),
      ),
    );
  }
}
