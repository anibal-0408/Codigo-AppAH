import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:aprender_haciendo_app/ui/views/academia.dart';
import 'package:aprender_haciendo_app/ui/views/carrito.dart';
import 'package:aprender_haciendo_app/ui/views/cursos.dart';
import 'package:aprender_haciendo_app/ui/views/eventos.dart';
import 'package:aprender_haciendo_app/ui/views/historialCompras.dart';
import 'package:aprender_haciendo_app/ui/views/perfil.dart';
import 'package:aprender_haciendo_app/ui/views/quedateEnCasa.dart';
import 'package:aprender_haciendo_app/ui/views/tienda.dart';
import 'package:aprender_haciendo_app/ui/widgets/customDialog.dart';
import 'package:aprender_haciendo_app/ui/widgets/profileClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  static const String routeName = '/index';
  @override
  _IndexState createState() => _IndexState();
}

final TextStyle menuStyle =
    TextStyle(fontSize: 18, fontFamily: "Poppins-Medium");

class _IndexState extends State<Index> {
  List<ScreenHiddenDrawer> items = [];
  @override
  void initState() {
    items.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Tienda",
          baseStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontFamily: "Poppins-Medium"),
          colorLineSelected: Colors.white,
          selectedStyle: null,
        ),
        Tienda(),
      ),
    );

    items.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Cajas de AH",
          baseStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontFamily: "Poppins-Medium"),
          colorLineSelected: Colors.white,
          selectedStyle: null,
        ),
        QuedateEnCasa(),
      ),
    );

    items.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Academia",
          baseStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontFamily: "Poppins-Medium"),
          colorLineSelected: Colors.white,
          selectedStyle: null,
        ),
        Academia(),
      ),
    );

    items.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Eventos",
          baseStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontFamily: "Poppins-Medium"),
          colorLineSelected: Colors.white,
          selectedStyle: null,
        ),
        Eventos(),
      ),
    );

    items.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Cursos",
          baseStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontFamily: "Poppins-Medium"),
          colorLineSelected: Colors.white,
          selectedStyle: null,
        ),
        Cursos(),
      ),
    );

    items.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Historial compras",
          baseStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontFamily: "Poppins-Medium"),
          colorLineSelected: Colors.white,
          selectedStyle: null,
        ),
        HistorialCompras(),
      ),
    );

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Cerrar sesión",
          baseStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 20.0,
              fontFamily: "Poppins-Medium"),
          colorLineSelected: Colors.white10,
          selectedStyle: null,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: "CERRAR SESIÓN",
                description: "¿Desea cerrar sesión?                          ",
                primaryButtonText: "Aceptar",
                primaryButton: _cerrarSesion,
                secondaryButtonText: "Cancelar",
                secondaryButton: _cancelar,
              ),
            );
          },
        ),
        null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1125, height: 2436, allowFontScaling: true)
          ..init(context);
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.lightBlue,
      backgroundColorAppBar: Colors.white,
      elevationAppBar: 0.0,
      screens: items,
      //    typeOpen: TypeOpen.FROM_RIGHT,
      //    enableScaleAnimin: true,
      //    enableCornerAnimin: true,
      slidePercent: 65.0,
      verticalScalePercent: 85.0,
      contentCornerRadius: 40.0,
      leadingAppBar: (Image.asset("icons/icon_menu.png",
          width: ScreenUtil.getInstance().setWidth(110),
          height: ScreenUtil.getInstance().setHeight(110))),
      actionsAppBar: <Widget>[
        //Badge(child:
        IconButton(
          icon: Image.asset("icons/icon_cart.png",
              width: ScreenUtil.getInstance().setWidth(130),
              height: ScreenUtil.getInstance().setHeight(130)),
          onPressed: () {
            user.reloadUserModel();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCart()),
            );
          },
        ),
        //  value: cart.itemCount.toString(),
        //),
        SizedBox(width: 10)
      ],
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    backgroundColorContent: Colors.blue,
      tittleAppBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Perfil()),
          );
        },
        child: Center(
          child: ClipOval(
            clipper: ProfileClipper(),
            child: Image.asset(
              "images/lego_M.jpg",
              width: ScreenUtil().setWidth(160),
              height: ScreenUtil().setHeight(160),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }

  /* String _cantidad = "";
  String _cantidadCarrito() {
    setState(() {
      cart.itemCount.toString();
    });
    return _cantidad;
  } */

  makeProfileAvatar() {
    return Column(
      children: <Widget>[
        // SizedBox(height: 10.0),
        CircleAvatar(
          radius: 60.0,
          backgroundImage: new AssetImage("icons/018-lego.png"),
        ),
        SizedBox(height: 20.0),
        Center(
          child: new Text("Usuario",
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        Center(
          child: new Text("Correo",
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }

  void _cerrarSesion() async {
    try {
      await UserProvider.initialize().signOut();
      Navigator.pushNamed(context, '/welcomeScreen');
    } catch (e) {
      print(e);
    }
  }

  void _cancelar() {
    Navigator.pushNamed(context, '/index');
  }
}
