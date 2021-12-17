import 'package:aprender_haciendo_app/core/services/providers/academyProvider.dart';
import 'package:aprender_haciendo_app/ui/views/academiaDetail.dart';
import 'package:aprender_haciendo_app/ui/widgets/cards/academyCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Academia extends StatelessWidget {
  static const String routeName = '/academia';
  final TextStyle newProductStyle = TextStyle(fontSize: 24, fontFamily: "Poppins-Bold", color: Colors.white);
  final TextStyle nameProductStyle = TextStyle(fontSize: 20, fontFamily: "Poppins-Medium", color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final certificaciones = Provider.of<AcademyProvider>(context);
    final certificacionesList = certificaciones.certificaciones;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Únete a la Comunidad LEGO® Education Academy de Costa Rica",style: TextStyle(color: Colors.black,fontFamily: "Poppins-Bold",fontSize: 26,fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 5),
            Padding(padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Y abre tus puertas al mundo STEAM con soluciones LEGO® Education.",style: TextStyle(color: Colors.black,fontFamily: "Poppins-Medium",fontSize: 17,fontWeight: FontWeight.w200)),
            ),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Certificaciones disponibles:",style: TextStyle(color: Colors.black,fontFamily: "Poppins-Bold",fontSize: 22,fontWeight: FontWeight.w200)),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                      color: Color(0xFFffd403),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: certificacionesList.length,
                      //itemBuilder: (context, index) => AcademyCard(
                      itemBuilder: (BuildContext context, int index) {
                        return ChangeNotifierProvider.value(
                          value: certificacionesList[index],
                          child: AcademyCard(
                            itemIndex: index,
                            certificacion: certificacionesList[index],
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AcademiaDetail(
                                    certificacion: certificacionesList[index]
                                  ),
                                ),
                              );
                              print("${certificacionesList[index].nombre}");
                            },
                          ),
                        );
                      },
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
