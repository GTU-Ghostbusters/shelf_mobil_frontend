class Category {
  String title;
  String imagePath;
  int numberOfBooks;

  Category(this.title, this.imagePath, this.numberOfBooks);

  //FAKE DATABASE
  static final List<Category> _categoryList = <Category>[
    Category("POLITICS", " ", 32),
    Category("EDUCATION", " ", 29),
    Category("LITERATURE", " ", 23),
    Category("STORY", " ", 21),
    Category("SCIENCE-FICTION", " ", 15),
    Category("NOVEL", " ", 14),
    Category("HISTORY", " ", 8),
    Category("KIDS", " ", 7),
    Category("BIOGRAPHIES", " ", 6),
    Category("WORLD CLASSICS", " ", 6),
    Category("ART", " ", 5),
    Category("PHILOSOPHY", " ", 5),
    Category("ECONOMY", " ", 4),
    Category("SELF-HELP", " ", 3),
    Category("ENTERTAINMENT", " ", 1),
    Category("POEM", " ", 0),
  ];

  static List<Category> getCategoryListNumberOfBooksSorted() {
    int num = 0;
    List<Category> retList = [];
    for (var element in _categoryList) {
      num += element.numberOfBooks;
    }
    retList.add(Category("ALL BOOKS", " ", num));
    retList.addAll(_categoryList);
    retList.sort((a, b) => b.numberOfBooks.compareTo(a.numberOfBooks));
    return retList;
  }

  static List<Category> getCategoryListAlphabeticSorted() {
    int num = 0;
    List<Category> retList = [];
    for (var element in _categoryList) {
      num += element.numberOfBooks;
    }
    retList.add(Category("ALL BOOKS", " ", num));
    retList.addAll(_categoryList);
    retList
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return retList;
  }
}
