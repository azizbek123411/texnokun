class Ayah {
  final String arabicText;
  final String englishText;
  final String russianText;

  Ayah({
    required this.arabicText,
    required this.englishText,
    required this.russianText,
  });

  Map<String, dynamic> toJson() {
    return {
      'arabicText': arabicText,
      'englishText': englishText,
      'russianText': russianText,
    };
  }

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      arabicText: json['arabicText'],
      englishText: json['englishText'],
      russianText: json['russianText'],
    );
  }
}



