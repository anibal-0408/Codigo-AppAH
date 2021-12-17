import 'package:aprender_haciendo_app/core/models/eventosModelDB.dart';
import 'package:flutter/material.dart';

final TextStyle codigoStyle = TextStyle(fontSize: 15,fontFamily: "Muli",color: Colors.white,fontWeight: FontWeight.w700,
    shadows: <Shadow>[Shadow(offset: Offset(3.0, 1.0),blurRadius: 3.0,color: Color.fromARGB(150, 0, 0, 0))]);
final TextStyle botonStyle = TextStyle(fontSize: 14,fontFamily: "Poppins-Medium",color: Colors.white,fontWeight: FontWeight.w500);
final TextStyle nombreProductoStyle = TextStyle(fontSize: 18,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w700);
final TextStyle productsubTitleStyle = TextStyle(fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w700);
const kDefaultShadow = BoxShadow(offset: Offset(0, 15),blurRadius: 27,color: Colors.black12);

class EventosCard extends StatelessWidget {
  const EventosCard({
    Key key,
    this.itemIndex,
    this.evento,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final EventosModelDB evento;
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
                gradient: LinearGradient(colors: [Colors.grey[300], Colors.white],begin: Alignment.topRight,end: Alignment.topLeft),
                boxShadow: [BoxShadow(color: Color(0xFF6078ea).withOpacity(.3),offset: Offset(0.0, 8.0),blurRadius: 8.0)],
              ),
            ),
            Positioned(
            top: 0,
            left: 15,
              child: new InkWell(
                onTap: press,
                child: Hero(
                  tag: '${evento.id}',
                  child: Image.network(evento.imagen,width: 130,height: 150),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 150,
                width: size.width - 155,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(evento.nombre,textAlign: TextAlign.center,style: nombreProductoStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(evento.fecha.toDate().day.toString()+"/"+evento.fecha.toDate().month.toString()+"/"+
                        evento.fecha.toDate().year.toString(),textAlign: TextAlign.center,style: productsubTitleStyle),
                    ),
                    SizedBox(height: 10),
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
                              gradient: LinearGradient(colors: [Color(0xFFd10100),Color(0xFFfe4936)]),
                              borderRadius: BorderRadius.circular(10)
                            ),
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
