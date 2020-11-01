import 'package:flutter/material.dart';
import 'package:sell_shoes/myFavorites.dart';
import 'package:sell_shoes/product_data.dart';
import './myAppBar.dart';
import './homeBody.dart';
import './myBag.dart';

bool isHome = true;
int bodyIndex = 0;
final homeKey = GlobalKey();
var scaffoldKey = new GlobalKey<ScaffoldState>();
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    try {
      createItemsList();
      homeList = items;
    } catch (e) {
      print("itemList can't be created");
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: homeKey);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: myAppBar(context),
      body: bodyIndex == 0
          ? HomeBody()
          : bodyIndex == 1 ? MyBag() : MyFavorites(),
      drawer: myDrawer(context),
    );
  }
}

Widget myDrawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/myPhoto.jpeg"),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle),
              ),
              SizedBox(height: 10),
              Text(
                "Fatih Mehmet",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            size: 30,
          ),
          title: Text(
            "Home",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            Navigator.of(context).pop();
            // ignore: invalid_use_of_protected_member
            homeKey.currentState.setState(() {
              ///isHome = true;
              bodyIndex = 0;
            });

            ///Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          title: Text(
            itemsInBag.length == 0
                ? "My Bag"
                : "My Bag (" + itemsInBag.length.toString() + ")",
            style: TextStyle(fontSize: 20, color: itemsInBag.length == 0 ? Colors.grey.shade600 : Colors.black),
          ),
          onTap: () {
            Navigator.of(context).pop();
            if (itemsInBag.length != 0) {
              // ignore: invalid_use_of_protected_member
              homeKey.currentState.setState(() {
                ///isHome = false;
                bodyIndex = 1;
              });
            }

            ///Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.favorite,
            size: 30,
          ),
          title: Text(
            myFavorites.length == 0
                ? "My Favorites"
                : "My Favorites (" + myFavorites.length.toString() + ")",
            style: TextStyle(fontSize: 20, color: myFavorites.length == 0 ? Colors.grey.shade600 : Colors.black),
          ),
          onTap: () {
            Navigator.of(context).pop();
            if (myFavorites.length != 0) {
              // ignore: invalid_use_of_protected_member
              homeKey.currentState.setState(() {
                bodyIndex = 2;
              });
            }
          },
        ),
      ],
    ),
  );
}
