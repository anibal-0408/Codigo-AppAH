import 'package:aprender_haciendo_app/core/models/cursosModelDB.dart';
import 'package:aprender_haciendo_app/core/services/helpers/cursoServices.dart';
import 'package:flutter/cupertino.dart';

class CursoProvider with ChangeNotifier {
  List<CursosModelDB> _cursos = [];
  CursoServices _cursoServices = CursoServices();

  CursoProvider.initialize() {
    _getCursos();
  }

  //getter
  List<CursosModelDB> get cursos => _cursos;

  //methods
  void _getCursos() async {
    _cursos = await _cursoServices.getCursos();
    notifyListeners();
  }
}
