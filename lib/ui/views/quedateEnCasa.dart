import 'package:aprender_haciendo_app/core/services/providers/paqueteProvider.dart';
import 'package:aprender_haciendo_app/ui/views/paquetesDetail.dart';
import 'package:aprender_haciendo_app/ui/widgets/cards/paquetesCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuedateEnCasa extends StatelessWidget {
  final TextStyle newProductStyle =
      TextStyle(fontSize: 24, fontFamily: "Poppins-Bold", color: Colors.white);
  final TextStyle nameProductStyle = TextStyle(
      fontSize: 20, fontFamily: "Poppins-Medium", color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final paquetes = Provider.of<PaqueteProvider>(context);
    final paquetesList = paquetes.paquetes;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Cajas de AH",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Bold",
                      fontSize: 26,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 20),
              child: Text(
                  "Ya sea que estén en el aula o en la sala de estar, los niños tienen una gran imaginación, una curiosidad innata y un deseo de explorar y tomar riesgos. Todo lo que necesitas son los recursos adecuados para acompañarlos en su proceso de aprendizaje. En Aprender Haciendo queremos apoyarte y formar parte de esta linda aventura.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Medium",
                      fontSize: 17,
                      fontWeight: FontWeight.w200)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Productos disponibles:",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Bold",
                      fontSize: 22,
                      fontWeight: FontWeight.w200)),
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
                            topRight: Radius.circular(40))),
                  ),
                  ListView.builder(
                    itemCount: paquetesList.length,
                    itemBuilder: (context, index) => PaquetesCard(
                      itemIndex: index,
                      paquete: paquetesList[index],
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PackDetail(
                              paquete: paquetesList[index],
                            ),
                          ),
                        );
                      },
                    ),
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
