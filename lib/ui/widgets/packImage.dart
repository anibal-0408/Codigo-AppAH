import 'package:flutter/material.dart';

class PackPoster extends StatelessWidget {
  PackPoster({
    Key key,
    @required this.size,
    this.image,
    this.imagen2,
  }) : super(key: key);

  final Size size;
  final String image;
  final String imagen2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      // the height of this container is 80% of our width
      height: size.width * 0.6,

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: size.width * 0.7,
            width: size.width * 0.7,
            child: Column(children: <Widget>[ ])
          ),
          Image.network(image,height: size.width * 0.7,width: size.width * 0.7,fit: BoxFit.contain),
        ],
      ),
    );
  }
}
