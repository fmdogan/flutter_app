import 'package:flutter/material.dart';
import 'package:sell_shoes/product_data.dart';
import './main.dart';
//import 'package:flutter_svg/flutter_svg.dart';

///import './Menu.dart';

bool searchOn = false;
TextEditingController searchCtrl = TextEditingController();

Widget myAppBar(context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Icon(Icons.menu, color: Colors.black, size: 30),
      //SvgPicture.asset("assets/images/burger_icon.svg"),
      onPressed: () {
        scaffoldKey.currentState.openDrawer();
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menu()),
        );*/
      },
    ),
    actions: <Widget>[
      searchOn
          ? Container(
              width: MediaQuery.of(context).size.width - 215,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                ),
                autofocus: true,
                showCursor: false,
                controller: searchCtrl,
                onSubmitted: (str) {
                  // ignore: invalid_use_of_protected_member
                  homeKey.currentState.setState(() {
                    search(str);
                    if (homeList.length != 0) searchOn = !searchOn;
                  });
                  print(searchCtrl.text);
                },
              ),
            )
          : SizedBox(
              width: 0,
            ),
      bodyIndex != 0
          ? SizedBox(width: 0)
          : IconButton(
              icon: searchOn
                  ? Icon(Icons.close, color: Colors.black, size: 30)
                  //SvgPicture.asset("assets/images/search_icon.svg")
                  : Icon(Icons.search, color: Colors.black, size: 30),
              onPressed: () {
                // ignore: invalid_use_of_protected_member
                homeKey.currentState.setState(() {
                  searchOn = !searchOn;
                });
              },
            ),
      bodyIndex != 0
          ? SizedBox(width: 0)
          : IconButton(
              onPressed: () {},
              icon: Icon(Icons.rule, color: Colors.black, size: 30),
              //SvgPicture.asset("assets/images/filter_icon.svg", height: 30),
            ),
      IconButton(
        onPressed: () {
          if (itemsInBag.length != 0 || bodyIndex != 0 /*!isHome*/) {
            // ignore: invalid_use_of_protected_member
            homeKey.currentState.setState(() {
              ///isHome = !isHome;
              searchOn = false;
              bodyIndex = bodyIndex == 0 ? 1 : 0;
            });
          }
        },
        icon: Stack(
          children: [
            ///!isHome
            bodyIndex != 0
                ? Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 30,
                  )
                : Icon(
                    Icons.shopping_cart,
                    color: itemsInBag.length == 0 ? Colors.grey : Colors.black,
                    size: 30,
                  ),
            itemsInBag.length == 0 //countInBag() == 0
                ? SizedBox()
                : bodyIndex != 0

                    ///!isHome
                    ? SizedBox()
                    : Positioned(
                        top: 0,
                        right: 5,
                        child: Container(
                          height: 13,
                          width: 13,
                          //padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Expanded(
                            child: Center(
                              child: Text(
                                itemsInBag.length.toString(), //"$itemCount",
                                style: TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
      Padding(padding: EdgeInsets.all(5.0)),
    ],
  );
}
