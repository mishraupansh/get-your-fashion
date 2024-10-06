class BannerModel {
  dynamic id;
  dynamic banner;
  dynamic status;


  BannerModel(
      {this.id, this.banner,this.status});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id:json['id'],
      banner:json['banner'],
      status:json['status'],
    );
  }
}