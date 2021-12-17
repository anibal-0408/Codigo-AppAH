import 'package:aprender_haciendo_app/core/models/productoModelDB.dart';
import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:aprender_haciendo_app/ui/views/metodoPagoEnvio.dart';
import 'package:aprender_haciendo_app/ui/views/productoDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final TextStyle nameStyle = TextStyle(fontSize: 16, fontFamily: "Poppins-Bold");
final TextStyle precioStyle =
    TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
final TextStyle totalStyle = TextStyle(
    fontSize: 26, fontFamily: "Poppins-Bold", fontWeight: FontWeight.bold);
final TextStyle subtotalStyle =
    TextStyle(fontSize: 24, fontFamily: "Poppins-Bold");
final TextStyle subtotalPrecioStyle =
    TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
final TextStyle totalprecioStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w800);
final TextStyle confirmarStyle =
    TextStyle(fontSize: 18, fontFamily: "Poppins-Bold", color: Colors.white);
GlobalKey<FormState> keyForm = new GlobalKey();
TextEditingController codigoCtrl = new TextEditingController();
ProductoModelDB product;

class ShoppingCart extends StatefulWidget {
  static const String routeName = '/shopping_cart';
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<UserProvider>(context);
    //final cartList = cart.items.values.toList();
    final user = Provider.of<UserProvider>(context);
    ScreenUtil.instance = ScreenUtil(width: 1125, height: 2436, allowFontScaling: true)..init(context);
    //user.reloadUserModel();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding( 
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(0),left: ScreenUtil().setWidth(50),right: ScreenUtil().setWidth(50)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Carrito de compras",
                      style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Bold",
                      fontSize: 26,
                      fontWeight: FontWeight.w700)
                    ),
                    SizedBox(height: ScreenUtil().setHeight(100)),
                    Container(
                      height: ScreenUtil().setHeight(1350),
                      child: Stack(
                        children: <Widget>[
                          ListView.builder(
                            itemCount: (user.userModel.cart.length == null)
                                ? 0
                                : user.userModel.cart.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                child: SingleChildScrollView(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.lightBlue[200],
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 110,
                                              height: 110,
                                              padding: EdgeInsets.all(4.0),
                                              child: Image.network(
                                                "${user.userModel.cart[index].image}",
                                                fit: BoxFit.contain,
                                              ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF65a6f4),
                                                      Color(0xFF25cfff)
                                                    ],
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    offset: Offset(0, 8),
                                                    blurRadius: 8,
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 160,
                                                child: Text(
                                                  "${user.userModel.cart[index].nombre}",
                                                  style: nameStyle,
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Row(
                                                children: <Widget>[
                                                  /* GestureDetector(
                                                    child: Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF0074c9),
                                                        borderRadius:
                                                            BorderRadius.circular(4.0),
                                                      ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    onTap: () {},
                                                  ), */
                                                  Text("Precio: ", style: nameStyle),
                                                  /* Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                    child: Text(
                                                      "${user.userModel.cart[index].quantity.toString()}",
                                                      style: nameStyle,
                                                    ),
                                                  ), */
                                                  /* GestureDetector(
                                                    child: Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFF65c6f4),
                                                        borderRadius:
                                                            BorderRadius.circular(4.0),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    onTap: () {},
                                                  ), */
                                                  Spacer(),
                                                  Text(
                                                      "\₡${user.userModel.cart[index].precio}",
                                                      style: precioStyle),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                key: ValueKey(user.userModel.cart[index]),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) async {
                                  await user.removeFromCart(
                                      cartItem: user.userModel.cart[index]);
                                  user.reloadUserModel();
                                },
                                background: Container(
                                  padding: EdgeInsets.only(right: 20),
                                  color: Theme.of(context).errorColor,
                                  child: Icon(Icons.delete, color: Colors.white),
                                  alignment: Alignment.centerRight,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "¿Tiene un cupón de descuento?",
                            style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Código"),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Color(0xFF65c6f4), Color(0xFF0074c9)]),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Aplicar",
                                style: confirmarStyle,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ), */
                    SizedBox(height: ScreenUtil().setHeight(100)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total", style: totalStyle),
                        Text("\₡${(user.userModel.totalCartPrice).toStringAsFixed(0)}",
                            style: totalprecioStyle),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(100)),
                    Container(
                      height: ScreenUtil().setHeight(150),
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(100),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xFF65c6f4), Color(0xFF0074c9)]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Confirmar", style: confirmarStyle),
                        ),
                        onTap: () async {
                          if (user.userModel.cart.length != 0) {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MetodoPagoEnvio(),
                            ),
                          );
                        } else {
                          Alert(
                            context: context,
                            style: alertStyle,
                            type: AlertType.warning,
                            title: "",
                            desc: "No hay articulos en el carrito",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "ACEPTAR",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "Poppins-Medium"),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                          /* if (user.userModel.cart.length != 0) {
                          var uuid = Uuid();
                          String id = uuid.v4();
                          var userId = (await FirebaseAuth.instance.currentUser()).uid;
                          var userModel = await userServices.getUserById(userId);
                          user.createOrder(
                              uid: userId,
                              id: id,
                              cart: userModel.cart, //cart.userModel.cart,
                              total: userModel.totalCartPrice); //cart.userModel.totalCartPrice);
                          user.reloadUserModel();
                          for (CarritoModelDB cartItem in userModel.cart) {
                            bool value = await user.removeFromCart(cartItem: cartItem);
                            if (value) {
                              user.reloadUserModel();
                              print("Item added to cart");
                            } else {
                              print("ITEM WAS NOT REMOVED");
                            } 
                          }
                          Alert(
                            context: context,
                            style: alertStyle,
                            type: AlertType.success,
                            title: "",
                            desc: "Orden de compra generada.",
                            buttons: [
                              DialogButton(
                                child: Text("ACEPTAR", style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Poppins-Medium")),
                                onPressed: () {
                                  //Navigator.pop(context);
                                  Navigator.pushNamed(context, '/index');
                                },
                                width: 120,
                              )
                            ],
                          ).show();
                        } else {
                          Alert(
                            context: context,
                            style: alertStyle,
                            type: AlertType.warning,
                            title: "",
                            desc: "No hay articulos en el carrito",
                            buttons: [
                              DialogButton(
                                child: Text("ACEPTAR",
                                  style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Poppins-Medium"),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                width: 120,
                              )
                            ],
                          ).show();*/
                          //SizedBox(height: 30.0),
                        } 
                      ),
                    ),
                  ]
                )
              ),            
            
             

                   
            
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "¿Tiene un cupón de descuento?",
                      style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Código"),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF65c6f4), Color(0xFF0074c9)]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Aplicar",
                          style: confirmarStyle,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ), */          
          ],
        ),
      ),
    );    
  }
}

/* Widget formUI() {
  return Container(
    child: Padding(
      padding: EdgeInsets.only(right: 90.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontFamily: "Poppins-Medium",
            ),
            decoration: new InputDecoration(
              labelText: 'Código',
            ),
            controller: codigoCtrl,
          ),
        ],
      ),
    ),
  );
}
 */
