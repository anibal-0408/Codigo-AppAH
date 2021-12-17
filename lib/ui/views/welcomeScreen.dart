import 'package:aprender_haciendo_app/ui/widgets/customDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcomeScreen';
  @override
  _WelcomeScreenState createState() => new _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Color(0xFF4cb2e2),
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 100.0),
                  child: Image.asset("images/wedo2.png",
                      width: ScreenUtil.getInstance().setWidth(390)),
                ),
                Expanded(child: Container()),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    _logo(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(180)),
                    Login(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(50)),
                    _horizontalLine(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    //_redesSociales(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    _registrarseButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
                  title: "Estas Seguro?",
                  description:
                      "¿Deseas Salir de la App?                          ",
                  primaryButtonText: "Aceptar",
                  primaryButton: _cerrar,
                  secondaryButtonText: "Cancelar",
                  secondaryButton: _noCerrar,
                )) ??
        false;
  }

  void _cerrar() {
    try {
      Navigator.of(context).pop(true);
    } catch (e) {
      print(e);
    }
  }

  void _noCerrar() {
    try {
      Navigator.pushNamed(context, '/welcomeScreen');
    } catch (e) {
      print(e);
    }
  }

  void switchToIndex() {}

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black))
            : Container(),
      );

  Widget _horizontalLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
              width: ScreenUtil.getInstance().setWidth(450),
              height: 1.0,
              color: Colors.black26.withOpacity(.2)),
        ),
      ],
    );
  }

  Widget _logo() {
    return Row(
      children: <Widget>[
        Image.asset(
          "images/LogoAH.png",
          width: ScreenUtil.getInstance().setWidth(350),
          height: ScreenUtil.getInstance().setHeight(210),
        ),
      ],
    );
  }

  /* Widget _redesSociales() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          colors: [Color(0xFFd32d32), Color(0xFFd32d32)],
          iconData: CustomIcons.googlePlus,
          onPressed: () {
            /* signInWithGoogle().whenComplete(() {
              FirebaseUser user = signInWithGoogle().then((user) => null);
              if (user == null) {
              //Route to login
              } else {
              //route to somewhere
              } */
            /* signInWithGoogle().whenComplete(	            
              () {	              
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Index();
                    },	           
                  ),	      
                );	           
              },	         
            ); */
              
            signInWithGoogle().then((user) {
              if (user != null) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Index();
                }));
                Navigator.pushReplacementNamed(context, '/Tienda');
              } else {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return WelcomeScreen();
                }));
              }
            } 
            ).catchError((error) {});
          },
        ),
      ],
    );
  } */

  Widget _registrarseButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("¿No tiene cuenta? ",
            style: TextStyle(
                color: Color(0xFFffffff), fontFamily: "Poppins-Medium")),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/registro');
          },
          child: Text("Regístrese",
              style: TextStyle(
                  color: Color(0xFF28409b), fontFamily: "Poppins-Bold")),
        ),
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final List<Color> colors;
  final IconData iconData;
  final Function onPressed;
  SocialIcon({this.colors, this.iconData, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: colors, tileMode: TileMode.clamp)),
        child: RawMaterialButton(
          shape: CircleBorder(),
          onPressed: onPressed,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}

class CustomIcons {
  static const IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
  static const IconData googlePlus =
      IconData(0xe902, fontFamily: "CustomIcons");
}
