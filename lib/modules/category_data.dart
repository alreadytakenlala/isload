class CategoryItem {
  String name;
  String banner;
  int backgroundColor;
  CategoryItem({
    this.name,
    this.banner,
    this.backgroundColor
  });
}

class CategoryData {
  String title;
  List<CategoryItem> list = [];
  CategoryData({
    this.title,
    this.list
  });
}