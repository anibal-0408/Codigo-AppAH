import 'package:aprender_haciendo_app/core/services/validationMixins.dart';
import 'package:aprender_haciendo_app/ui/shared/constants.dart';
import 'package:aprender_haciendo_app/ui/widgets/appErrorMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

//ultimo
class EditarPerfil extends StatefulWidget {
  static const String routeName = '/EditaPerfil';

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> with ValidationMixins {
  final auth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController apellidosCtrl = new TextEditingController();
  TextEditingController nacimientoCtrl = new TextEditingController();
  TextEditingController telCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();
  FocusNode _nombreFocus = FocusNode();
  FocusNode _apellidosFocus = FocusNode();
  FocusNode _nacimientoFocus = FocusNode();
  FocusNode _telefonoFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passFocus = FocusNode();
  FocusNode _reppassFocus = FocusNode();
  FocusNode _none = FocusNode();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool showSpinner = false;
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  static Pattern patternStr = r'(^[a-zA-Z ]*$)';
  RegExp regExpStr = new RegExp(patternStr);
  static Pattern pattterntel = r'(^[0-9]*$)';
  RegExp regExptel = new RegExp(pattterntel);
  bool isDateSelected = false;
  DateTime fechaNacimiento; // instance of DateTime
  String birthDateInString;
  String _errorMessage = "";

  void setSpinnerStatus(bool status) {
    setState(
      () {
        showSpinner = status;
      },
    );
  }

  //String _email; // guion bajo es para que sea interna
  //String _password;
  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController();
    apellidosCtrl = TextEditingController();
    nacimientoCtrl = TextEditingController();
    telCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    repeatPassCtrl = TextEditingController();
    _nombreFocus = FocusNode();
    _apellidosFocus = FocusNode();
    _nacimientoFocus = FocusNode();
    _telefonoFocus = FocusNode();
    _emailFocus = FocusNode();
    _passFocus = FocusNode();
    _reppassFocus = FocusNode();
    _none = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    nombreCtrl.dispose();
    apellidosCtrl.dispose();
    nacimientoCtrl.dispose();
    telCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    repeatPassCtrl.dispose();
    _nombreFocus.dispose();
    _apellidosFocus.dispose();
    _nacimientoFocus.dispose();
    _telefonoFocus.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _reppassFocus.dispose();
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

  _registrarse() async {
    if (keyForm.currentState.validate()) {
      Navigator.pushNamed(context, '/perfil');
      createRecord();
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }

  void borrarEditarPerfil() {
    nombreCtrl.text = "";
    apellidosCtrl.text = "";
    fechaNacimiento = DateTime.now();
    telCtrl.text = "";
    emailCtrl.text = "";
    passwordCtrl.text = "";
    repeatPassCtrl.text = "";
  }

  void createRecord() async {
    var userId = (await FirebaseAuth.instance.currentUser()).uid;
    var ref = databaseReference.collection("users").document("$userId");
    await ref.setData(
      {
        'uid': '$userId',
        'nombre': '${nombreCtrl.text}',
        'apellido': '${apellidosCtrl.text}',
        'fechaNacimiento': '$fechaNacimiento',
        'telefono': '${telCtrl.text}',
        'email': '${emailCtrl.text}',
        'contraseña': '${passwordCtrl.text}'
      },
    );
    borrarEditarPerfil();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF4cb2e2),
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(backgroundColor: Color(0xFF4cb2e2), elevation: 0.0),
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
                            _nombreField(),
                            Sized22,
                            _apellidosField(),
                            Sized22,
                            _fechaNacimientoField(),
                            Sized22,
                            _telefonoField(),
                            Sized22,
                            _emailField(),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(20),
                            ),
                            _showErrorMessage(),
                            Sized22,
                            _submitButton(),
                            Sized22
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget _nombreField() {
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

  Widget _apellidosField() {
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

  Widget _fechaNacimientoField() {
    return TextFormField(
      style: TextStyle(fontFamily: "Poppins-Medium"),
      autovalidateMode: _autoValidate,
      controller: nacimientoCtrl,
      decoration: new InputDecoration(labelText: 'Fecha nacimiento'),
      focusNode: _nacimientoFocus,
      onFieldSubmitted: (value) {
        _fieldFocusChange(context, _nacimientoFocus, _telefonoFocus);
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.datetime,
      validator: validateNacimiento,
      onTap: () async {
        final datePick = await showDatePicker(
            context: context,
            initialDate: new DateTime.now(),
            firstDate: new DateTime(1900),
            lastDate: new DateTime(2100));
        if (datePick != null && datePick != fechaNacimiento) {
          setState(
            () {
              fechaNacimiento = datePick;
              isDateSelected = true;
              nacimientoCtrl.text =
                  "${fechaNacimiento.day}/${fechaNacimiento.month}/${fechaNacimiento.year}";
            },
          );
        }
        new Text(isDateSelected
            ? "$fechaNacimiento"
            : "Seleccione su fecha de nacimiento");
      },
      /*   onChanged: (value){
        nacimientoCtrl = value as TextEditingController;
      },                
          textInputAction: TextInputAction.next,*/
    );
  }

  Widget _telefonoField() {
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

  Widget _emailField() {
    return TextFormField(
        style: TextStyle(fontFamily: "Poppins-Medium"),
        autovalidateMode: _autoValidate,
        controller: emailCtrl,
        decoration: new InputDecoration(labelText: 'Correo electrónico'),
        focusNode: _emailFocus,
        onFieldSubmitted: (value) {
          _fieldFocusChange(context, _emailFocus, _passFocus);
        },
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          emailCtrl = value as TextEditingController;
        },
        validator: validateEmail,
        textInputAction: TextInputAction.next);
  }

  Widget _submitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(450),
            height: ScreenUtil.getInstance().setHeight(100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF65c6f4), Color(0xFF0074c9)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  setSpinnerStatus(true);
                  await _registrarse();
                  setSpinnerStatus(false);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 12.0, bottom: 20.0),
                  child: Center(
                    child: Text("GUARDAR CAMBIOS",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins-Bold",
                            fontSize: 16,
                            letterSpacing: 1.0)),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
