import 'package:aprender_haciendo_app/core/models/academyModelDB.dart';
import 'package:aprender_haciendo_app/ui/shared/constants.dart';
import 'package:aprender_haciendo_app/ui/views/tienda.dart';
import 'package:aprender_haciendo_app/ui/widgets/appErrorMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';


final TextStyle barStyle = TextStyle(fontFamily: "Poppins-Bold", color: Colors.black);
final auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;
GlobalKey<FormState> keyForm = new GlobalKey();
TextEditingController nombreCtrl = new TextEditingController();
TextEditingController apellidosCtrl = new TextEditingController();
TextEditingController telCtrl = new TextEditingController();
TextEditingController emailCtrl = new TextEditingController();
TextEditingController domicilioCtrl = new TextEditingController();
FocusNode _nombreFocus = FocusNode();
FocusNode _apellidosFocus = FocusNode();
FocusNode _domicilioFocus = FocusNode();
FocusNode _telefonoFocus = FocusNode();
FocusNode _emailFocus = FocusNode();
FocusNode _none = FocusNode();
AutovalidateMode _autoValidate = AutovalidateMode.disabled;
bool showSpinner = false;
Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regex = new RegExp(pattern);
Pattern patternStr = r'(^[a-zA-Z ]*$)';
RegExp regExpStr = new RegExp(patternStr);
Pattern pattterntel = r'(^[0-9]*$)';
RegExp regExptel = new RegExp(pattterntel);
bool isDateSelected = false;
DateTime fechaNacimiento; // instance of DateTime
String birthDateInString;
String _errorMessage = "";
var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle:
      TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins-Medium"),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: Colors.grey)),
);


class Inscripcion extends StatelessWidget {
  final AcademyModelDB inscripcion;
  const Inscripcion({Key key, this.inscripcion}) : super(key: key);

  @override
  void setSpinnerStatus(bool status) {
      showSpinner = status;
  }
  void initState() {
    nombreCtrl = TextEditingController();
    apellidosCtrl = TextEditingController();
    domicilioCtrl = TextEditingController();
    telCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    _nombreFocus = FocusNode();
    _apellidosFocus = FocusNode();
    _domicilioFocus = FocusNode();
    _telefonoFocus = FocusNode();
    _emailFocus = FocusNode();
    _none = FocusNode();
  }
  void dispose() {
    nombreCtrl.dispose();
    apellidosCtrl.dispose();
    domicilioCtrl.dispose();
    telCtrl.dispose();
    emailCtrl.dispose();
    _nombreFocus.dispose();
    _apellidosFocus.dispose();
    _domicilioFocus.dispose();
    _telefonoFocus.dispose();
    _emailFocus.dispose();
    _none.dispose();
  }
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return ErrorMessage(errorMessage: _errorMessage);
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  /* _registrarse() async {
    if (keyForm.currentState.validate()) {    
      createRecord();     
    } else {
      setState(() => __autoValidate =  AutovalidateMode.always);
    }
  } */

  void borrarInscripcion() {
    nombreCtrl.text = "";
    apellidosCtrl.text = "";
    telCtrl.text = "";
    emailCtrl.text = "";
    domicilioCtrl.text = "";
  }

/*   void createRecord() async {
    var curso = certificacion;
    var userId = (await FirebaseAuth.instance.currentUser()).uid;
    var ref = databaseReference.collection("inscripciones").document();
    await ref.setData(
      {
        'uid': '$userId',
        'curso': '$curso',
        'nombre': '${nombreCtrl.text}',
        'apellido': '${apellidosCtrl.text}',
        'telefono': '${telCtrl.text}',
        'domicilio': '${domicilioCtrl.text}',
        'email': '${emailCtrl.text}'
      },
    );
    _onAlertButton(context);
    borrarInscripcion(); 
  } */

  _onAlertButton(context) {
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "",
      desc: "Inscripción enviada. Pronto se podran en contacto con usted",
      buttons: [
        DialogButton(
          child: Text("ACEPTAR",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Poppins-Medium")),
          onPressed: () => Navigator.pushNamed(context, '/index'),
          width: 120,
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(25.0),
          child: new Form(
            key: keyForm,
            child: Container(
              height: ScreenUtil.getInstance().setHeight(1070),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0),
                      blurRadius: 15.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -10.0),
                      blurRadius: 10.0),
                ],
              ),
              child: Scaffold(
                body: ModalProgressHUD(
                  inAsyncCall: showSpinner,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
                      child: Column(
                        children: <Widget>[
                          _nombreField(context),
                          Sized22,
                          _apellidosField(context),
                          Sized22,
                          _telefonoField(context),
                          Sized22,
                          _emailField(context),
                          Sized22,
                          _domicilioField(context),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(20),
                          ),
                          _showErrorMessage(),
                          Sized22,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  width: ScreenUtil.getInstance().setWidth(450),
                                  height:
                                      ScreenUtil.getInstance().setHeight(100),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFFd10100),
                                      Color(0xFFfe4936)
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color(0xFF6078ea).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        setSpinnerStatus(true);
                                        if (keyForm.currentState.validate()) {
                                          _onAlertButton(context);
                                          var userId = (await FirebaseAuth.instance.currentUser()).uid;
                                          //var inscri = Inscripcion().inscripcion.nombre;
                                          var ref = databaseReference.collection("inscripciones").document();
                                          await ref.setData(
                                            {
                                              'uid': '$userId',
                                              'fecha': '${DateTime.now()}',
                                              'curso':'${inscripcion.nombre}',
                                              'nombre': '${nombreCtrl.text}',
                                              'apellido':'${apellidosCtrl.text}',
                                              'telefono': '${telCtrl.text}',
                                              'domicilio': '${domicilioCtrl.text}',
                                              'email': '${emailCtrl.text}'
                                            },
                                          );
                                          
                                            String username = 'aprenderhaciendoprueba@gmail.com';
                                            String password = 'Ahprueba2020';
                                            final smtpServer = gmail(username, password);
                                            var connection = PersistentConnection(smtpServer);
                                            final message = Message()
                                              ..from = Address(username, 'Aprender Haciendo')
                                              ..recipients.add('${user.user.email}')
                                              //..ccRecipients.addAll(['aprenderhaciendoprueba@gmail.com'])
                                              ..bccRecipients.add(Address('aprenderhaciendoprueba@gmail.com'))
                                              ..subject =
                                                  'Aprender Haciendo :: Inscripción :: ${inscripcion.nombre}'
                                              //..text = 'This is the plain text.\nThis is line 2 of the text part.';
                                              ..html =
                                                  "<h1>Hola ${user.user.displayName},</h1>\n<p>Gracias por inscribirse al curso ${inscripcion.nombre} de Aprender Haciendo, pronto se pondran en contacto con usted para completar el proceso de inscripción</p>";
                                            try {
                                              //final sendReport = await send(message, smtpServer);
                                              await connection.send(message);
                                              //print('Message sent: ' + sendReport.toString());
                                              print('Message sent');
                                            } on MailerException catch (e) {
                                              print('Message not sent.');
                                              for (var p in e.problems) {
                                                print('Problem: ${p.code}: ${p.msg}');
                                              }
                                            }

                                          borrarInscripcion();
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Tienda()));
                                        } else {
                                          _autoValidate =  AutovalidateMode.always;
                                        }
                                        setSpinnerStatus(false);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 16.0,
                                            right: 16.0,
                                            top: 12.0,
                                            bottom: 20.0),
                                        child: Center(
                                          child: Text("INSCRIBIRSE",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Bold",fontSize: 17,letterSpacing: 1.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Sized22
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nombreField(context) {
    return TextFormField(
      style: TextStyle(fontFamily: "Poppins-Medium"),
      autovalidateMode: _autoValidate,
      controller: nombreCtrl,
      decoration: new InputDecoration(labelText: 'Nombre'),
      focusNode: _nombreFocus,
      onFieldSubmitted: (value) {
        _fieldFocusChange(context, _nombreFocus, _apellidosFocus);
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        nombreCtrl = value as TextEditingController;
      },
      validator: validateNombre,
    );
  }

  Widget _apellidosField(context) {
    return TextFormField(
      style: TextStyle(fontFamily: "Poppins-Medium"),
      autovalidateMode: _autoValidate,
      controller: apellidosCtrl,
      decoration: new InputDecoration(labelText: 'Apellidos'),
      focusNode: _apellidosFocus,
      onFieldSubmitted: (value) {
        _fieldFocusChange(context, _apellidosFocus, _none);
      },
      keyboardType: TextInputType.text,
      onChanged: (value) {
        apellidosCtrl = value as TextEditingController;
      },
      validator: validateApellidos,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _telefonoField(context) {
    return TextFormField(
      style: TextStyle(fontFamily: "Poppins-Medium"),
      autovalidateMode: _autoValidate,
      controller: telCtrl,
      decoration: new InputDecoration(labelText: 'Teléfono'),
      focusNode: _telefonoFocus,
      onFieldSubmitted: (value) {
        _fieldFocusChange(context, _telefonoFocus, _emailFocus);
      },
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        telCtrl = value as TextEditingController;
      },
      validator: validateTelefono,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _emailField(context) {
    return TextFormField(
        style: TextStyle(fontFamily: "Poppins-Medium"),
        autovalidateMode: _autoValidate,
        controller: emailCtrl,
        decoration: new InputDecoration(labelText: 'Correo electrónico'),
        focusNode: _emailFocus,
        onFieldSubmitted: (value) {
          _fieldFocusChange(context, _emailFocus, _none);
        },
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          emailCtrl = value as TextEditingController;
        },
        validator: validateEmail,
        textInputAction: TextInputAction.next);
  }

  Widget _domicilioField(context) {
    return TextFormField(
      style: TextStyle(fontFamily: "Poppins-Medium"),
      autovalidateMode: _autoValidate,
      controller: domicilioCtrl,
      decoration: new InputDecoration(labelText: 'Domicilio'),
      focusNode: _domicilioFocus,
      onFieldSubmitted: (value) {
        _fieldFocusChange(context, _domicilioFocus, _apellidosFocus);
      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        domicilioCtrl = value as TextEditingController;
      },
      //validator: validateNombre,
    );
  }
  String validateNombre(String value) {
    if (value.length == 0) {
      return "El nombre es necesario";
      /* } else if (!regExpStr.hasMatch(value)) {
    return "El nombre debe de ser a-z y A-Z"; */
    } else if (value.isEmpty) {
      return 'Por favor ingrese su Nombre';
    }
    return null;
  }

  String validateApellidos(String value) {
    if (value.length == 0) {
      return "Los apellidos son necesario";
      /* } else if (!regExpStr.hasMatch(value)) {
          return "El apellido debe de ser a-z y A-Z"; */
    } else if (value.isEmpty) {
      return 'Por favor ingrese sus Apellidos';
    }
    return null;
  }

  String validateNacimiento(String value) {
    if (value.isEmpty) {
      return 'Por favor ingrese su Fecha de nacimiento';
    }
    return null;
  }

  String validateTelefono(String value) {
    if (value.isEmpty) {
      return 'Por favor ingrese su telefono';
    } else if (!regExptel.hasMatch(value)) {
      return 'Su numero de telefono debe tener 8 digitos';
    } 
      return null;
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Ingrese su email';
    } else if (!regex.hasMatch(value)) {
      return 'Ingrese un email valido';
    }
    return null;
  }

  String validatePass(String value) {
    if (value.isEmpty) {
      return 'Por favor ingrese la contraseña';
    } else if (value.length < 6) {
      return 'Contraseña tiene que ser mayor de 6 caracteres';
    }
    return null;
  }
}
