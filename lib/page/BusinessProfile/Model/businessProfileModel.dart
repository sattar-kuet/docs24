import 'package:docs24/page/BusinessProfile/Model/categoryModel.dart';

class BusinessProfileModel {
  int? id;
  String? name;
  String? url;
  String? abn;
  String? country;
  String? city;
  String? address;
  List<CategoryModel>? category;
  List<int>? categoryIds;
  String? logo;

  BusinessProfileModel(
      {this.id,
      this.name,
      this.url,
      this.abn,
      this.country,
      this.city,
      this.address,
      this.category,
      this.categoryIds,
      this.logo});

  // JSON deserialization (fromJson) constructor
  BusinessProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    abn = json['abn'];
    country = json['country'];
    city = json['city'];
    address = json['business_address'];
    if (json['category_ids'] != null) {
      categoryIds = List<int>.from(json['category_ids']);
    }
    logo = json['logo'];
    // Deserialize the list of category objects
    if (json['category'] != null) {
      category = <CategoryModel>[];
      json['category'].forEach((categoryJson) {
        category!.add(CategoryModel.fromJson(categoryJson));
      });
    }
  }

  get businessName => null;

  // JSON serialization (toJson) method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['abn'] = this.abn;
    data['country'] = this.country;
    data['city'] = this.city;
    data['business_address'] = this.address;
    data['category_ids'] = this.categoryIds;
    data['logo'] = this.logo;

    // Serialize the list of category objects
    if (this.category != null) {
      data['category'] =
          this.category!.map((category) => category.toJson()).toList();
    }
    return data;
  }
}
