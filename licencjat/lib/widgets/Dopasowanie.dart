import 'package:flutter/material.dart';

class Dopasowanie extends StatelessWidget {
  const Dopasowanie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text('Dopasowanie'),
        ),
        body: Column());
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}