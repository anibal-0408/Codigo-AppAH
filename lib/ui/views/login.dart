import 'package:aprender_haciendo_app/core/services/providers/userProvider.dart';
import 'package:aprender_haciendo_app/core/services/validationMixins.dart';
import 'package:aprender_haciendo_app/ui/widgets/appErrorMessage.dart';
import 'package:aprender_haciendo_app/ui/widgets/customDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatelessWidget {
  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin, ValidationMixins {
  AnimationController _controller;
  FocusNode _userFocus = FocusNode();
  FocusNode _passFocus = FocusNode();
  FocusNode _focusNode = FocusNode();
  String _email;
  String _password;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool showSpinner = false;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  GlobalKey<FormState> keyForm = new GlobalKey();
  String _errorMessage = "";
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userFocus = FocusNode();
    _passFocus = FocusNode();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _userFocus.dispose();
    _passFocus.dispose();
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void setSpinnerStatus(bool status) {
    setState(() {
      showSpinner = status;
    });
  }

  _login() async {
    if (keyForm.currentState.validate()) {
      try {
        var auth = await UserProvider.initialize().loginUser(email: _email, password: _password);
        print('$_email y $_password');
        if (auth.success) {
          Navigator.pushNamed(context, '/index');
          _emailController.text = "";
          _passwordController.text = "";
        } else {
          print(auth.errorMessage);
          setState(() {
            _errorMessage = auth.errorMessage;
          });
        }
        Navigator.pushReplacementNamed(context, '/Tienda');
      } catch (e) {
        print(e);
      }
    } else {
      setState(() => _autoValidate =  AutovalidateMode.always);
    }
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

  void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(620), //cuadro blanco del login
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Colors.black12,offset: Offset(0.0, 15.0),blurRadius: 15.0),
            BoxShadow(color: Colors.black12,offset: Offset(0.0, -10.0),blurRadius: 10.0),
          ]),
      child: Visibility(
        visible: _isVisible,
        child: loginScaffold(),
        replacement: recuperarPassScaffold(),
      ),
    );
  }

  Widget loginScaffold() {
    return Scaffold(
      body: ModalProgressHUD(
        //estos hacen que no se puedan poner ratio en el borde
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Form(
                key: keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    Text("Correo Electrónico",style: TextStyle(fontFamily: "Poppins-Medium",fontSize: ScreenUtil.getInstance().setSp(30))),
                    _correoField(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    Text("Contraseña",style: TextStyle(fontFamily: "Poppins-Medium",fontSize: ScreenUtil.getInstance().setSp(30))),
                    _passField(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    _showErrorMessage(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    _ingresarButton(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(50)),
                    _olvidoPass(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget recuperarPassScaffold() {
    return Scaffold(
      body: ModalProgressHUD(
        //estos hacen que no se puedan poner ratio en el borde
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Form(
                key: keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil.getInstance().setHeight(120)),
                    Text("Ingrese su correo electrónico",style: TextStyle(fontFamily: "Poppins-Medium",fontSize: ScreenUtil.getInstance().setSp(30))),
                    _correoField(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                    _recuperarButton(),
                    SizedBox(height: ScreenUtil.getInstance().setHeight(50)),
                    _iniciarSesion(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ingresarButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(560),
            height: ScreenUtil.getInstance().setHeight(100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF65c6f4), Color(0xFF0074c9)]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(color: Color(0xFF6078ea).withOpacity(.3),offset: Offset(0.0, 8.0),blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  setSpinnerStatus(true);
                  await _login();
                  setSpinnerStatus(false);
                },
                child: Center(
                  child: Text("INGRESAR",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Bold",fontSize: 18,letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _recuperarButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(560),
            height: ScreenUtil.getInstance().setHeight(100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF65c6f4), Color(0xFF0074c9)]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(color: Color(0xFF6078ea).withOpacity(.3), offset: Offset(0.0, 8.0), blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  setSpinnerStatus(true);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "Recuperación de contraseña",
                      description:
                          "Recibirá un correo con el link para cambiar la contraseña a ${_emailController.text}",
                      primaryButtonText: "Aceptar",
                      primaryButton: _aceptar,
                      secondaryButtonText: "Cancelar",
                      secondaryButton: _cancelar,
                    ),
                  );
                  setSpinnerStatus(false);
                },
                child: Center(
                  child: Text("RECUPERAR",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Bold",fontSize: 18,letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _olvidoPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new GestureDetector(
          onTap: () {
            setState(() => _isVisible = !_isVisible);
            _emailController.text = "";
          },
          child: new Text("¿Olvidó la contraseña?",style: TextStyle(color: Colors.blue,fontFamily: "Poppins-Medium",fontSize: ScreenUtil.getInstance().setSp(28)),
          ),
        ),
      ],
    );
  }

  Widget _iniciarSesion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new GestureDetector(
          onTap: () {
            setState(() => _isVisible = !_isVisible);
            _emailController.text = "";
            _passwordController.text = "";
          },
          child: new Text("Iniciar sesión", style: TextStyle(color: Colors.blue,fontFamily: "Poppins-Medium",fontSize: ScreenUtil.getInstance().setSp(28))),
        ),
      ],
    );
  }

  void _cancelar() {
    Navigator.of(context).pop();
  }

  void _aceptar() async {
    try {
      await UserProvider.initialize().sendPasswordResetEmail(_emailController.text.trim());
      print('$_email');
    } catch (e) {
      print(e);
    }
    Navigator.of(context).pop();
    _emailController.text = "";
    _passwordController.text = "";
    setState(() => _isVisible = !_isVisible);
  }

  Widget _correoField() {
    return TextFormField(
      autovalidateMode: _autoValidate,
      controller: _emailController,
      focusNode: _userFocus,
      onFieldSubmitted: (value) {
        _fieldFocusChange(context, _userFocus, _passFocus);
      },
      validator: validateEmail,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        _email = value;
      },
    );
  }

  Widget _passField() {
    return TextFormField(
      autovalidateMode: _autoValidate,
      controller: _passwordController,
      obscureText: true,
      focusNode: _passFocus,
      validator: validatePass,
      onFieldSubmitted: (term) {
        _passFocus.unfocus();
        _focusNode.unfocus();
      },
      decoration: InputDecoration(hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        _password = value;
      },
    );
  }
}
