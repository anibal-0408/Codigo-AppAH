import 'package:aprender_haciendo_app/core/services/providers/productoProvider.dart';
import 'package:aprender_haciendo_app/ui/views/productoDetail.dart';
import 'package:aprender_haciendo_app/ui/widgets/cards/productoCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class Tienda extends StatefulWidget {
  static const String routeName = '/tienda';

  @override
  _TiendaState createState() => _TiendaState();
}

final TextStyle searchBarStyle =
    TextStyle(fontSize: 18, fontFamily: "Poppins-Medium");
final TextStyle newProductStyle =
    TextStyle(fontSize: 24, fontFamily: "Poppins-Bold", color: Colors.white);
final TextStyle nameProductStyle =
    TextStyle(fontSize: 20, fontFamily: "Poppins-Medium", color: Colors.white);

class _TiendaState extends State<Tienda> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductoProvider>(context);
    final productList = products.products;
    ScreenUtil.instance =
        ScreenUtil(width: 1125, height: 2436, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(0),
                  left: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(50)),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("Tienda",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Bold",
                      fontSize: 26,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 25),
            //SearchBox(),
            //Categorylist(),
            /* Container(
              height: 30.0,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategorySelector(
                    categorias: [
                      "Preescolar",
                      "Primaria",
                      "Secundaria",
                      "Todos"
                    ],
                  ),
                ],
              ),
            ), */
            Container(
              height: ScreenUtil().setHeight(1080),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChangeNotifierProvider.value(
                      value: productList[index],
                      child: ProductCard(
                        itemIndex: index,
                        product: productList[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                product: productList[index],
                              ),
                            ),
                          );
                          print("${productList[index].nombre}");
                        },
                      ),
                    );
                  }),
            ),

            GestureDetector(
              onTap: () {
                /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(product: productList[2]),
                    ),
                  ); */
              },
              child: Container(
                height: ScreenUtil().setHeight(425),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(60),
                          vertical: ScreenUtil().setHeight(30)),
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(60),
                          left: ScreenUtil().setWidth(50)),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFFf29c1f), Color(0xFFf0c419)]),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Nuevo producto", style: newProductStyle),
                          Text("Spike™ Prime", style: nameProductStyle),
                        ],
                      ),
                    ),
                    Positioned(
                      top: ScreenUtil().setHeight(-75),
                      right: ScreenUtil().setWidth(-50),
                      child: Image.asset("images/breakdance_spike.png",
                          width: ScreenUtil().setWidth(580),
                          height: ScreenUtil().setHeight(550)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FlutterOpenWhatsapp.sendSingleMessage("+50684438017", "");
        },
        child: FaIcon(FontAwesomeIcons.whatsapp, size: 30),
        backgroundColor: Color(0xFF1bd741),
      ),
    );
  }
}

/* class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

Future _data;

class _ListPageState extends State<ListPage> {
  navigateToDetail(DocumentSnapshot product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          product: product,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        } else {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              //Product products = snapshot.data[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                ),
                //child: Container(child: ProductCard(product: products),
                //),
                child: ListTile(
                  title: Text(snapshot.data[index].data["nombre"]),
                  onTap: () => navigateToDetail(snapshot.data[index]),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot product;
  DetailPage({this.product});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title:widget.product.data["nombre"]
          ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.product.data["nombre"]),
            subtitle: Text(widget.product.data["image"]),
          ),
        ),
      ),
    );
  }
}
  */
