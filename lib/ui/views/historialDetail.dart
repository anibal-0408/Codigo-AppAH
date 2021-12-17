import 'package:aprender_haciendo_app/core/models/carritoModelDB.dart';
import 'package:aprender_haciendo_app/core/models/orderModelDB.dart';
import 'package:flutter/material.dart';

final TextStyle numOrdenStyle = TextStyle(fontSize: 24,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w700);
final TextStyle tituloStyle = TextStyle(fontSize: 18,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w500);
final TextStyle descripcionProductoStyle = TextStyle(fontSize: 18,fontFamily: "Poppins-Medium",color: Colors.grey,fontWeight: FontWeight.w500);
final TextStyle montoStyle = TextStyle(fontSize: 19, color: Colors.grey, fontWeight: FontWeight.w500);
final TextStyle subtituloStyle = TextStyle(fontSize: 15,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w500);

class HistorialDetail extends StatelessWidget {
  final OrderModelDB historial;
  const HistorialDetail({Key key, this.historial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> listaProducts(List<CarritoModelDB> cartList) {
      List<Map<String, String>> lista = [];
      Map<String, String> map;
      for (var item in cartList) {
        map = {
          "codigo": item.codigo.toString(),
          "nombre": item.nombre.toString(),
          "precio": item.precio.toString()
        };
        lista.add(map);
      }
      return lista;
    }

    var mainList = historial.cart.toList();
    List<CarritoModelDB> listToCartList(List<String> list) {
      List<CarritoModelDB> cartList = [];
      for (var item in list) {
        var carts = item.toString().split(",");
        for (var i = 0; i < carts.length; i++) {
          if (carts[i].contains("image")) {
            CarritoModelDB item = new CarritoModelDB(
                codigo: carts[i + 1].replaceAll("codigo:", "").trim(),
                nombre: carts[i + 4].replaceAll("nombre:", "").trim(),
                image: carts[i].replaceAll("image:", "").trim(),
                //quantity: 1,
                precio: int.parse(
                    '${carts[i + 2].replaceAll("precio:", "").trim()}'));
            cartList.add(item);
          }
        }
      }
      return cartList;
    }

    List<CarritoModelDB> stringToList(List list) {
      List<String> lista = [];
      for (var item in list) {
        lista.add(item.toString().replaceAll("{", " ").replaceAll("}", " "));
      }
      return listToCartList(lista);
    }

    //wil(mainList);
    List<Map<String, String>> listaFinal =
        listaProducts(stringToList(mainList));

    // it provide us total height and width
    //Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices

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
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Image.asset(
                          "images/LogoAH_color.png",
                          height: 100,
                          width: 200,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0 / 2),
                      child: Center(
                        child: Text("Número de compra #" + historial.createdAt.toString(),style: numOrdenStyle,textAlign: TextAlign.center),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0 / 2, horizontal: 12),
                      child: Container(
                        child: Row(children: <Widget>[
                          Text("Fecha: ", style: tituloStyle),
                          Text(historial.fecha.toDate().day.toString() + "/" + historial.fecha.toDate().month.toString() + "/" + historial.fecha.toDate().year.toString(),
                            style: descripcionProductoStyle),
                          SizedBox(width: 15),
                        ]),
                        
                      ),
                    ),
                    Row(children: <Widget>[
                      SizedBox(width: 15),
                      Text("Metodo de Pago: ", style: tituloStyle),
                      Text(historial.metPago.toString(), style: subtituloStyle)
                    ]),
                    SizedBox(height: 15),
                    Row(children: <Widget>[
                      SizedBox(width: 15),
                      Text("Entrega: ", style: tituloStyle),
                      Text(historial.metEnvio.toString(), style: subtituloStyle)
                    ]),
                    SizedBox(height: 15),
                    FittedBox(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Código', style: tituloStyle)),
                          DataColumn(label: Text('Nombre', style: tituloStyle)),
                          DataColumn(label: Text('Precio', style: tituloStyle)),
                        ],
                        rows: listaFinal.map(
                          // Loops through dataColumnText, each iteration assigning the value to element
                          ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["codigo"], style: descripcionProductoStyle)), //Extracting from Map element the value
                                DataCell(Text(element["nombre"],style: descripcionProductoStyle,textAlign: TextAlign.center)),
                                DataCell(Text("₡ "+ element["precio"], style: montoStyle)),
                              ],
                            )
                          ),
                        )
                        .toList(),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(children: <Widget>[
                      SizedBox(width: 15),
                      Text("Total de la compra: ", style: tituloStyle),
                      Text("₡" + historial.total.toString(), style: montoStyle)
                    ]),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
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
    );
  }
}
