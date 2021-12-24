class Player {
  late final String firstName;
  late final String lastName;
  late final String id;
  late final int rating;
  late final String status;
  Player(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.rating,
      required this.status});
  Player.fromFireStore(Map<String, dynamic> json)
      : this(
          firstName: json['first_name']! as String,
          lastName: json['last_name']! as String,
          id: json['id']! as String,
          rating: json['rating']! as int,
          status: json['status']! as String,
        );
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'id': id,
      'rating': rating,
      'status': status
    };
  }
}
