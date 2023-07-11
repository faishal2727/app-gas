import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gas_ku/app/component/card_visualisasi.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../component/card_deteksi.dart';
import '../../../component/card_history.dart';
import '../../../component/card_main.dart';
import '../../../component/card_profile.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: secondaryColor,
              height: bodyHeight * .1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.cdate.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hai,',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              ' Selamat Datang',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: Card_Profile(),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              height: bodyHeight * .9,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: bgColor),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Text(
                        'Menu Utama',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Row(
                      children: [
                        Card_History(),
                        Card_Vis(),
                        Card_Deteksi(),
                      ],
                    ),
                    Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.withOpacity(0.3),
                            Colors.transparent,
                            Colors.grey.withOpacity(0.3),
                          ],
                          stops: [0, 0.5, 1],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        'Daftar Gas',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return Padding(
                            padding: const EdgeInsets.all(130.0),
                            child: Center(
                              child: Lottie.asset('assets/lottie/load.json',
                                  width: 100, height: 100),
                            ),
                          );
                        } else if (controller.gas.isEmpty) {
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
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.gas.length,
                            itemBuilder: (context, index) {
                              return CardGas(gas: controller.gas[index]);
                            },
                          );
                        }
                      },
                    ),
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
