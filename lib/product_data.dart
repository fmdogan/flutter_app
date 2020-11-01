List products = [
  {
    "id": 1,
    "img": "adapt-bb-2-basketball-shoe-lgBfBb_1.jpg",
    "name": "Nike Adapt BB 2.0",
    "price": "299.95",
    "mul_img": [
      "assets/images/adapt-bb-2-basketball-shoe-lgBfBb_1.jpg",
      "assets/images/adapt-bb-2-basketball-shoe-lgBfBb_2.jpg",
      "assets/images/adapt-bb-2-basketball-shoe-lgBfBb_3.jpg",
      "assets/images/adapt-bb-2-basketball-shoe-lgBfBb_4.jpg"
    ],
    "sizes": [
      "40",
      "41",
      "41,5",
      "42",
      "43",
      "44",
    ],
  },
  {
    "id": 2,
    "img": "air-vapormax-360-shoe-KBGFwq_1.jpg",
    "name": "Nike Air Force 1",
    "price": "160.00",
    "mul_img": [
      "assets/images/air-vapormax-360-shoe-KBGFwq_1.jpg",
      "assets/images/air-vapormax-360-shoe-KBGFwq_2.jpg",
      "assets/images/air-vapormax-360-shoe-KBGFwq_3.jpg",
      "assets/images/air-vapormax-360-shoe-KBGFwq_4.jpg",
    ],
    "sizes": [
      "40",
      "41",
      "41,5",
      "42",
      "43",
      "44",
    ],
  },
  {
    "id": 3,
    "img": "joyride-cc-shoe-Qbt71m_1.jpg",
    "name": "Nike Joyride CC",
    "price": "140.00",
    "mul_img": [
      "assets/images/joyride-cc-shoe-Qbt71m_1.jpg",
      "assets/images/joyride-cc-shoe-Qbt71m_2.jpg",
      "assets/images/joyride-cc-shoe-Qbt71m_3.jpg",
      "assets/images/joyride-cc-shoe-Qbt71m_4.jpg"
    ],
    "sizes": [
      "40",
      "41",
      "41,5",
      "42",
      "43",
      "44",
    ],
  },
  {
    "id": 4,
    "img": "jordan-max-200-shoe-C2S1xN_1.jpg",
    "name": "Jordan Max 200",
    "price": "125.00",
    "mul_img": [
      "assets/images/jordan-max-200-shoe-C2S1xN_1.jpg",
      "assets/images/jordan-max-200-shoe-C2S1xN_2.jpg",
      "assets/images/jordan-max-200-shoe-C2S1xN_3.jpg",
      "assets/images/jordan-max-200-shoe-C2S1xN_4.jpg"
    ],
    "sizes": [
      "40",
      "41",
      "41,5",
      "42",
      "43",
      "44",
    ],
  },
  {
    "id": 5,
    "img": "jordan-aerospace-720-shoe-MtlBtG_1.jpg",
    "name": "Jordan Aerospace 720",
    "price": "200.00",
    "mul_img": [
      "assets/images/jordan-aerospace-720-shoe-MtlBtG_1.jpg",
      "assets/images/jordan-aerospace-720-shoe-MtlBtG_2.jpg",
      "assets/images/jordan-aerospace-720-shoe-MtlBtG_3.jpg",
      "assets/images/jordan-aerospace-720-shoe-MtlBtG_4.jpg",
    ],
    "sizes": [
      "40",
      "41",
      "41,5",
      "42",
      "43",
      "44",
    ],
  }
];

List<Item> items = [];
List myFavorites = [];
List itemsInBag = [];

class Item {
  int id;
  String img;
  String name;
  String price;
  // ignore: non_constant_identifier_names
  List mul_img;
  List sizes;

  Item(
      // ignore: non_constant_identifier_names
      int id, String img, String name, String price, List mul_img, List sizes) {
    this.id = id;
    this.img = img;
    this.name = name;
    this.price = price;
    this.mul_img = mul_img;
    this.sizes = sizes;
  }
}

void createItemsList() {
  Item _item;
  print("creating item list...");
  products.forEach((element) {
    _item = new Item(
      element["id"],
      element["img"],
      element["name"],
      element["price"],
      element["mul_img"],
      element["sizes"],
    );
    items.add(_item);
  });
  print("item list is created!");
}

class ItemInBag {
  String itemID;
  String itemSize;

  ItemInBag(String itemID, String itemSize) {
    this.itemID = itemID;
    this.itemSize = itemSize;
  }
}

num total() {
  num totalPayment = 0;
  // ignore: non_constant_identifier_names
  List id_size = [];

  itemsInBag.forEach((element) {
    id_size = element.split('-');
    totalPayment += num.tryParse(items[num.tryParse(id_size[0]) - 1].price);
  });
  return totalPayment;
}

List<Item> homeList = [];

void search(String str) {
  homeList = [];
  items.forEach((element) {
    if (element.name.toUpperCase().contains(str.toUpperCase())) {
      homeList.add(element);
    }
  });
}

// ignore: non_constant_identifier_names
void sortBy(int lowest_highest) {
  lowest_highest == 0
      ? homeList.sort(
          (a, b) => num.tryParse(a.price).compareTo(num.tryParse(b.price)))
      : homeList.sort(
          (a, b) => num.tryParse(b.price).compareTo(num.tryParse(a.price)));
}
