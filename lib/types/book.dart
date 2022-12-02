class Book {
  String? bookName;
  String? authorName;
  int? numberOfPage;
  String? category;
  String? additionalInfo;

  Book(
      {this.bookName,
      this.authorName,
      this.numberOfPage,
      this.category,
      this.additionalInfo});

  static final List<String> _images = [
    "https://i.dr.com.tr/cache/500x400-0/originals/0000000222779-1.jpg",
    "https://cdn.dsmcdn.com/ty180/product/media/images/20210923/4/135543021/123892296/1/1_org_zoom.jpg",
    "https://static.nadirkitap.com/fotograf/5977/19/Kitap_2020082015071659771.jpg",
  ];

  static List<String> getImages() {
    List<String> imagesList = [];
    for (var element in _images) {
      imagesList.add(element);
    }
    return imagesList;
  }

  void setter(String name, String author, int numPages, String category_,
      String additional) {
    bookName = name;
    authorName = author;
    numberOfPage = numPages;
    category = category_;
    additionalInfo = additional;
  }
}
