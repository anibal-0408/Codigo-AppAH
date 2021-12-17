import 'package:aprender_haciendo_app/core/models/cursosModelDB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final TextStyle botonStyle = TextStyle(fontSize: 14,fontFamily: "Poppins-Medium",color: Colors.white,fontWeight: FontWeight.w500);
final TextStyle precioStyle = TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
final TextStyle nombreProductoStyle = TextStyle(fontSize: 18,fontFamily: "Poppins-Medium",color: Colors.white,fontWeight: FontWeight.w700);
final TextStyle productsubTitleStyle = TextStyle(fontFamily: "Poppins-Medium",color: Colors.white,fontWeight: FontWeight.w700);

class CursosCard extends StatelessWidget {
  const CursosCard({
    Key key,
    this.itemIndex,
    this.curso,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final CursosModelDB curso;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0 / 2),
      height: 170,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(colors: [Color(0xFFb0cb02), Color(0xFFdae87d)],begin: Alignment.topCenter,end: Alignment.bottomRight),
                boxShadow: [BoxShadow(color: Color(0xFF6078ea).withOpacity(.3),offset: Offset(0.0, 8.0),blurRadius: 8.0)],
              ),
            ),
            Positioned(
            top: ScreenUtil().setHeight(0),
            left: ScreenUtil().setWidth(500),
            child: new InkWell(
              onTap: press,
              child: Hero(
                tag: '${curso.id}',
                child: Image.network(curso.imagen,width: ScreenUtil().setWidth(570),height: ScreenUtil().setHeight(500)),
              ),
            ),
          ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 160,
                width: size.width - 170,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(curso.nombre,textAlign: TextAlign.center,style: nombreProductoStyle),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                      curso.modalidad,
                      style: productsubTitleStyle,
                      ),
                    ), */
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("₡" + "${(curso.precio).toStringAsFixed(0)}",style: precioStyle),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF37b5e7),Color(0xFF61bfd4)],begin: Alignment.topCenter,end: Alignment.bottomRight),borderRadius: BorderRadius.circular(10)),
                            child: Text("Ver más",style: botonStyle),
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
      ),
    );
  }
}
