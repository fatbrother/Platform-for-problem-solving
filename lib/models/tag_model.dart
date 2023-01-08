class TagsModel {
  String id;
  String name;
  List<String> problemsWithTag;

  TagsModel({
    required this.id,
    required this.name,
    this.problemsWithTag = const [],
  });

  static fromMap(Map<String, dynamic> data) {
    return TagsModel(
      // if data have 'id' then use it, else set it to 0
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      problemsWithTag: data['problemsWithTag'] == null
          ? []
          : data['problemsWithTag'].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'problemsWithTag': problemsWithTag,
    };
  }
}