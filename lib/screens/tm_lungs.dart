import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_learning/screens/details.dart';
import 'package:tflite/tflite.dart';
import 'package:machine_learning/util/info.dart';
import 'package:url_launcher/url_launcher.dart';

class TMLungs extends StatefulWidget {
  @override
  _TMLungsState createState() => _TMLungsState();
}

class _TMLungsState extends State<TMLungs> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Pulmones'),
        actions: [
          IconButton(
              icon: Image.asset(
                "assets/images/github_logo.png",
              ),
              onPressed: () async {
                const url =
                    'https://github.com/JuanCarlosRC/machine_learning_flutter/blob/master/lib/screens/tm_lungs.dart';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    _outputs != null
                        ? "Resultado: Pulmones ${_outputs[0]["label"].substring(2)} Confianza: ${(_outputs[0]["confidence"] * 100).toInt()} %"
                        : "Tome una foto o selecciona una",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      background: Paint()..color = Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 25,
                  ),
                  _image == null
                      ? Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/lungs_main.png',
                            scale: 2,
                          ))
                      : Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 1.3,
                              width: MediaQuery.of(context).size.width - 100,
                              child: Image.file(_image,
                                  height:
                                      MediaQuery.of(context).size.height - 50,
                                  width: MediaQuery.of(context).size.width - 20,
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            heroTag: "camera",
            onPressed: shootImage,
            child: Icon(Icons.camera_alt),
            backgroundColor: Colors.redAccent,
          ),
          FloatingActionButton(
            heroTag: "gallery",
            onPressed: pickImage,
            child: Icon(Icons.image),
            backgroundColor: Colors.blueAccent,
          ),
          SizedBox(
            width: 0,
          ),
        ],
      ),
    );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  shootImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
    print(output);
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/tflite_lungs_model.tflite",
      labels: "assets/models/tflite_lungs_labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
