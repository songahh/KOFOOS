// my_page_dto.dart

class MyPageDto {
  final String language;
  final List<DislikedMaterialDto> dislikedMaterials;
  final List<HistoryDto> histories;

  MyPageDto({
    required this.language,
    required this.dislikedMaterials,
    required this.histories,
  });

  factory MyPageDto.fromJson(Map<String, dynamic> json) {
    return MyPageDto(
      language: json['language'],
      dislikedMaterials: List<DislikedMaterialDto>.from(json['dislikedMaterials'].map((x) => DislikedMaterialDto.fromJson(x))),
      histories: List<HistoryDto>.from(json['histories'].map((x) => HistoryDto.fromJson(x))),
    );
  }
}

class DislikedMaterialDto {
  final int id;
  final String name;

  DislikedMaterialDto({
    required this.id,
    required this.name,
  });

  factory DislikedMaterialDto.fromJson(Map<String, dynamic> json) {
    return DislikedMaterialDto(
      id: json['id'],
      name: json['name'],
    );
  }
}

class HistoryDto {
  final String action;
  final DateTime date;

  HistoryDto({
    required this.action,
    required this.date,
  });

  factory HistoryDto.fromJson(Map<String, dynamic> json) {
    return HistoryDto(
      action: json['action'],
      date: DateTime.parse(json['date']),
    );
  }
}
