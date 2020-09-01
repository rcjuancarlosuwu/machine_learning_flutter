import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soundpool/soundpool.dart';
import 'package:tflite/tflite.dart';
import 'package:url_launcher/url_launcher.dart';

class TMMoney extends StatefulWidget {
  final bool directly;
  TMMoney({this.directly});
  @override
  _TMMoneyState createState() => _TMMoneyState();
}

class _TMMoneyState extends State<TMMoney> {
  // Lista de resultados del analisis del modelo
  List _outputs;
  // La imagen a analizar
  File _image;
  // Animación de carga
  bool _loading = false;
  // Motor de audio
  Soundpool pool = Soundpool(streamType: StreamType.notification);

  // Estado inicial de la aplicación
  @override
  void initState() {
    super.initState();
    _loading = true;
    // cargamos los modelos
    loadModel().then((value) {
      setState(() => _loading = false);
    });
    // Gesto de acceso directo
    if (widget.directly == null)
      return;
    else if (widget.directly == true) shootImage();
  }

  // Scaffold del interfaz
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconocimiento de Billetes'),
        actions: [
          IconButton(
              icon: Image.asset(
                "assets/images/github_logo.png",
              ),
              onPressed: () async {
                const url =
                    'https://github.com/JuanCarlosRC/machine_learning_flutter/blob/master/lib/screens/tm_money.dart';
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

  // Escoger una imagen desde galería
  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  // Tomar una foto
  shootImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  // Analizar la imagen
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
    switch (output[0]["label"]) {
      case "0 10 Soles":
        int ten = await rootBundle
            .load("assets/sounds/10.mp3")
            .then((ByteData soundData) {
          return pool.load(soundData);
        });
        await pool.play(ten);
        pool.setVolume(soundId: ten, volume: 1);
        break;
      case "1 20 Soles":
        int twenty = await rootBundle
            .load("assets/sounds/20.mp3")
            .then((ByteData soundData) {
          return pool.load(soundData);
        });
        await pool.play(twenty);
        pool.setVolume(soundId: twenty, volume: 1);
        break;
      case "2 50 Soles":
        int fifty = await rootBundle
            .load("assets/sounds/50.mp3")
            .then((ByteData soundData) {
          return pool.load(soundData);
        });
        await pool.play(fifty);
        pool.setVolume(soundId: fifty, volume: 1);
        break;
      case "3 100 Soles":
        int one_hundred = await rootBundle
            .load("assets/sounds/100.mp3")
            .then((ByteData soundData) {
          return pool.load(soundData);
        });
        await pool.play(one_hundred);
        pool.setVolume(soundId: one_hundred, volume: 1);
        break;
      case "4 200 Soles":
        int two_hundred = await rootBundle
            .load("assets/sounds/200.mp3")
            .then((ByteData soundData) {
          return pool.load(soundData);
        });
        await pool.play(two_hundred);
        pool.setVolume(soundId: two_hundred, volume: 1);
        break;
    }
  }

  // Cargar modelo
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/tflite_money_model.tflite",
      labels: "assets/models/tflite_money_labels.txt",
    );
  }

  // Estado en reposo de la aplicacion
  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
