import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CursosModelDB with ChangeNotifier {
  static const CODIGO = "codigo";
  static const ID = "id";
  static const NOMBRE = "nombre";
  static const PRECIO = "precio";
  static const IMAGEN = "imagen";
  static const MODALIDAD = "modalidad";
  static const RANGOEDAD = "rangoEdad";
  static const DESCRIPCION = "descripcion";

  String _codigo;
  int _id;
  String _nombre;
  int _precio;
  String _imagen;
  String _modalidad;
  String _rangoEdad;
  String _descripcion;

  String get codigo => _codigo;
  int get id => _id;
  String get nombre => _nombre;
  int get precio => _precio;
  String get imagen => _imagen;
  String get modalidad => _modalidad;
  String get rangoEdad => _rangoEdad;
  String get descripcion => _descripcion;

  // public variable
  bool liked = false;

  CursosModelDB.fromSnapshot(DocumentSnapshot snapshot) {
    _codigo = snapshot.data[CODIGO];
    _id = snapshot.data[ID];
    _nombre = snapshot.data[NOMBRE];
    _precio = snapshot.data[PRECIO].floor();
    _imagen = snapshot.data[IMAGEN];
    _modalidad = snapshot.data[MODALIDAD];
    _rangoEdad = snapshot.data[RANGOEDAD];
    _descripcion = snapshot.data[DESCRIPCION];
  }
}
