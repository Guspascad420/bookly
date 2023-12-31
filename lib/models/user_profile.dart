class UserProfile {
  final String name;
  final String email;

  UserProfile(this.name, this.email);

  factory UserProfile.fromMap(Map<String, dynamic> userProfileMap) {
    return UserProfile(userProfileMap["name"], userProfileMap["email"]);
  }
}