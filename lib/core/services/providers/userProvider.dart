import 'dart:async';
import 'package:aprender_haciendo_app/core/models/carritoModelDB.dart';
import 'package:aprender_haciendo_app/core/models/orderModelDB.dart';
import 'package:aprender_haciendo_app/core/models/userModelDB.dart';
import 'package:aprender_haciendo_app/core/services/authRequest.dart';
import 'package:aprender_haciendo_app/core/services/helpers/orderServices.dart';
import 'package:aprender_haciendo_app/core/services/helpers/userServices.dart';
import 'package:aprender_haciendo_app/core/services/singIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  //Map<String, CarritoModelDB> _items = {};
  UserModel _userModel;
  List<OrderModelDB> _order = [];



//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;
  List<OrderModelDB> get order => _order;

  //List<UserModel> _userinfo = [];

  // public variables
  List<OrderModelDB> orders = [];
  final formkey = GlobalKey<FormState>();

  /* TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController(); */
  /* UserProvider() {
    UserProvider.initialize();
  }  */

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<AuthenticationRequest> loginUser(
      {String email = "", String password = ""}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      _status = Status.Authenticating;
      notifyListeners();
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        authRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
      _status = Status.Unauthenticated;
      notifyListeners();
    }
    return authRequest;
  }

  // Email & Password Sign Up
  Future<AuthenticationRequest> createUser(
      {String nombre,
      String apellido,
      String telefono,
      String email,
      String password,
      DateTime fechaNacimiento}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      _status = Status.Authenticating;
      notifyListeners();
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      /* 
          .then(
        (user) {
          _userServices.createUser(
            {
              'nombre': nombre,
              'apellido': apellido,
              'telefono': telefono,
              'email': email,
              'password': password,
              'uid': user.user.uid,

            },
          );
        },
      ); */
      if (user != null) {
        authRequest.success = true;
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _status = Status.Unauthenticated;
      signOutGoogle();

      notifyListeners();
      return Future.delayed(Duration.zero);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String> getCurrentUID() async {
  try {
      return (await _auth.currentUser()).uid;
    } catch (e) {
      print(e);
    }
    return null;
  }
  
  
  
  Future sendPasswordResetEmail(String email) async {
    try {
       await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
    return null;
  }

  void _mapErrorMessage(AuthenticationRequest authRequest, String code) {
    switch (code) {
      case 'ERROR_USER_NOT_FOUND':
        authRequest.errorMessage = "Usuario no encontrado";
        break;
      case 'ERROR_WRONG_PASSWORD':
        authRequest.errorMessage = "Contraseña invalida";
        break;
      case 'ERROR_NETWORK_REQUEST_FAIL':
        authRequest.errorMessage = "Error de Red";
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        authRequest.errorMessage = "Usuario ya registrado";
        break;
      default:
        authRequest.errorMessage = code;
    }
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    _order = await _orderServices.getOrdersByUser(user.uid);
    notifyListeners();
  }
  /* Future<void> reloadUserModel() async {
    var userId = (await FirebaseAuth.instance.currentUser()).uid;
    _userModel = await _userServices.getUserById(userId); //user.uid
    notifyListeners();
  } */

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
      _order = await _orderServices.getOrdersByUser(user.uid);
    }
    notifyListeners();
  }

  Future<void> addItem(
      String codigo, int precio, String image, String nombre) async {
    try {
      var userId = (await FirebaseAuth.instance.currentUser()).uid;
      _userModel = await _userServices.getUserById(userId);
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      //List cart = _userModel.cart;
      Map cartItem = {
        "id": cartItemId,
        "nombre": nombre,
        "image": image,
        "codigo": codigo,
        "precio": precio
      };
      CarritoModelDB item = CarritoModelDB.fromMap(cartItem);
      _userServices.addToCart(userId: userId, cartItem: item);

      /* if (_items.containsKey(codigo)) {
        _items.update(
          codigo,
          (existing) => CarritoModelDB(
            codigo: existing.codigo,
            precio: existing.precio,
            image: existing.image,
            quantity: existing.quantity + 1,
            nombre: existing.nombre,
          ),
        ); 

        print("${product.nombre} is added to cart multiple");
      } else {
        _items.putIfAbsent(
            codigo,
            () => CarritoModelDB(
                  codigo: DateTime.now().toString(),
                  precio: precio,
                  image: image,
                  quantity: 1,
                  nombre: nombre,
                ));
        print("$nombre is added to cart");
      }*/
      notifyListeners();
      return true;
    } catch (e) {
      print("The error ${e.toString()}");
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFromCart({CarritoModelDB cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}, ${cartItem.nombre}");
    var userId = (await FirebaseAuth.instance.currentUser()).uid;
    try {
      _userServices.removeFromCart(userId: userId, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  /* void getOrdersByUID() async {
    _order = await _orderServices.getOrdersByUser(user.uid);
    notifyListeners();
  } */

  void createOrder(
      {String uid, String id, List<CarritoModelDB> cart, int total, String metEnvio, String metPago}) {
        
    List<Map> convertedCart = [];
    for (CarritoModelDB item in cart) {
      convertedCart.add(item.toMap());
    }
    _firestore.collection("orders").document(id).setData({
      "uid": uid,
      "id": id,
      "fecha": DateTime.now(),
      "cart": convertedCart,
      "metEnvio": metEnvio,
      "metPago": metPago,
      "total": total,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
    });
  }

  

  /* void getOrders() async {
    var userId = (await FirebaseAuth.instance.currentUser()).uid;
    orders = await _orderServices.getUserOrders(userId: userId);
    notifyListeners();
  } */

  /* void addItem(String codigo, int precio, String image, String nombre, int quantity) async {
    try {
      var userId = (await FirebaseAuth.instance.currentUser()).uid;
      _userModel = await _userServices.getUserById(userId);
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      Map cartItem = {
        "id": cartItemId,
        "nombre": nombre,
        "image": image,
        "codigo": codigo,
        "precio": precio,
        "quantity": quantity
      };
      CarritoModelDB item = CarritoModelDB.fromMap(cartItem);
      _userServices.addToCart(userId: userId, cartItem: item);
      if (_items.containsKey(codigo)) {
        _items.update(
          codigo,
          (existing) => CarritoModelDB(
            codigo: existing.codigo,
            precio: existing.precio,
            image: existing.image,
            quantity: existing.quantity + 1,
            nombre: existing.nombre,
          ),
        );
        print("$nombre is added to cart multiple");
      } else {
        _items.putIfAbsent(
            codigo,
            () => CarritoModelDB(
                  codigo: DateTime.now().toString(),
                  precio: precio,
                  image: image,
                  quantity: 1,
                  nombre: nombre,
                ));
        print("$nombre is added to cart");
      }
      notifyListeners();
    } catch (e) {
      print("The error ${e.toString()}");
      notifyListeners();
    }
  }
 */

  /*
  void _getUser() async {
    var userId = (await FirebaseAuth.instance.currentUser()).uid;
    _userModel = await _userServices.getUserById(userId);
    notifyListeners();
  }

   getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  } */

/* 
  Map<String, CarritoModelDB> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, cartItem) {
      total = total + cartItem.precio * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String codigo) {
    _items.remove(codigo);
    notifyListeners();
  }

  void removeOneItem(String codigo) {
    _items.remove(codigo);
    notifyListeners();
  }

  void addOneItem(String codigo, int precio, String image, String nombre) {
    addItem(codigo, precio, image, nombre);
    notifyListeners();
  } */

}
