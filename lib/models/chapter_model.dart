class Chapter {
  final int id;
  final String revelationPlace;
  final String nameSimple;
  final String nameArabic;
  final int versesCount;

  Chapter({
    required this.id,
    required this.revelationPlace,
    required this.nameSimple,
    required this.nameArabic,
    required this.versesCount,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      revelationPlace: json['revelation_place'],
      nameSimple: json['name_simple'],
      nameArabic: json['name_arabic'],
      versesCount: json['verses_count'],
    );
  }
}
