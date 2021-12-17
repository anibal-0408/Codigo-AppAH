import 'package:aprender_haciendo_app/core/models/eventosModelDB.dart';
import 'package:aprender_haciendo_app/core/services/helpers/eventoServices.dart';
import 'package:flutter/cupertino.dart';

class EventoProvider with ChangeNotifier {
  List<EventosModelDB> _eventos = [];
  EventoServices _eventoServices = EventoServices();

  EventoProvider.initialize() {
    _getEventos();
  }

  //getter
  List<EventosModelDB> get eventos => _eventos;

  //methods
  void _getEventos() async {
    _eventos = await _eventoServices.getEventos();
    notifyListeners();
  }
}
