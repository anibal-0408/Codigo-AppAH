import 'package:aprender_haciendo_app/core/models/carritoModelDB.dart';
import 'package:aprender_haciendo_app/core/models/userModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  Firestore _firestore = Firestore.instance;
  String collection = "users";

  void createUser(Map data) {
    _firestore.collection(collection).document(data["uid"]).setData(data);
  }
  /* void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  } */

  Future<UserModel> getUserById(String id)=> _firestore.collection(collection).document(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  void addToCart({String userId, CarritoModelDB cartItem}){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CarritoModelDB cartItem}){
    print("THE USER ID IS: $userId");
    print("cart items removed was: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}