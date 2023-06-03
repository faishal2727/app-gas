import 'dart:ffi';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrx_charts/mrx_charts.dart';
import '../../../component/arrow_back.dart';
import '../../../theme/colors.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../history/controllers/history_controller.dart';
import '../controllers/visualisasi_controller.dart';

class VisualisasiView extends GetView<VisualisasiController> {
  final dataKu = Get.put(HistoryController());

  VisualisasiView({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    final dataKu = Get.put(HistoryController());
    final xValues = List.generate(
      dataKu.history.length,
      (index) => index + 1,
    );

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
                    'Profile',
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
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: vis(xValues: xValues),
                  ),
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
  final List<int> xValues;

  vis({required this.xValues});

  @override
  Widget build(BuildContext context) {
    final dataKu = Get.find<HistoryController>();

    return Container(
      width: xValues.length * 120.0 +
          (xValues.length - 1) *
              16.0, // Lebar total grup batang termasuk margin antara grup batang
      height: 400,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.start,
          maxY: 300,
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
              margin: 10,
              reservedSize: 30,
              getTitles: (value) {
                if (value % 100 == 0) {
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
              margin: 10,
              rotateAngle: 90,
              getTitles: (value) {
                if (value < xValues.length) {
                  return dataKu.history[value.toInt()].createdAt.toString();
                }
                return '';
              },
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: List.generate(xValues.length, (index) {
            final gasIjoValue = double.parse(dataKu.history[index].gasIjo);
            final brightGasValue =
                double.parse(dataKu.history[index].brightGas);
            final blueGasValue = double.parse(dataKu.history[index].blueGas);

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
          groupsSpace: 16.0, // Menambahkan margin antara grup batang
        ),
      ),
    );
  }
}
