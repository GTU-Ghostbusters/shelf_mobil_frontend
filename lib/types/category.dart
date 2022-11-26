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
}
