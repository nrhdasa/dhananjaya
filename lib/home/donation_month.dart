import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../resources/connectLottie.dart';
import '../resources/theme.dart';
import 'connection.dart';

class _DonationChart extends StatefulWidget {
  final Map<String, Map<String, double>> data;
  final List<Color> lineColors;

  const _DonationChart({required this.data, required this.lineColors});
  @override
  State<_DonationChart> createState() => _DonationChartState();
}

class _DonationChartState extends State<_DonationChart> {
  // const _DonationChart();
  var colors = lightColorScheme;
  double y_axis_steps = 5;
  double x_axis_steps = 5;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      Data1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get Data1 {
    return LineChartData(
        backgroundColor: colors.background,
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: x_axis_steps,
        minY: 0,
        maxY: y_axis_steps);
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: colors.onBackground.withOpacity(0.2),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              var num = ((listSteps.last / (y_axis_steps)) * spot.y).toStringAsFixed(2);
              return LineTooltipItem(
                '${num.toString()}\nL',
                TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
      );

  FlTitlesData get titlesData {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles,
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles(),
      ),
    );
  }

  List<LineChartBarData> get lineBarsData1 {
    List<LineChartBarData> chartBarData = [];
    int i = 0;
    widget.data.keys.forEach((element) {
      chartBarData.add(DonationChartBarData(element, widget.lineColors[i]));
      i += 1;
    });
    return chartBarData;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, List<double> listSteps) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    return Text(listSteps[value.toInt()].toStringAsFixed(2).toString() + "L");
  }

  List<double> get listSteps {
    final List<double> valuesList = widget.data.values.expand((entry) => entry.values).toList();
    double maxVal = 0;
    if (valuesList.length == 0) {
      maxVal = 0;
    } else {
      maxVal = valuesList.reduce((a, b) => a > b ? a : b);
    }

    List<double> listSteps = List.generate(y_axis_steps.toInt() + 1, (index) {
      double fraction = index / (y_axis_steps.toInt());
      double value = 0 + fraction * (maxVal - 0);
      return value / 100000;
    });
    return listSteps;
  }

  List<String> get previousSixMonths {
    List<String> months = [];
    DateTime currentDate = DateTime.now();

    for (int i = 1; i <= 6; i++) {
      DateTime previousMonthDate = currentDate.subtract(Duration(days: 30 * i));
      String monthAbbreviation = DateFormat('MMM').format(previousMonthDate);
      String yearAbbreviation = DateFormat('yy').format(previousMonthDate);
      String formattedDate = '$monthAbbreviation-$yearAbbreviation';
      months.add(formattedDate);
    }

    return months.reversed.toList();
  }

  List<FlSpot> graphData(company) {
    var months = previousSixMonths;
    double maxV = listSteps.last;
    List<FlSpot> data = [];
    for (int i = 0; i < previousSixMonths.length; i++) {
      if (widget.data[company]!.containsKey(previousSixMonths[i])) {
        double val = (y_axis_steps * (widget.data[company]![previousSixMonths[i]]! / 100000)) / maxV;
        data.add(FlSpot(i.toDouble(), val));
      } else {
        data.add(FlSpot(i.toDouble(), 0));
      }
    }
    return data;
  }

  SideTitles leftTitles() {
    return SideTitles(
      getTitlesWidget: (value, meta) {
        return leftTitleWidgets(value, meta, listSteps);
      },
      showTitles: true,
      interval: 1,
      reservedSize: 80,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(previousSixMonths[value.toInt()], style: style),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(drawHorizontalLine: true, drawVerticalLine: false, show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: colors.primary.withOpacity(0.9), width: 2),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData DonationChartBarData(String company, Color lineColor) {
    return LineChartBarData(
      // gradient: LinearGradient(colors: [colors.primary,colors.secondary]),
      isCurved: true,
      gradient: RadialGradient(
        focalRadius: 5,
        colors: [Colors.red, lineColor],
      ),
      // color: lineColor,
      barWidth: 5,
      isStrokeCapRound: true,
      isStrokeJoinRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: true),
      spots: graphData(company),
    );
  }
}

class DonationChart extends StatefulWidget {
  const DonationChart({super.key});

  @override
  State<StatefulWidget> createState() => DonationChartState();
}

class DonationChartState extends State<DonationChart> {
  // Map<String,Color> lineColors = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;

    return Container(
      height: 500,
      child: FutureBuilder<Map<String, Map<String, double>>>(
        future: getUserStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Color> lineColors = [Colors.amber.shade400, Colors.blueAccent.shade400, Colors.purple];
            List<Widget> indicatorWidgets = [];
            List<Widget> totalDonations = [];
            List<String> companies = snapshot.data!.keys.toList();
            Map<String, double> totalDonaitonCompnies = {};
            for (int i = 0; i < companies.length; i++) {
              totalDonaitonCompnies[companies[i]] = snapshot.data![companies[i]]!.values.reduce((value, element) => value + element);

              indicatorWidgets.add(Positioned(
                  right: 2 + (i) * 70,
                  top: 30,
                  child: Row(
                    children: [
                      Container(
                        height: 10,
                        width: 15,
                        decoration: BoxDecoration(color: lineColors[i], shape: BoxShape.rectangle),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        companies[i],
                      ),
                    ],
                  )));
            }
            for (int i = 0; i < companies.length; i++) {
              totalDonations.add(Column(
                children: [
                  Container(
                    // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: colors.tertiaryContainer, shape: BoxShape.rectangle),
                    child: Text(
                      "${(totalDonaitonCompnies[companies[i]]! / 100000).toStringAsFixed(2)} L",
                      style: texts.displaySmall!.copyWith(color: colors.onTertiaryContainer),
                    ),
                  ),
                  Text(
                    companies[i],
                    style: texts.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ));
            }

            return Stack(
              children: indicatorWidgets +
                  [
                    Column(
                      children: <Widget>[
                        Text(
                          'Monthly Donation',
                          style: TextStyle(
                            color: colors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // ConnectLottie()
                        Expanded(
                          child: Padding(padding: EdgeInsets.only(right: 20), child: _DonationChart(data: snapshot.data ?? {}, lineColors: lineColors)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: totalDonations,
                        ),
                        Text("Last 6 months")
                      ],
                    ),
                  ],
            );
          } else {
            return ConnectLottie();
          }
        },
      ),
    );
  }
}
