class User {
  String email;
  String? password;
  String firstName;
  String lastName;

  User({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'];
}
