import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:licencjat/src/theme.dart';
import 'package:provider/provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;


class OfertyPage extends StatelessWidget {
  OfertyPage({super.key});


  Future<List<String>> data() async{
    final url = Uri.parse("https://it.pracuj.pl/praca");
    final wynik = await http.get(url);
    dom.Document html = dom.Document.html(wynik.body);

    final technologie = html.querySelectorAll("div.c13gi8t > div.e1v45ci3 > div.ci1jlvv > div > span").map((e) => e.innerHtml.trim()).toList();
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
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Text(
                          snapshot.data![index],
                    );
                  });
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