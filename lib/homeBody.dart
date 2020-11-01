import 'package:flutter/material.dart';
import 'package:sell_shoes/product_data.dart';
import 'package:sell_shoes/product_page.dart';
import './main.dart';
import './myAppBar.dart';

///import 'package:sell_shoes/dropDown.dart';

int dropDownValue = -1;
List dropDownTexts = ["Price: lowest first", "Price: highest first"];

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Text(
                  "Shoes",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: DropdownButton(
                  hint: Text("Sort by"),
                  dropdownColor: Colors.grey.shade200,
                  underline: SizedBox(),
                  value: dropDownValue < 0 ? null : dropDownValue,
                  onChanged: (value) {
                    setState(() {
                      dropDownValue = value;
                      sortBy(dropDownValue);
                    });
                  },
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      child: Text(dropDownTexts[0]),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text(dropDownTexts[1]),
                      value: 1,
                    ),
                  ],
                ),

                ///CustomDropdown(text: "Sort by..."),
              ),
            ],
          ),
          SizedBox(height: 15),
          homeList.length == 0
              ? Center(
                child: Text(
                  "\"${searchCtrl.text}\"" + " can't be found.",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              )
              : Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: homeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: new ProductCard(
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  Item product;
  int index;
  ProductCard({Key key, @required this.index}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState(index: index);
}

class _ProductCardState extends State<ProductCard> {
  Item product;
  int index;
  // ignore: unused_element
  _ProductCardState({Key key, @required this.index});

  @override
  Widget build(BuildContext context) {
    product = homeList[index];
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
      child: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2)
                  ]),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Hero(
                      tag: product.id,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 4 / 5,
                        height: 180,
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/" + product.img,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "\$ ${product.price}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            Positioned(
              right: 10,
              child: IconButton(
                icon: !myFavorites.contains(product.id)
                    ? Icon(Icons.favorite_border,
                        size:
                            30) //SvgPicture.asset("assets/images/heart_icon.svg")
                    : Icon(Icons.favorite, size: 30),
                onPressed: () {
                  homeKey.currentState.setState(() {
                    !myFavorites.contains(product.id)
                        ? myFavorites.add(product.id)
                        : myFavorites.remove(product.id);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
