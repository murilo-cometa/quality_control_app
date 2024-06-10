class Checklist {
  Checklist({
    required this.name,
  });
  final String name;
  final List<Map> tasks = [
    {
      'name': 'testar',
      'description': 'muitas palavras',
      'comments': ['um comentário', 'dois comentários', 'três comentários'],
      'rating': 1,
    },
  ];
}
