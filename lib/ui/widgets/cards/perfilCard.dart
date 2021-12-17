import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
//import 'package:aprender_haciendo_app/ui/views/EditarPerfil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final TextStyle codigoStyle = TextStyle(
    fontSize: 15,
    fontFamily: "Muli",
    color: Colors.white,
    fontWeight: FontWeight.w700,
    shadows: <Shadow>[
      Shadow(
          offset: Offset(3.0, 1.0),
          blurRadius: 3.0,
          color: Color.fromARGB(150, 0, 0, 0))
    ]);
final TextStyle botonStyle = TextStyle(
    fontSize: 14,
    fontFamily: "Poppins-Medium",
    color: Colors.white,
    fontWeight: FontWeight.w500);
final TextStyle nombreStyle = TextStyle(
    fontSize: 18,
    fontFamily: "Poppins-Medium",
    color: Colors.white,
    fontWeight: FontWeight.w700);
final TextStyle subTitleStyle = TextStyle(
    fontFamily: "Poppins-Medium",
    color: Colors.white,
    fontWeight: FontWeight.w700,
    shadows: <Shadow>[
      Shadow(
          offset: Offset(3.0, 1.0),
          blurRadius: 3.0,
          color: Color.fromARGB(150, 0, 0, 0))
    ]);

class PerfilCard extends StatefulWidget {
  //final Cursos curso;
  @override
  _PerfilCardState createState() => _PerfilCardState();
}

class _PerfilCardState extends State<PerfilCard> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0 / 2),
      height: 470,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                  colors: [Color(0xFFf0c419), Color(0xFFf7d759)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ],
            ),
          ),
          SizedBox(
            height: 470,
            child: Column(
              children: <Widget>[
                SizedBox(height: 35),
                Text("Nombre completo", style: nombreStyle),
                Text(
                    "${user.userModel.nombre.trim()} ${user.userModel.apellido.trim()}",
                    style: subTitleStyle),
                SizedBox(height: 10),
                Text("Correo Electrónico", style: nombreStyle),
                Text("${user.user.email}", style: subTitleStyle),
                SizedBox(height: 10),
                Text("Fecha de nacimiento", style: nombreStyle),
                Text("${user.userModel.fechaNacimiento}", style: subTitleStyle),
                SizedBox(height: 10),
                Text("Numero de Telefono", style: nombreStyle),
                Text("${user.userModel.telefono}", style: subTitleStyle),
                SizedBox(height: 10),
                Text(
                  "Direccion de Entrega",
                  style: nombreStyle,
                ),
                if (user.userModel.direccion == null ||
                    user.userModel.direccion == "")
                  Text(
                    "No ha registrado una dirección",
                    style: subTitleStyle,
                  )
                else
                  Text("${user.userModel.direccion}", style: subTitleStyle),
                SizedBox(height: 20),
                /* Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0xFF37b5e7),Color(0xFF61bfd4)],begin: Alignment.topCenter,end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("Editar perfil",style: botonStyle),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditarPerfil()),
                          );
                        },
                      ),
                    ],
                  ),
                ), */
              ],
            ),
          )
        ],
      ),
    );
  }
}
