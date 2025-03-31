import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:licencjat/model/theme.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import '../model/Oferty.dart';

class OfertyPage extends StatelessWidget {
  static const colors = <Color>[Color(0xff003f5c),Color(0xff2f4b7c),Color(0xff665191),
  Color(0xffa05195), Color(0xffd45087), Color(0xfff95d6a), Color(0xffff7c43), Color(0xffffa600),
  Color(0xdd00876c), Color(0xdd4c9973), Color(0xdd76aa7d), Color(0xdd9bbb8b), Color(0xddbdcc9d),
  Color(0xdddddeb3), Color(0xddfbf1cc), Color(0xddf3d8a9), Color(0xddedbd8a), Color(0xdde9a171), Color(0xdde4835f),
  Color(0xdddd6354), Color(0xddd43d51)];

  OfertyPage({super.key});

  late Future<Map<String, double>> futureData = Oferty.data();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(builder: (context, ModelTheme themeNotifier, child){
      return Scaffold(
          appBar: AppBar(
            title: const Text("Oferty"),
            automaticallyImplyLeading: false,
            actions: [IconButton(onPressed: () {
              themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
              },
                icon: Icon(themeNotifier.isDark ? Icons.sunny : Icons.dark_mode)),
              IconButton(onPressed: () {
                themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
              },
                  icon: Icon(themeNotifier.isDark ? Icons.sunny : Icons.dark_mode))
            ],
          ),
        body: Center(
          child: FutureBuilder<Map<String, double>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PieChart(
                  dataMap: snapshot.data!,
                  chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true,
                  showChartValueBackground: false),
                  legendOptions: const LegendOptions(legendPosition: LegendPosition.bottom, showLegendsInRow: true),
                  colorList: colors,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      );
  });
  }
}