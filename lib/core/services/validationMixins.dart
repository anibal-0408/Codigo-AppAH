class ValidationMixins {
  static Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  static Pattern patternStr = r'(^[a-zA-Z ]*$)';
  RegExp regExpStr = new RegExp(patternStr);
  static Pattern pattterntel = r'(^[0-9]*$)';
  RegExp regExptel = new RegExp(pattterntel);

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
