import 'package:flutter/material.dart';

import 'main.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink.shade100,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.pink.shade100,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 20,
            bottom: MediaQuery.of(context).size.height / 4,
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => MyHomePage()),
                    (route) => false), // Navigator.pop(context); de olur
                child: Text("Home",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                child: Text("New in",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                child: Text("Sale",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                child: Text("Profile",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                child: Text("Log out",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
