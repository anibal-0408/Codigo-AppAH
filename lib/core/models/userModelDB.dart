import 'package:aprender_haciendo_app/core/models/carritoModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  static const UID = "uid";
  static const NOMBRE = "nombre";
  static const APELLIDO = "apellido";
  static const EMAIL = "email";
  static const CART = "cart";
  static const TOTALCARTPRICE = "totalCartPrice";
  static const FECHANACIMIENTO = "fechaNacimiento";
  static const TELEFONO = "telefono";
  static const DIRECCION = "direccion";

  String _uid;
  String _nombre;
  String _apellido;
  String _email;
  int _priceSum = 0;
  String _fechaNacimiento;
  String _telefono;
  String _direccion;

//  getters
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get email => _email;
  String get uid => _uid;
  String get fechaNacimiento => _fechaNacimiento;
  String get telefono => _telefono;
  String get direccion => _direccion;

  // public variables
  List<CarritoModelDB> cart;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _nombre = snapshot.data[NOMBRE];
    _apellido = snapshot.data[APELLIDO];
    _email = snapshot.data[EMAIL];
    _fechaNacimiento = snapshot.data[FECHANACIMIENTO];
    _telefono = snapshot.data[TELEFONO];
    _uid = snapshot.data[UID];
    _direccion = snapshot.data[DIRECCION];
    cart = _convertCartItems(snapshot.data[CART] ?? []);
    totalCartPrice = snapshot.data[CART] == null
        ? 0
        : getTotalPrice(cart: snapshot.data[CART]);
  }

  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["precio"];
    }
    int total = _priceSum;
    return total;
  }

  List<CarritoModelDB> _convertCartItems(List cart) {
    List<CarritoModelDB> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CarritoModelDB.fromMap(cartItem));
    }
    return convertedCart;
  }
}
