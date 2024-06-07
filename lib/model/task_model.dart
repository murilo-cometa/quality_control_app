class Task {
  Task({
    required this.title,
    required this.description,
    this.rating = 0.0,
    required this.comments,
  });
  final String title;
  final String description;
  final double rating;
  final List<String> comments;

  
}
