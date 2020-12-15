class GreenHouse {
  final int userId;
  final int id;
  final String title;

  GreenHouse({this.userId, this.id, this.title});

  factory GreenHouse.fromJson(Map<String, dynamic> json) {
    return GreenHouse(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
