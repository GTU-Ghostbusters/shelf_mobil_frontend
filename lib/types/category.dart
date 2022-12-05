class Category {
  String title;
  String imagePath;
  int numberOfBooks;

  Category(this.title, this.imagePath, this.numberOfBooks);

  //FAKE DATABASE
  static final List<Category> _categoryList = <Category>[
    //Category("POLITICS", " ", 0),
    Category("EDUCATION", " ", 3),
    Category("LITERATURE", " ", 1),
    //Category("STORY", " ", 0),
    Category("SCIENCE-FICTION", " ", 2),
    Category("NOVEL", " ", 0),
    Category("HISTORY", " ", 1),
    Category("KIDS", " ", 0),
    Category("BIOGRAPHY", " ", 0),
    Category("WORLD CLASSICS", " ", 5),
    //Category("ART", " ", 0),
    Category("PHILOSOPHY", " ", 5),
    /* Category("ECONOMY", " ", 0),
    Category("SELF-HELP", " ", 0),
    Category("ENTERTAINMENT", " ", 0),
    Category("POEM", " ", 0), */
  ];

  static List<Category> getCategoryListNumberOfBooksSorted() {
    int num = 0;
    List<Category> retList = [];
    for (var element in _categoryList) {
      num += element.numberOfBooks;
    }
    retList.add(Category("ALL", " ", num));
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
    retList.add(Category("ALL", " ", num));
    retList.addAll(_categoryList);
    retList
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return retList;
  }
}
