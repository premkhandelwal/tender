class Item {
  final int id;
  final String name;
  final int qty;
  final String category;
  final String image;

  Item(this.id, this.name, this.qty, this.category, this.image);
}

class CatalogModel {
  static final items = [
    Item(1, "Furniture", 1, "Furniture", "assets/icons/product_img_rect.png")
  ];
}
