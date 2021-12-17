import 'package:aprender_haciendo_app/core/models/academyModelDB.dart';
import 'package:flutter/material.dart';

final TextStyle precioStyle =
    TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
final TextStyle nombreProductoStyle = TextStyle(fontSize: 18,fontFamily: "Poppins-Medium",color: Colors.white,fontWeight: FontWeight.w700);
final TextStyle productsubTitleStyle = TextStyle(fontFamily: "Poppins-Medium",color: Colors.white,fontWeight: FontWeight.w700);
final TextStyle botonStyle = TextStyle(fontSize: 14,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w500);

class AcademyCard extends StatelessWidget {
  const AcademyCard({
    Key key,
    this.itemIndex,
    this.certificacion,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final AcademyModelDB certificacion;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0 / 2),
      height: 160,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(colors: [Color(0xFFd10100), Color(0xFFfe4936)],begin: Alignment.topLeft,end: Alignment.bottomLeft),
              boxShadow: [BoxShadow(color: Color(0xFF6078ea).withOpacity(.3),offset: Offset(0.0, 8.0),blurRadius: 8.0)],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              height: 140,
              width: 180,
              child: Image.network(certificacion.imagen,fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 136,
              width: size.width - 180,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(certificacion.nombre,style: nombreProductoStyle,textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("₡" + "${(certificacion.precio).toStringAsFixed(0)}",style: precioStyle),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFffffff),Color(0xFFffffff)],begin: Alignment.topCenter,end: Alignment.bottomRight),borderRadius: BorderRadius.circular(10)),
                            child: Text("Ver más",style: botonStyle),
                          ),
                          onTap: press,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
