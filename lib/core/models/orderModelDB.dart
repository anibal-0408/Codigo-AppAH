import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModelDB {
  static const ID = "id";
  static const CART = "cart";
  static const UID = "uid";
  static const TOTAL = "total";
  static const METPAGO = "metPago";
  static const METENVIO = "metEnvio";
  static const FECHA = "fecha";
  static const CREATEDAT = "createdAt";

  String _id;
  String _uid;
  int _createdAt;
  int _total;
  Timestamp _fecha;
  String _metPago;
  String _metEnvio;

  String get id => _id;
  String get uid => _uid;
  int get createdAt => _createdAt;
  Timestamp get fecha => _fecha;
  int get total => _total;
  String get metEnvio => _metEnvio;
  String get metPago => _metPago;

  List cart;

  OrderModelDB.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _uid = snapshot.data[UID];
    _createdAt = snapshot.data[CREATEDAT];
    _fecha = snapshot.data[FECHA];
    _total = snapshot.data[TOTAL];
    cart = snapshot.data[CART];
    _metEnvio = snapshot.data[METENVIO];
    _metPago = snapshot.data[METPAGO];
  }
}
