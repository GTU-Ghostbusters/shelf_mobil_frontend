class Category {
  final String title;
  final String imagePath;
  final String description;

  Category(this.title, this.imagePath, this.description);

  static List<Category> getCategoryList() {
    return [
      Category("WORLD CLASSICS", " ", "description"),
      Category("NOVEL", " ", "description"),
      Category("LITERATURE", " ", "description"),
      Category("STORY", " ", "description"),
      Category("SELF-HELP", " ", "description"),
      Category("KIDS", " ", "description"),
      Category("POLITICS", " ", "description"),
      Category("POEM", " ", "description"),
      Category("BIOGRAPHIES", " ", "description"),
      Category("HISTORY", " ", "description"),
      Category("ECONOMY", " ", "description"),
      Category("ART", " ", "description"),
      Category("EDUCATION", " ", "description"),
      Category("SCIENCE-FICTION", " ", "description"),
      Category("PHILOSOPHY", " ", "description"),
      Category("ENTERTAINMENT", " ", "description"),
    ];
  }
}
