import 'dart:ffi';
import 'dart:math';
import 'package:pie_chart/pie_chart.dart' as uye;
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../component/arrow_back.dart';
import '../../../data/model/inventory.dart';
import '../../../theme/colors.dart';
import '../../history/controllers/history_controller.dart';
import '../controllers/visualisasi_controller.dart';

class VisualisasiView extends GetView<VisualisasiController> {
  VisualisasiView({Key? key});

  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Gas Elpiji Ijo": 255,
      "Bright Gas": 73,
      "Blue Gas": 42,
    };

    final colorList = <Color>[
      const Color.fromARGB(255, 118, 249, 67),
      const Color.fromARGB(255, 233, 65, 255),
      const Color.fromARGB(255, 65, 201, 255),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Arrow_Back(),
                  ),
                  Text(
                    'Visualisasi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_downward,
                      color: bgColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(14),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 130, vertical: 100),
                          child: Center(
                            child: Column(
                              children: [
                                Lottie.asset('assets/lottie/load.json',
                                    width: 100, height: 100),
                                Text(
                                  "Tunggu Sebentar ya ...",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (controller.history.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 130, vertical: 100),
                          child: Center(
                            child: Column(
                              children: [
                                Lottie.asset('assets/lottie/not-result.json',
                                    width: 200, height: 200),
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
                        return vis();
                      }
                    }),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              margin: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.stacked_bar_chart,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Detail Jumlah",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: uye.PieChart(
                          dataMap: dataMap,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          colorList: colorList,
                          chartType: ChartType.disc,
                        ),
                      ),
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

class vis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put(VisualisasiController());
      final history = controller.history;
      final xValues = List.generate(
        controller.history.length,
        (index) => index + 1,
      );
      return Container(
        width: max(xValues.length * 50.0, 0),
        height: 300,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceBetween,
            maxY: 300.0,
            minY: 0.0,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.blueGrey,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String title;
                  switch (rodIndex) {
                    case 0:
                      title = 'Gas Ijo: ${rod.y.toInt()}';
                      break;
                    case 1:
                      title = 'Bright Gas: ${rod.y.toInt()}';
                      break;
                    case 2:
                      title = 'Blue Gas: ${rod.y.toInt()}';
                      break;
                    default:
                      title = '';
                  }
                  return BarTooltipItem(
                    title,
                    TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                ),
                margin: 30,
                reservedSize: 30,
                getTitles: (value) {
                  if (value % 25 == 0) {
                    return value.toInt().toString();
                  }
                  return '';
                },
              ),
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                ),
                margin: 20,
                rotateAngle: 90,
                getTitles: (value) {
                  if (value < xValues.length) {
                    return history[value.toInt()]
                        .createdAt
                        .toUtc()
                        .toString()
                        .substring(0, 16);
                  }
                  return '';
                },
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: List.generate(xValues.length, (index) {
              final gasIjoValue = double.parse(history[index].gasIjo);
              final brightGasValue = double.parse(history[index].brightGas);
              final blueGasValue = double.parse(history[index].blueGas);

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    y: gasIjoValue,
                    colors: [Color.fromARGB(255, 118, 249, 67)],
                  ),
                  BarChartRodData(
                    y: brightGasValue,
                    colors: [Color.fromARGB(255, 233, 65, 255)],
                  ),
                  BarChartRodData(
                    y: blueGasValue,
                    colors: [Color.fromARGB(255, 65, 201, 255)],
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }
}
