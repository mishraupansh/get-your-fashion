
class SubCategoryModel {
  final String? id;
  final String? name;
  final String? image;
  final List<SubCategoryItem> subCategoriesItem;

  SubCategoryModel({
    this.id,
    this.name,
    this.image,
    required this.subCategoriesItem,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> subCategoriesItem = json['item'] as List;
    List<SubCategoryItem> subCategoriesItems =
    subCategoriesItem.map((e) => SubCategoryItem.fromJson(e)).toList();

    return SubCategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      subCategoriesItem: subCategoriesItems,
    );
  }
}

class SubCategoryItem {
  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final String? starting_price;
  SubCategoryItem({
    this.id,
    this.name,
    this.description,
    this.image,
    this.starting_price
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      starting_price: json['starting_price'],
    );
  }
}
