class Order {
  final String title;
  final String description;
  final String orderNo;
  final String imageUrl;
  bool accepted;

  Order({
    required this.title,
    required this.description,
    required this.orderNo,
    required this.imageUrl,
    this.accepted = false,
  });
}

class OrderModel {
  static List<Order> items = [
    Order(
      title: 'McDonalds',
      description: 'Fast Food',
      orderNo: '25',
      imageUrl: 'images/mcdd.jpg',
    ),
    Order(
      title: 'KFC',
      description: 'Fast Food',
      orderNo: '30',
        imageUrl: 'images/kfc12.png',
    ),
    Order(
      title: 'Hardees',
      description: 'Fast Food',
      orderNo: '20',
      imageUrl: 'images/hardess logo.png',
    ),
    Order(
      title: 'Gloria Jeans',
      description: 'Cafe',
      orderNo: '16',
      imageUrl: 'images/Gloria jeans.png',
    ),
  ];
}