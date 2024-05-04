class GptModel {
  final String id;
  final int created;
  final String root;

  GptModel({
    required this.id,
    required this.root,
    required this.created,
  });

  factory GptModel.fromJson(Map<String, dynamic> json) => GptModel(
        id: json["id"],
        root: json["root"],
        created: json["created"],
      );

  static List<GptModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => GptModel.fromJson(data)).toList();
  }
}
