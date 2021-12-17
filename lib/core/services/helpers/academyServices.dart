import 'package:aprender_haciendo_app/core/models/academyModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcademyServices {
  String collection = "academys";
  Firestore _firestore = Firestore.instance;

  Future<List<AcademyModelDB>> getCertificaciones() async =>
      _firestore.collection(collection).getDocuments().then(
        (result) {
          List<AcademyModelDB> certificaciones = [];
          for (DocumentSnapshot certificacion in result.documents) {
            certificaciones.add(AcademyModelDB.fromSnapshot(certificacion));
          }
          return certificaciones;
        },
      );
}
