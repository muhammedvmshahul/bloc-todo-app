/// Task model representing a to-do item.
class Task {
  int? id;              // Unique identifier for the task
  String title;          // Title of the task
  String description;    // Description of the task
  bool isCompleted;      // Status: true if the task is completed, false otherwise

  /// Constructor to initialize a Task object.
  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false, // Default value is false (task is pending)
  });

  /// Converts a Task object to a map (for SQLite database storage).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0, // SQLite stores boolean as 1 (true) and 0 (false)
    };
  }

  /// Creates a Task object from a map (retrieved from the SQLite database).
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1, // Convert SQLite integer back to boolean
    );
  }
}
