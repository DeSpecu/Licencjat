import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:licencjat/src/theme.dart';
import 'package:provider/provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';


class OfertyPage extends StatelessWidget {
  OfertyPage({super.key});

  Future<Map<String, double>> data() async{
    final url = Uri.parse("https://it.pracuj.pl/praca/warszawa;wp?rd=100&et=17&itth=75%2C212%2C77%2C54%2C41%2C39%2C35%2C38%2C33%2C43%2C209%2C40%2C37%2C76%2C126%2C36%2C84");
    final wynik = await http.get(url);
    dom.Document html = dom.Document.html(wynik.body);

    final technologie = html.querySelectorAll(".tiles_bo3lbgx > span").map((e) => e.innerHtml.trim()).toList();
    Map<String, double> mapa = {};
    List<String> s = [];
    List<String> filtr = [".NET", "Android", "Angular", "C", "C++", "C#", "CSS", "Java",
    "JavaScript", "Kotlin", "Linux", "PHP", "Python", "React.js",
    "React Native", "SQL", "Vue.js"];
    for(var x in technologie) {
      if(filtr.contains(x)) {
        s.add(x);
      }
    }
    log(s.length.toString());
    for(var x in s){
      if(mapa[x]==null){
        mapa[x]=0;
      }
      else {
        mapa[x] = s.where((element) => element == x).length.toDouble();
      }
    }
    return mapa;
  }

  late Future<Map<String, double>> futureData = data();
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
          child: FutureBuilder<Map<String, double>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return PieChart(
                  dataMap: snapshot.data!,
                  chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
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