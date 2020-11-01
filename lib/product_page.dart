import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './product_data.dart';
import './main.dart';
//import 'package:flutter_svg/flutter_svg.dart';

int chosenSize = 0;

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  Item product;
  ProductPage({Key key, @required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(product: product);
}

class _ProductPageState extends State<ProductPage> {
  Item product;
  String itemForBag = "";
  int pageViewDot = 0;

  // ignore: unused_element
  _ProductPageState({Key key, @required this.product});

  var pvCtrl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 300,
                          child: PageView.builder(
                            controller: pvCtrl,
                            onPageChanged: (index) {
                              setState(() {
                                pageViewDot = index;
                              });
                            },
                            itemCount: product.mul_img.length, // Can be null
                            itemBuilder: (context, index) {
                              return Hero(
                                tag: product.id,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(product.mul_img[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: MediaQuery.of(context).size.width / 2 - 45,
                          child: Container(
                            height: 11,
                            width: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: product.mul_img.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: InkWell(
                                      onTap: () {
                                        //pvCtrl.jumpToPage(index);
                                        pvCtrl.animateToPage(
                                          index,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.fastOutSlowIn,
                                        );
                                      },
                                      child: Container(
                                        height: 5,
                                        width: index == pageViewDot ? 20 : 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: index == pageViewDot
                                              ? Colors.black
                                              : Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/images/nike_logo.png",
                      //height: 25,
                      width: 65,
                    ),
                    SizedBox(height: 15),
                    Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "\$${product.price}",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Size",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Size Guide", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: MediaQuery.of(context).size.width / 7,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  chosenSize = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: index == chosenSize
                                        ? Colors.black.withOpacity(0.9)
                                        : Colors.grey.shade400,
                                  ),
                                  height: MediaQuery.of(context).size.width / 7,
                                  width: MediaQuery.of(context).size.width / 7,
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          product.sizes[index],
                                          style: TextStyle(
                                              color: index != chosenSize
                                                  ? Colors.black
                                                      .withOpacity(0.9)
                                                  : Colors.white,
                                              fontWeight: index != chosenSize
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                        ),
                                      ),
                                      !itemsInBag.contains(
                                              "${product.id}-${product.sizes[index]}")
                                          ? SizedBox(
                                              height: 0,
                                            )
                                          : Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.red,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    16,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: !myFavorites.contains(product.id)
                              ? Icon(Icons.favorite_border, size: 30)
                              /*SvgPicture.asset(
                                  "assets/images/heart_icon.svg",
                                  fit: BoxFit.cover,
                                  height: 30,
                                )*/
                              : Icon(Icons.favorite, size: 30),
                          splashColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              !myFavorites.contains(product.id)
                                  ? myFavorites.add(product.id)
                                  : myFavorites.remove(product.id);
                            });
                          },
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (chosenSize != null) {
                                setState(() {
                                  itemForBag =
                                      "${product.id}-${product.sizes[chosenSize]}";
                                  if (!itemsInBag.contains(itemForBag)) {
                                    itemsInBag.add(itemForBag);
                                    print("item added: $itemForBag");
                                  } else {
                                    itemsInBag.remove(itemForBag);
                                    print("item removed: $itemForBag");
                                  }
                                });
                              }
                            },
                            child: Card(
                              color: Colors.black.withOpacity(0.9),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    !itemsInBag.contains(
                                            "${product.id}-${product.sizes[chosenSize]}")
                                        ? "Add to Chart"
                                        : "Remove",
                                    style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black.withOpacity(0.9),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  homeKey.currentState.setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
