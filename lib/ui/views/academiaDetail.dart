import 'package:aprender_haciendo_app/core/models/academyModelDB.dart';
import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:aprender_haciendo_app/ui/views/carrito.dart';
import 'package:aprender_haciendo_app/ui/views/inscripcion.dart';
import 'package:aprender_haciendo_app/ui/widgets/packImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final TextStyle nombreProductoStyle = TextStyle(
    fontSize: 25,
    fontFamily: "Poppins-Medium",
    color: Colors.black,
    fontWeight: FontWeight.w700);

final TextStyle nombrecantPStyle = TextStyle(
    fontSize: 18,
    fontFamily: "Poppins-Medium",
    color: Color(0xFFd10100),
    fontWeight: FontWeight.w700);
final TextStyle cantPiezasStyle = TextStyle(
    fontSize: 16,
    fontFamily: "Poppins-Medium",
    color: Colors.black,
    fontWeight: FontWeight.w500);

final TextStyle descripcionProductoStyle = TextStyle(
    fontSize: 16,
    fontFamily: "Poppins-Medium",
    color: Colors.grey,
    fontWeight: FontWeight.w500);
final TextStyle botonStyle = TextStyle(
    fontSize: 18,
    fontFamily: "Poppins-Bold",
    color: Colors.white,
    fontWeight: FontWeight.w700);

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle:
      TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins-Medium"),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
);

class AcademiaDetail extends StatelessWidget {
  final AcademyModelDB certificacion;

  _onAlertButton(context) {
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "",
      desc: "Certificación agregada al carrito con éxito.",
      buttons: [
        DialogButton(
          child: Text(
            "ACEPTAR",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Poppins-Medium"),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    ).show();
  }

  const AcademiaDetail({Key key, this.certificacion, Null Function() inscribirse}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: '${certificacion.id}',
                      child: PackPoster(
                        size: size,
                        image: certificacion.imagen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0 / 2),
                    child: Center(
                      child: Text(
                        certificacion.nombre,
                        style: nombreProductoStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "\₡${(certificacion.precio).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFd10100),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.0 / 2, horizontal: 20),
                    child: Text(
                      certificacion.descripcion,
                      style: descripcionProductoStyle,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0 / 2),     
                    child: Center(        
                      child: Text("Tenemos disponible dos modalidades para recibir la certificación:", 
                      style: cantPiezasStyle,
                      textAlign: TextAlign.center,),                                 
                    )
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text("Modalidad virtual: ", style: nombrecantPStyle),
                    )
                  ), 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Se recibe en horario asincrónico a través de nuestra plataforma. Este lo puede comprar y hacer efectivo de una vez.", 
                    style: cantPiezasStyle, 
                    textAlign: TextAlign.justify,),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 15.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0 / 2,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFd10100),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                        child: Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              "Agregar al carrito",
                              style: botonStyle,
                            ),
                          ),
                        ),
                    onTap: () {
                      _onAlertButton(context);
                      cart.addItem(certificacion.codigo, certificacion.precio, certificacion.imagen, certificacion.nombre);
                      cart.reloadUserModel(); 
                    }),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text("Modalidad presencial: ", 
                      style: nombrecantPStyle,
                      textAlign: TextAlign.center),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Debe de realizar una previa inscripción ya que es sujeto a cupo mínimo. El pago se realiza una vez que se establezca la fecha de inicio.", 
                    style: cantPiezasStyle, 
                    textAlign: TextAlign.justify),
                  ),                
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 15.0,),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0 / 2,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFd10100),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GestureDetector(
                        child: Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              "Inscribirse",
                              style: botonStyle,
                            ),
                          ),
                        ),
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Inscripcion(inscripcion: certificacion)),
                      );
                    }),
                  ),         
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),   
          ],
        ),
      )
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
