class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  int quantity;
  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity=1,
  });
}
