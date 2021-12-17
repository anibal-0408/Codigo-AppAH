import 'package:aprender_haciendo_app/core/models/eventosModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventoServices {
  String collection = "Eventos";
  Firestore _firestore = Firestore.instance;

  Future<List<EventosModelDB>> getEventos() async =>
      _firestore.collection(collection).getDocuments().then(
        (result) {
          List<EventosModelDB> eventos = [];
          for (DocumentSnapshot evento in result.documents) {
            eventos.add(EventosModelDB.fromSnapshot(evento));
          }
          return eventos;
        },
      );
}