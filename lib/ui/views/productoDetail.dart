import 'package:aprender_haciendo_app/core/models/productoModelDB.dart';
import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:aprender_haciendo_app/ui/views/carrito.dart';
import 'package:aprender_haciendo_app/ui/widgets/addCarrito.dart';
import 'package:aprender_haciendo_app/ui/widgets/productoImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final TextStyle nombreProductoStyle = TextStyle(
    fontSize: 25,
    fontFamily: "Poppins-Medium",
    color: Colors.black,
    fontWeight: FontWeight.w700);
final TextStyle nombrecantPStyle = TextStyle(
    fontSize: 16,
    fontFamily: "Poppins-Medium",
    color: Colors.lightBlue,
    fontWeight: FontWeight.w700);
final TextStyle cantPiezasStyle = TextStyle(
    fontSize: 16,
    fontFamily: "Poppins-Medium",
    color: Colors.grey,
    fontWeight: FontWeight.w500);
final TextStyle descripcionProductoStyle = TextStyle(
    fontSize: 16,
    fontFamily: "Poppins-Medium",
    color: Colors.grey,
    fontWeight: FontWeight.w500);
final TextStyle contenidoStyle = TextStyle(
    fontSize: 16,
    fontFamily: "Poppins-Medium",
    color: Colors.grey,
    fontWeight: FontWeight.w500);
var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle:
      TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins-Medium"),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: Colors.grey)),
);

class ProductDetail extends StatelessWidget {
  final ProductoModelDB product;
  _onAlertButton(context) {
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "",
      desc: "Producto agregado al carrito con éxito.",
      buttons: [
        DialogButton(
          child: Text("ACEPTAR",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Poppins-Medium")),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  const ProductDetail({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    final cart = Provider.of<UserProvider>(context, listen: false);
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: '${product.codigo}',
                        child: ProductPoster(size: size, image: product.image),
                      ),
                    ),
                    //ListOfColors(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0 / 2),
                      child: Center(
                        child: Text(product.nombre,
                            style: nombreProductoStyle,
                            textAlign: TextAlign.center),
                      ),
                    ),
                    Center(
                      child: Text("\₡${(product.precio).toStringAsFixed(0)}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0 / 2, horizontal: 20),
                      child: Text(product.descripcion,
                          style: descripcionProductoStyle,
                          textAlign: TextAlign.justify),
                    ),

                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      SizedBox(width: 20),
                      Text("El Kit Incluye:", style: nombrecantPStyle),
                      Text(" ", style: contenidoStyle),
                      SizedBox(width: 15),
                    ]),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0 / 2, horizontal: 20),
                      child: Text(product.contenido,
                          style: contenidoStyle, textAlign: TextAlign.justify),
                    ),

                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      SizedBox(width: 20),
                      Text("Cantidad de piezas:", style: nombrecantPStyle),
                      Text(" " + "${product.cantPiezas.toString()}",
                          style: cantPiezasStyle),
                      SizedBox(width: 15),
                    ]),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      SizedBox(width: 20),
                      Text("Edades:", style: nombrecantPStyle),
                      Text(" " + product.edades, style: cantPiezasStyle),
                    ]),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              AddToCart(
                press: () {
                  _onAlertButton(context);
                  cart.addItem(product.codigo, product.precio, product.image,
                      product.nombre);
                  cart.reloadUserModel();
                },
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
        icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
            icon:
                Image.asset("icons/icon_cart.png", width: 130.0, height: 130.0),
            onPressed: () {
              user.reloadUserModel();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCart()),
              );
            }),
        SizedBox(width: 15)
      ],
    );
  }
}
