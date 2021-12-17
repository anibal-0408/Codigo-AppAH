import 'package:aprender_haciendo_app/core/models/carritoModelDB.dart';
import 'package:aprender_haciendo_app/core/models/orderModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderServices{
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

   void createOrder({String userId ,String id,String description,String status ,List<CarritoModelDB> cart, int totalPrice}) {
    List<Map> convertedCart = [];
    for(CarritoModelDB item in cart){
      convertedCart.add(item.toMap());
    }
    _firestore.collection(collection).document(id).updateData({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

/*   Future<List<OrderModelDB>> getUserOrders({String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModelDB> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModelDB.fromSnapshot(order));
        }
        return orders;
      }); */

  /* Future<List<OrderModelDB>> getOrders() async =>
      _firestore.collection(collection).getDocuments().then(
        (result) {
          List<OrderModelDB> compras = [];
          for (DocumentSnapshot compra in result.documents) {
            compras.add(OrderModelDB.fromSnapshot(compra));
          }
          return compras;
        },
      );
 */
  Future<List<OrderModelDB>> getOrdersByUser(String uid) async =>
      await _firestore
          .collection(collection)
          //.orderBy("fecha")
          .where ("uid", isEqualTo: uid)
          .getDocuments()
          .then((result) {
        List<OrderModelDB> compras = [];
        for (DocumentSnapshot compra in result.documents) {
          compras.add(OrderModelDB.fromSnapshot(compra));
        }
        return compras;
      },);

 
}