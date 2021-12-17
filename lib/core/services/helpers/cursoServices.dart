import 'package:aprender_haciendo_app/core/models/cursosModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CursoServices {
  String collection = "cursos";
  Firestore _firestore = Firestore.instance;

  Future<List<CursosModelDB>> getCursos() async =>
      _firestore.collection(collection).getDocuments().then(
        (result) {
          List<CursosModelDB> cursos = [];
          for (DocumentSnapshot curso in result.documents) {
            cursos.add(CursosModelDB.fromSnapshot(curso));
          }
          return cursos;
        },
      );
}
