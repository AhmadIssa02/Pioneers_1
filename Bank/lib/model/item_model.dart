class ItemModel {
  final String image;
  final String name;
  final double price;
  int quantity;

  ItemModel(
      {required this.image,
      required this.name,
      required this.price,
      this.quantity = 0});
}
