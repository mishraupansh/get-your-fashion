class CategoryModel {
  String? id;
  String? name;
  String? slug;
  String? image;
  String? banner;
  String? clicks;
  String? date;
  String? status;

  CategoryModel(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.banner,
        this.clicks,
        this.date,
        this.status});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      banner: json['banner'],
      clicks: json['clicks'],
      date: json['date'],
      status: json['status'],
    );
  }
}
