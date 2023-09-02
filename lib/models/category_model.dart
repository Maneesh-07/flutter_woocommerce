class Category {
  late int categoryId;
  late String categoryName;
  late String categoryDesc;
  late int parent;
  Image? image; 

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDesc,
    required this.parent,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null; // Remove non-null assertion
  }
}

class Image {
 late String url;
  Image({this.url = ''});
  Image.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}
