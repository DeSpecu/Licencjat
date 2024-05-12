import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:licencjat/src/theme.dart';
import 'package:provider/provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';


class OfertyPage extends StatelessWidget {
  OfertyPage({super.key});

  Future<List<String>> data() async{
    final url = Uri.parse("https://it.pracuj.pl/praca/warszawa;wp?rd=100&et=17&itth=75%2C212%2C77%2C54%2C41%2C39%2C35%2C38%2C33%2C43%2C209%2C40%2C37%2C76%2C126%2C36%2C84");
    final wynik = await http.get(url);
    dom.Document html = dom.Document.html(wynik.body);

    final technologie = html.querySelectorAll(".tiles_bo3lbgx > span").map((e) => e.innerHtml.trim()).toList();

    return technologie;
  }

  late Future<List<String>> futureData = data();
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
              icon: Icon(themeNotifier.isDark ? Icons.sunny : Icons.dark_mode))
          ],
        ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PieChart(
                dataMap: {"tak":0},
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: <Color>[
                  Colors.greenAccent,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "HYBRID",
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
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