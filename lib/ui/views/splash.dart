import 'package:aprender_haciendo_app/ui/shared/style.dart';
import 'package:aprender_haciendo_app/ui/widgets/customText.dart';
import 'package:aprender_haciendo_app/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomText(text: "Cargando"),
          Loading(),
        ],
      )
    );
  }
}
