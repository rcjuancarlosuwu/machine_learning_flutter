import 'package:machine_learning/screens/facevision_firebase.dart';
import 'package:machine_learning/screens/tm_lungs.dart';
import 'package:machine_learning/screens/tm_money.dart';

List firebase = [
  {
    "title": "Face Vision",
    "images": ["assets/images/firebase_vision.png", "assets/images/lungs.png"],
    "subtitle": "Detecta Rostros",
    "powered": "Powered by: Firebase Machine Learning",
    "powered_logo": "assets/images/mlkit_logo.png",
    "details": "Este tipo de machine ...",
    "code_link": "github.com",
    "widget": FaceVision()
  },
];

List teacheable = [
  {
    "type": "ML Imagenes",
    "images": ["assets/images/lungs.png"],
    "subtitle": "Decide la salud de unos pulmones",
    "powered": "Powered by: Teacheable Machine",
    "powered_logo": "assets/images/tm_logo.png",
    "details": "En este tipo  ",
    "code_link": "github.com",
    "title": "Salud de Pulmones",
    "widget": TMLungs()
  },
  {
    "type": "ML Imagenes",
    "images": ["assets/images/money.png"],
    "subtitle": "Determina el valor de un billetes",
    "powered": "Powered by: Teacheable Machine",
    "powered_logo": "assets/images/tm_logo.png",
    "details": "En este tipo  ",
    "code_link": "github.com",
    "title": "Reconocimiento de billetes",
    "widget": TMMoney()
  },
];
