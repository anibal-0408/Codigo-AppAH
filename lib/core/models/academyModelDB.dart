import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcademyModelDB with ChangeNotifier {
  static const ID = "id";
  static const CODIGO = "codigo";
  static const NOMBRE = "nombre";
  static const PRECIO = "precio";
  static const IMAGEN = "imagen";
  static const DESCRIPCION = "descripcion";

  int _id;
  String _codigo;
  String _nombre;
  int _precio;
  String _imagen;
  String _descripcion;
  
  int get id => _id;
  String get codigo => _codigo;
  String get nombre => _nombre;
  int get precio => _precio;
  String get imagen => _imagen;
  String get descripcion => _descripcion;
  
  // public variable
  bool liked = false;

  AcademyModelDB.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _codigo = snapshot.data[CODIGO];
    _nombre = snapshot.data[NOMBRE];
    _precio = snapshot.data[PRECIO].floor();
    _imagen = snapshot.data[IMAGEN];
    _descripcion = snapshot.data[DESCRIPCION];
  }
}
