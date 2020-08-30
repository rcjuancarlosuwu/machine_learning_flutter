import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_learning/screens/details.dart';
import 'package:tflite/tflite.dart';
import 'package:machine_learning/util/info.dart';

class TMMoney extends StatefulWidget {
  @override
  _TMMoneyState createState() => _TMMoneyState();
}

class _TMMoneyState extends State<TMMoney> {
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
        title: Text('Reconocimiento de Billetes'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HowToDoIt(option: teacheable[0])));
            },
          ),
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
                        ? "Resultado: ${_outputs[0]["label"].substring(2)} Confianza: ${(_outputs[0]["confidence"] * 100).toInt()} %"
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
                            'assets/images/money.png',
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
      model: "assets/models/tflite_money_model.tflite",
      labels: "assets/models/tflite_money_labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
