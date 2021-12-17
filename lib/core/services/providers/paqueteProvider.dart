import 'package:aprender_haciendo_app/core/models/paquetesModelDB.dart';
import 'package:aprender_haciendo_app/core/services/helpers/paqueteServices.dart';
import 'package:flutter/cupertino.dart';

class PaqueteProvider with ChangeNotifier {
  List<PaquetesModelDB> _paquetes = [];
  PaqueteServices _paqueteServices = PaqueteServices();

  PaqueteProvider.initialize() {
    _getPaquetes();
  }

  //getter
  List<PaquetesModelDB> get paquetes => _paquetes;

  //methods
  void _getPaquetes() async {
    _paquetes = await _paqueteServices.getPaquetes();
    notifyListeners();
  }
}
