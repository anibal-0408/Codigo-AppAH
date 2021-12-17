import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaquetesModelDB with ChangeNotifier {
  static const ID = "id";
  static const CODIGO = "codigo";
  static const NOMBRE = "nombre";
  static const DESCRIPCION = "descripcion";
  static const CATEGORIA = "categoria";
  static const PRECIO = "precio";
  static const CANTPIEZAS = "cantPiezas";
  static const IMAGEN = "imagen";
  static const IMAGEN2 = "imagen2";
  static const ISSELECTED = "isselected";
  static const EDADES = "edades";

  int _id;
  String _codigo;
  String _nombre;
  String _descripcion;
  String _categoria;
  int _precio;
  int _cantPiezas;
  String _imagen;
  String _imagen2;
  bool _isSelected;
  String _edades;

  int get id => _id;
  String get codigo => _codigo;
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  String get categoria => _categoria;
  String get edades => _edades;
  int get precio => _precio;
  int get cantPiezas => _cantPiezas;
  String get imagen => _imagen;
  String get imagen2 => _imagen2;
  bool get isSelected => _isSelected;

  // public variable
  bool liked = false;

  PaquetesModelDB.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _codigo = snapshot.data[CODIGO];
    _nombre = snapshot.data[NOMBRE];
    _descripcion = snapshot.data[DESCRIPCION];
    _categoria = snapshot.data[CATEGORIA];
    _precio = snapshot.data[PRECIO].floor();
    _cantPiezas = snapshot.data[CANTPIEZAS].floor();
    _imagen = snapshot.data[IMAGEN];
    _imagen2 = snapshot.data[IMAGEN2];
    _isSelected = snapshot.data[ISSELECTED];
    _edades = snapshot.data[EDADES];
  }
}
