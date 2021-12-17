import 'package:aprender_haciendo_app/core/services/providers/eventoProvider.dart';
import 'package:aprender_haciendo_app/ui/views/eventoDetail.dart';
import 'package:aprender_haciendo_app/ui/widgets/cards/eventosCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Eventos extends StatelessWidget {
  final TextStyle newProductStyle = TextStyle(fontSize: 24, fontFamily: "Poppins-Bold", color: Colors.white);
  final TextStyle nameProductStyle = TextStyle(fontSize: 20, fontFamily: "Poppins-Medium", color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final eventos = Provider.of<EventoProvider>(context);
    final eventosList = eventos.eventos;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("Eventos",style: TextStyle(color: Colors.black,fontFamily: "Poppins-Bold",fontSize: 26,fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 25),
              child: Text("Inscríbase y participe en los mejores eventos de robótica a nivel nacional e internacionalmente.",
                textAlign: TextAlign.justify,style: TextStyle(color: Colors.black,fontFamily: "Poppins-Medium",fontSize: 17,fontWeight: FontWeight.w200)
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                        color: Color(0xFFd10100),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                  ListView.builder(
                    itemCount: eventosList.length,
                    itemBuilder: (context, index) => EventosCard(
                      itemIndex: index,
                      evento: eventosList[index],
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EventosDetail(evento: eventosList[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
