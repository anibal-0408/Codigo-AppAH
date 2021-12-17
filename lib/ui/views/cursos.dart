import 'package:aprender_haciendo_app/core/services/providers/cursoProvider.dart';
import 'package:aprender_haciendo_app/ui/views/cursoDetail.dart';
import 'package:aprender_haciendo_app/ui/widgets/cards/cursosCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Cursos extends StatelessWidget {
  final TextStyle newProductStyle = TextStyle(fontSize: 24, fontFamily: "Poppins-Bold", color: Colors.white);
  final TextStyle nameProductStyle = TextStyle(fontSize: 20, fontFamily: "Poppins-Medium", color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final cursos = Provider.of<CursoProvider>(context);
    final cursosList = cursos.cursos;
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
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Cursos de Robótica", style: TextStyle(color: Colors.black,fontFamily: "Poppins-Bold",fontSize: 26,fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Para niños y niñas desde los 3 años en adelante.", style: TextStyle(color: Colors.black,fontFamily: "Poppins-Medium",fontSize: 17,fontWeight: FontWeight.w200)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Cursos disponibles:", style: TextStyle(color: Colors.black,fontFamily: "Poppins-Bold",fontSize: 22,fontWeight: FontWeight.w200)),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: Color(0xFF38b4e7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: cursosList.length,
                  itemBuilder: (context, index) => CursosCard(
                    itemIndex: index,
                    curso: cursosList[index],
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CursoDetail(curso: cursosList[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
