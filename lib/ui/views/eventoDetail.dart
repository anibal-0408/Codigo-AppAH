import 'package:aprender_haciendo_app/core/models/eventosModelDB.dart';
import 'package:aprender_haciendo_app/ui/widgets/packImage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final TextStyle nombreProductoStyle = TextStyle(fontSize: 25,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w700);
final TextStyle nombrecantPStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.lightBlue,fontWeight: FontWeight.w700);
final TextStyle cantPiezasStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.black,fontWeight: FontWeight.w500);
final TextStyle descripcionProductoStyle = TextStyle(fontSize: 16,fontFamily: "Poppins-Medium",color: Colors.grey,fontWeight: FontWeight.w500);
final TextStyle botonStyle = TextStyle(fontSize: 20,fontFamily: "Poppins-Bold",color: Colors.white,fontWeight: FontWeight.w700);

class EventosDetail extends StatelessWidget {
  final EventosModelDB evento;
  const EventosDetail({Key key, this.evento}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return Scaffold(
      backgroundColor: Color(0xFFd10100),
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
                      child: Hero(
                        tag: '${evento.id}',
                        child: PackPoster(
                          size: size,
                          image: evento.imagen,
                        ),
                      ),
                    ),
                    //ListOfColors(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0 / 2),
                      child: Center(
                        child: Text(evento.nombre,style: nombreProductoStyle,textAlign: TextAlign.center),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0 / 2, horizontal: 20),
                      child: Text(evento.descripcion,style: descripcionProductoStyle,textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      SizedBox(width: 20),
                      Text("Para más información o inscribirse:",style: cantPiezasStyle)
                    ]),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0 / 2,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFCBF1E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text("Clic aquí",style: botonStyle),
                    ),
                  ),
                  onTap: () async {
                    final url = evento.link;
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                      );
                    } else {
                      print('No se encontró $url');
                    }
                  },
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
