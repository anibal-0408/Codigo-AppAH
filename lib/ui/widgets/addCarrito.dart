import 'package:flutter/material.dart';

final TextStyle botonStyle = TextStyle(fontSize: 20,fontFamily: "Poppins-Bold",color: Colors.white,fontWeight: FontWeight.w700);

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key key,
    this.press,
  }) : super(key: key);

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0 / 2),
      decoration: BoxDecoration(color: Color(0xFFFCBF1E),borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        child: Container(
          height: 40,
          child: Center(
            child: Text("Agregar al carrito",style: botonStyle),
          ),
        ),
        onTap: press,
      ),
    );
  }
}
