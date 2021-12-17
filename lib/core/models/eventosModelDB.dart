import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventosModelDB with ChangeNotifier {
  static const ID = "id";
  static const NOMBRE = "nombre";
  static const DESCRIPCION = "descripcion";
  static const IMAGEN = "imagen";
  static const FECHA = "fecha";
  static const LINK = "link";

  int _id;
  String _nombre;
  String _descripcion;
  String _imagen;
  Timestamp _fecha;
  String _link;

  int get id => _id;
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  String get imagen => _imagen;
  Timestamp get fecha => _fecha;
  String get link => _link;
  
  // public variable
  bool liked = false;

  EventosModelDB.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _nombre = snapshot.data[NOMBRE];
    _descripcion = snapshot.data[DESCRIPCION];
    _imagen = snapshot.data[IMAGEN];
    _fecha = snapshot.data[FECHA];
    _link = snapshot.data[LINK];
  }
}
