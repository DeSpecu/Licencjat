import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:licencjat/src/theme.dart';
import 'package:provider/provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});
  @override
  _PorfilPageState createState() => _PorfilPageState();
}

class _PorfilPageState extends State<ProfilPage> { // State Object
  var _value = 0.0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(builder: (context, ModelTheme themeNotifier, child){
      return Scaffold(

        appBar: AppBar(
          title: const Text("Profil"),
          automaticallyImplyLeading: false,
          actions: [IconButton(onPressed: () {
            themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
          },
              icon: Icon(themeNotifier.isDark ? Icons.sunny : Icons.dark_mode))
          ],
        ),
        body: Center(
          child: Slider(
            min: 0.0,
            max: 10.0,
            value: _value,
            divisions: 10,
            label: '${_value.round()}',
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),
      );
    });
  }
}