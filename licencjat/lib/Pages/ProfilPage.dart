import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilPage> {

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  // State Object

  File? _image;
  late Future<File> futureData = (getImageFileFromAssets('images/placeholder-img.jpg'));
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                color: Colors.orange,
                child: Center(
                  child: Text('Background image goes here'),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('Content goes here'),
                  ),
                ),
              )
            ],
          ),
          // Profile image
          Positioned(
              top: 150.0, // (background container size) - (circle height / 2)
              child: Stack(
                children: [FutureBuilder<File>(
                  future: futureData,
                  builder: (context, snapshot) {
                    if (_image != null) {
                      return Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_image!, scale: 0.1),
                          ),
                          shape: BoxShape.circle,),
                        child:
                        Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: getImage,
                              backgroundColor: Colors.green,
                            )),
                      );
                    } else {
                      return Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/placeholder-img.jpg"),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,),
                        child:
                        Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              onPressed: getImage,
                              hoverColor: Colors.yellow,
                            )),
                      );
                    }
                  }),
                ],
              )
          ),
        ],
      ),
    );
  }
}
