import 'package:aprender_haciendo_app/core/models/paquetesModelDB.dart';
import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final TextStyle precioStyle = TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);
final TextStyle nombreProductoStyle = TextStyle( fontSize: 18, fontFamily: "Poppins-Medium", color: Colors.white, fontWeight: FontWeight.w700);
final TextStyle productsubTitleStyle = TextStyle(fontFamily: "Poppins-Medium");
var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins-Medium"),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),side: BorderSide(color: Colors.grey)),
);

class PaquetesCard extends StatelessWidget {
  const PaquetesCard({
    Key key,
    this.itemIndex,
    this.paquete,
    this.press,
  }) : super(key: key);

  final int itemIndex;
  final PaquetesModelDB paquete;
  final Function press;

  _onAlertButton(context) {
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "",
      desc: "Producto agregado al carrito con éxito.",
      buttons: [
        DialogButton(
          child: Text("ACEPTAR",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Poppins-Medium")),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<UserProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0 / 2),
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(colors: [Color(0xFF65c6f4), Color(0xFF0074c9)],begin: Alignment.topRight,end: Alignment.bottomLeft),
                boxShadow: [BoxShadow(color: Color(0xFF6078ea).withOpacity(.3),offset: Offset(0.0, 8.0),blurRadius: 8.0)],
              ),
            ),
            Positioned(
              top: 0,
              left: 180,
              child: new InkWell(
                onTap: press,
                child: Hero(
                  tag: '${paquete.id}',
                  child: Image.network(
                    paquete.imagen,
                    width: 190,
                    height: 170,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 160,
                width: size.width - 120,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(paquete.nombre,style: nombreProductoStyle,textAlign: TextAlign.left),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("₡" + "${(paquete.precio).toStringAsFixed(0)}",style: precioStyle),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.add,size: 22,color: Colors.lightBlue)
                          ),
                        ),
                      ),
                      onTap: () {
                        _onAlertButton(context);
                        cart.addItem(paquete.codigo, paquete.precio, paquete.imagen, paquete.nombre);
                        cart.reloadUserModel();
                      },
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
