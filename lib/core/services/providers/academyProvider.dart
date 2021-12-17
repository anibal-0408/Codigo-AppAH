import 'package:aprender_haciendo_app/core/models/academyModelDB.dart';
import 'package:aprender_haciendo_app/core/services/helpers/academyServices.dart';
import 'package:flutter/cupertino.dart';

class AcademyProvider with ChangeNotifier {
  List<AcademyModelDB> _certificaciones = [];
  AcademyServices _academyServices = AcademyServices();

  AcademyProvider.initialize() {
    _getCertificaciones();
  }

  //getter
  List<AcademyModelDB> get certificaciones => _certificaciones;

  //methods
  void _getCertificaciones() async {
    _certificaciones = await _academyServices.getCertificaciones();
    notifyListeners();
  }
}