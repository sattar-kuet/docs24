import 'package:mailbox/page/BusinessProfile/Model/categoryModel.dart';

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['abn'] = abn;
    data['country'] = country;
    data['city'] = city;
    data['business_address'] = address;
    data['category_ids'] = categoryIds;
    data['logo'] = logo;

    // Serialize the list of category objects
    if (category != null) {
      data['category'] =
          category!.map((category) => category.toJson()).toList();
    }
    return data;
  }
}
