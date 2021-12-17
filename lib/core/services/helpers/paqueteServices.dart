import 'package:aprender_haciendo_app/core/models/paquetesModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaqueteServices {
  String collection = "packs";
  Firestore _firestore = Firestore.instance;

  Future<List<PaquetesModelDB>> getPaquetes() async =>
      _firestore.collection(collection).getDocuments().then(
        (result) {
          List<PaquetesModelDB> paquetes = [];
          for (DocumentSnapshot paquete in result.documents) {
            paquetes.add(PaquetesModelDB.fromSnapshot(paquete));
          }
          return paquetes;
        },
      );
}
