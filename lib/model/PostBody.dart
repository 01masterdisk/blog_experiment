class PostBody {
  String id;
  String author;
  String created_at;
  String title;
  String body;
  String updated_at;

  PostBody({
    required this.author,
    required this.created_at,
    required this.body,
    required this.title,
    required this.id,
    required this.updated_at
  });
}