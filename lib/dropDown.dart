import 'package:flutter/material.dart';

List<bool> isSelected = [false, false, false, false, false];
bool isDropdownOpened = false;
OverlayEntry floatingDropdown;
String dDtext = "Sort by...".toUpperCase();
List<String> sortByItems = [
  "En düşük fiyat",
  "En yüksek fiyat",
  "En yüksek puan",
  "En çok satan",
  "En çok beğenilen",
];

// ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  String text;

  CustomDropdown({Key key, @required this.text}) : super(key: key);

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        top: yPosition + height,
        height: 5 * height + 25,
        width: width,
        child: Dropdown(
          sortByItems: sortByItems,
          itemHeight: 35,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
          } else {
            findDropdownData();
            floatingDropdown = createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }

          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 10,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.red.shade600,
        ),
        child: Row(
          children: [
            Text(
              dDtext,
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 25,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class Dropdown extends StatefulWidget {
  final double itemHeight;
  final List<String> sortByItems;

  const Dropdown({Key key, this.itemHeight, this.sortByItems})
      : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment(0.82, 0),
          child: ClipPath(
            clipper: ArrowClipper(),
            child: Container(
              height: 20,
              width: 30, //MediaQuery.of(context).size.width/2-10,
              decoration: BoxDecoration(
                color: Colors.red.shade600,
              ),
            ),
          ),
        ),
        Material(
          elevation: 20,
          shape: ArrowShape(),
          child: Container(
            height: 5 * widget.itemHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                DropdownItem.first(
                  index: 0,
                  text: widget.sortByItems[0],
                  isSelected: isSelected[0],
                ),
                DropdownItem(
                  index: 1,
                  text: widget.sortByItems[1],
                  isSelected: isSelected[1],
                ),
                DropdownItem(
                  index: 2,
                  text: widget.sortByItems[2],
                  isSelected: isSelected[2],
                ),
                DropdownItem(
                  index: 3,
                  text: widget.sortByItems[3],
                  isSelected: isSelected[3],
                ),
                DropdownItem.last(
                  index: 4,
                  text: widget.sortByItems[4],
                  isSelected: isSelected[4],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DropdownItem extends StatefulWidget {
  final int index;
  final String text;
  bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;

  DropdownItem({
    Key key,
    @required this.index,
    this.text,
    this.isSelected,
    this.isFirstItem = false,
    this.isLastItem = false,
  }) : super(key: key);

  factory DropdownItem.first({int index, String text, bool isSelected}) {
    return DropdownItem(
      index: index,
      text: text,
      isSelected: isSelected,
      isFirstItem: true,
    );
  }
  factory DropdownItem.last({int index, String text, bool isSelected}) {
    return DropdownItem(
      index: index,
      text: text,
      isSelected: isSelected,
      isLastItem: true,
    );
  }

  @override
  _DropdownItemState createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            if (i == widget.index)
              isSelected[i] = true;
            else
              isSelected[i] = false;
          }
          //isSelected[widget.index] = true;
          dDtext = !isSelected.contains(true)
              ? "Sort by...".toUpperCase()
              : sortByItems[isSelected.indexOf(true)];

          isDropdownOpened = false;
          floatingDropdown.remove();
        });
      },
      child: Container(
        //width: MediaQuery.of(context).size.width / 2 - 10,
        height: 35,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: widget.isFirstItem ? Radius.circular(8) : Radius.zero,
            bottom: widget.isLastItem ? Radius.circular(8) : Radius.zero,
          ),
          color: widget.isSelected ? Colors.red.shade900 : Colors.red.shade600,
        ),
        child: Row(
          children: [
            Text(
              widget.text.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    return path;
  }
}
