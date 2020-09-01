import 'package:machine_learning/screens/tm_lungs.dart';
import 'package:machine_learning/screens/tm_money.dart';

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
