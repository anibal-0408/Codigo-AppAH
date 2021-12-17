import 'package:aprender_haciendo_app/core/models/paquetesModelDB.dart';
import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:aprender_haciendo_app/ui/views/carrito.dart';
import 'package:aprender_haciendo_app/ui/widgets/addCarrito.dart';
import 'package:aprender_haciendo_app/ui/widgets/packImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final TextStyle nombreProductoStyle = TextStyle(fontSize: 25,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w700);
final TextStyle nombrecantPStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.lightBlue,fontWeight: FontWeight.w700);
final TextStyle cantPiezasStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w500);
final TextStyle descripcionProductoStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.grey,fontWeight: FontWeight.w500);
var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle:TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins-Medium"),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),side: BorderSide(color: Colors.grey),
  ),
);

class PackDetail extends StatelessWidget {
  final PaquetesModelDB paquete;
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

  const PackDetail({Key key, this.paquete}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<UserProvider>(context, listen: false);
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return Scaffold(
      backgroundColor: Color(0xFF00a7eb),
      appBar: buildAppBar(context),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: '${paquete.id}',
                        child: PackPoster(
                          size: size,
                          image: paquete.imagen,
                        ),
                      ),
                    ),
                    //ListOfColors(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0 / 2),
                      child: Center(
                        child: Text(paquete.nombre,style: nombreProductoStyle,textAlign: TextAlign.center),
                      ),
                    ),
                    Center(
                      child: Text("\₡${(paquete.precio).toStringAsFixed(0)}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.blue)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0 / 2, horizontal: 20),
                      child: Text(paquete.descripcion,style: descripcionProductoStyle,textAlign: TextAlign.justify),
                    ),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      SizedBox(width: 20),
                      Text("Cantidad de piezas:", style: nombrecantPStyle),
                      Text(" " + "${paquete.cantPiezas.toString()}",style: cantPiezasStyle),
                      SizedBox(width: 15),
                    ]),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      SizedBox(width: 20),
                      Text("Edades:", style: nombrecantPStyle),
                      Text(" " + paquete.edades, style: cantPiezasStyle),
                    ]),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0 / 2,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFCBF1E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text("Agregar al carrito",style: botonStyle),
                      ),
                    ),
                    onTap: () {
                      _onAlertButton(context);
                      cart.addItem(paquete.edades, paquete.precio, paquete.imagen, paquete.nombre);
                      cart.reloadUserModel();
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset("icons/icon_cart.png", width: 130.0, height: 130.0),
          onPressed: () {
            user.reloadUserModel();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCart()),
            );
          },
        ),
        SizedBox(width: 15),
      ],
    );
  }
}
