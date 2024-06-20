class Task {
  Task({
    required this.title,
    required this.description,
    required this.checklist,
    required this.rating,
    required this.comments,
    required this.stores,
  });

  String title;
  String description;
  String checklist;
  double rating;
  List<String> comments;
  List<int> stores;

  Task.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          description: json['description']! as String,
          checklist: json['checklist']! as String,
          rating: json['rating']! as double,
          comments: json['comments']! as List<String>,
          stores: json['stores']! as List<int>,
        );

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'checklists': checklist,
      'rating': rating,
      'comments': comments,
      'stores': stores,
    };
  }

  Task copyWith({
    String? title,
    String? description,
    String? checklist,
    double? rating,
    List<String>? comments,
    List<int>? stores,
  }) {
    return Task(
        title: title ?? this.title,
        description: description ?? this.description,
        checklist: checklist ?? this.checklist,
        rating: rating ?? this.rating,
        comments: comments ?? this.comments,
        stores: stores ?? this.stores);
  }
}
