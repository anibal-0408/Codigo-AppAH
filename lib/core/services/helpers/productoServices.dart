import 'package:aprender_haciendo_app/core/models/productoModelDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductoServices {
  String collection = "products";
  Firestore _firestore = Firestore.instance;

  Future<List<ProductoModelDB>> getProducts() async =>
    _firestore.collection(collection).getDocuments().then(
      (result) {
        List<ProductoModelDB> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductoModelDB.fromSnapshot(product));
        }
        return products;
      },
    );

  Future<List<ProductoModelDB>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<ProductoModelDB> products = [];
      for (DocumentSnapshot product in result.documents) {
        products.add(ProductoModelDB.fromSnapshot(product));
      }
      return products;
    });
  }

  /* void likeOrDislikeProduct({String id, List<String> userLikes}){
    _firestore.collection(collection).document(id).updateData({
      "userLikes": userLikes
    },);
  }
 
  Future<List<ProductModelDB>> getProductsByCodigo({String codigo}) async =>
      _firestore
          .collection(collection)
          .where("codigo", isEqualTo: codigo)
          .getDocuments()
          .then((result) {
        List<ProductModelDB> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModelDB.fromSnapshot(product));
        },
        return products;
      },);

  Future<List<ProductModelDB>> getProductsOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<ProductModelDB> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModelDB.fromSnapshot(product));
        },
        return products;
      },);

  Future<List<ProductModelDB>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
          List<ProductModelDB> products = [];
          for (DocumentSnapshot product in result.documents) {
            products.add(ProductModelDB.fromSnapshot(product));
          },
          return products;
        },);
        
  }
  */
}
