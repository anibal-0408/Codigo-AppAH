import 'package:aprender_haciendo_app/ui/widgets/cards/perfilCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Perfil extends StatelessWidget {
  final TextStyle newProductStyle =
      TextStyle(fontSize: 24, fontFamily: "Poppins-Bold", color: Colors.white);
  final TextStyle nameProductStyle = TextStyle(
      fontSize: 20, fontFamily: "Poppins-Medium", color: Colors.white);

  static const String routeName = '/perfil';
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 1125, height: 2436, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 2),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )),
            Center(
              child: Text("Perfil",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Bold",
                      fontSize: 26,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 5),
            Center(
              child: Container(
                width: 110,
                height: 110,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('images/lego_M.jpg')),
                    borderRadius: BorderRadius.circular(55.0)),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                        color: Color(0xFFe54c3c),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                  SingleChildScrollView(child: PerfilCard())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
