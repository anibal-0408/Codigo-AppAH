import 'package:aprender_haciendo_app/core/models/orderModelDB.dart';
import 'package:flutter/material.dart';

final TextStyle codigoStyle = TextStyle(fontSize: 15,fontFamily: "Muli",color: Colors.white,fontWeight: FontWeight.w700,
  shadows: <Shadow>[Shadow(offset: Offset(3.0, 1.0),blurRadius: 3.0,color: Color.fromARGB(150, 0, 0, 0))]);
final TextStyle botonStyle = TextStyle(fontSize: 14,fontFamily: "Poppins-Medium",color: Colors.white,fontWeight: FontWeight.w500);
final TextStyle tituloStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w700);
final TextStyle subTitleStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w500);
final TextStyle precioStyle = TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w500);

class HistorialCard extends StatelessWidget {
  const HistorialCard({
    Key key,
    this.itemIndex,
    this.press,
    this.compra,
  }) : super(key: key);

  final int itemIndex;
  final OrderModelDB compra;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0 / 2),
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 156,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(colors: [Colors.grey[300], Colors.white],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                boxShadow: [BoxShadow(color: Color(0xFF6078ea).withOpacity(.3),offset: Offset(0.0, 8.0),blurRadius: 8.0)],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 25.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text("N° de compra: ", style: tituloStyle),
                        Text(compra.createdAt.toString(), style: subTitleStyle),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, top: 5.0, right: 5),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text("Fecha: ", style: tituloStyle),
                        Text(compra.fecha.toDate().day.toString()+"/"+ compra.fecha.toDate().month.toString()+"/"+ compra.fecha.toDate().year.toString(), style: subTitleStyle),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 5.0),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text("Monto: ", style: tituloStyle),
                        Text("₡" + compra.total.toString(), style: precioStyle),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Positioned(
              top: 110,
              right: 5,
              child: SizedBox(
                height: 160,
                width: size.width - 230,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Color(0xFF37b5e7),Color(0xFF61bfd4)],begin: Alignment.topCenter,end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text("Ver detalle",style: botonStyle),
                          )
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
