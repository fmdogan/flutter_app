import 'package:flutter/material.dart';
import 'package:sell_shoes/product_data.dart';
import 'package:sell_shoes/product_page.dart';
import './main.dart';

class MyFavorites extends StatefulWidget {
  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "My Favorites",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: myFavorites.length,
                itemBuilder: (BuildContext context, index) {
                  return favCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget favCard(context, index) {
  Item product =
      items[items.indexWhere((element) => element.id == myFavorites[index])];

  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 800),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return ProductPage(product: product);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
      /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(product: product)),
        );*/
    }, // will navigate to product page
    child: Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15),
            Hero(
              tag: product.id,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/${product.img}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 25),
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$ " + product.price,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 35,
          right: 0,
          child: IconButton(
            icon: Icon(Icons.close, size: 30),
            splashColor: Colors.white,
            onPressed: () {
              // ignore: invalid_use_of_protected_member
              homeKey.currentState.setState(() {
                myFavorites.remove(product.id);
                if (myFavorites.length == 0) bodyIndex = 0;
              });
            },
          ),
        ),
      ],
    ),
  );
}
