import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:aprender_haciendo_app/ui/views/historialDetail.dart';
import 'package:aprender_haciendo_app/ui/widgets/cards/historialComprasCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistorialCompras extends StatelessWidget {
  final TextStyle newProductStyle = TextStyle(fontSize: 24, fontFamily: "Poppins-Bold", color: Colors.white);
  final TextStyle nameProductStyle = TextStyle(fontSize: 20, fontFamily: "Poppins-Medium", color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final compras = Provider.of<UserProvider>(context);
    final comprasList = compras.order;
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
              child: Text("Historial de compras",style: TextStyle(color: Colors.black,fontFamily: "Poppins-Bold",fontSize: 26,fontWeight: FontWeight.w700)),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: Color(0xFF00a7eb),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                ),
                ListView.builder(
                  itemCount: comprasList.length,
                  itemBuilder: (context, index) => HistorialCard(
                    itemIndex: index,
                    compra: comprasList[index],
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HistorialDetail(historial: comprasList[index]),
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
