class Category implements Comparable<Category> {
  String title;
  String imagePath;
  String description;
  int numberOfBooks;

  Category(this.title, this.imagePath, this.description, this.numberOfBooks);

  @override
  int compareTo(Category other) {
    if (numberOfBooks > other.numberOfBooks) {
      return 1;
    } else {
      return 0;
    }
  }

  //FAKE DATABASE
  static final List<Category> _categoryList = <Category>[
    Category("POLITICS", " ", "description", 32),
    Category("EDUCATION", " ", "description", 29),
    Category("LITERATURE", " ", "description", 23),
    Category("STORY", " ", "description", 21),
    Category("SCIENCE-FICTION", " ", "description", 15),
    Category("NOVEL", " ", "description", 14),
    Category("HISTORY", " ", "description", 8),
    Category("KIDS", " ", "description", 7),
    Category("BIOGRAPHIES", " ", "description", 6),
    Category("WORLD CLASSICS", " ", "description", 6),
    Category("ART", " ", "description", 5),
    Category("PHILOSOPHY", " ", "description", 5),
    Category("ECONOMY", " ", "description", 4),
    Category("SELF-HELP", " ", "description", 3),
    Category("ENTERTAINMENT", " ", "description", 1),
    Category("POEM", " ", "description", 0),
  ];

  static List<Category> getCategoryList() {
    int num = 0;
    List<Category> retList = [];
    for (var element in _categoryList) {
      num += element.numberOfBooks;
    }
    retList.add(Category("ALL BOOKS", " ", "description", num));
    retList.addAll(_categoryList);
    return retList;
  }

  static List<String> getCategoryNameList(){
    List<String> categoryNameList = [];
    for (var element in getCategoryList()) {
      categoryNameList.add(element.title);
    }
    categoryNameList.sort(((a, b) => a.toLowerCase().compareTo(b.toLowerCase())));
    return categoryNameList;
  }
}
