class Player {
  late final String firstName;
  late final String lastName;
  late final String id;
  late final String rating;
  late final String status;
  Player(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.rating,
      required this.status});
  // factory Player.fromFireStore(Map<String, dynamic> json) => _$PersonFromJson(json);
  // Map<String, dynamic> toJson() => _$PersonToJson(this);
}
