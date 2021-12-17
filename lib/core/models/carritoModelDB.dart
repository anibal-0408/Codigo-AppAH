class CarritoModelDB {
  static const ID = "id";
  static const CODIGO = "codigo";
  static const NOMBRE = "nombre";
  static const IMAGE = "image";
  static const PRECIO = "precio";
  //static const QUANTITY = "quantity";

  String id;
  String codigo;
  String nombre;
  String image;
  //int quantity;
  int precio;

   CarritoModelDB({
    this.codigo,
    this.nombre,
    this.image,
    //this.quantity,
    this.precio,
  }); 

/*   String get id => _id;
  String get codigo => _codigo;
  String get nombre => _nombre;
  String get image => _image;
  int get precio => _precio;
  int get quantity => _quantity; */

  CarritoModelDB.fromMap(Map data) {
    id = data[ID];
    nombre = data[NOMBRE];
    image = data[IMAGE];
    codigo = data[CODIGO];
    //quantity = data[QUANTITY];
    precio = data[PRECIO];
  }

  Map toMap() => {
        ID: id,
        IMAGE: image,
        NOMBRE: nombre,
        CODIGO: codigo,
        PRECIO: precio,
        //QUANTITY: quantity
      };
}
