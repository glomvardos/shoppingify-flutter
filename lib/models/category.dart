class Category {
  final String category;

  Category({
    required this.category,
  });

  Category.fromJson(Map<String, dynamic> json) : category = json['category'];
}
