// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  final String id;
  final String description;
  final bool completed;
  TodoModel({
    required this.id,
    required this.description,
    this.completed = false,
  });
}
