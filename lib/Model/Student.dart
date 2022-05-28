class Student {
  String id;
  final String name;
  final String age;
  final String classroom;

  Student({
    this.id = '',
    this.name,
    this.age,
    this.classroom,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'classroom': classroom,
      };
}
