class NetworkUser {
  const NetworkUser({
    required this.id,
    required this.name,
    required this.role,
    required this.location,
    required this.imageUrl,
    required this.skills,
  });

  final String id;
  final String name;
  final String role;
  final String location;
  final String imageUrl;
  final List<String> skills;

  factory NetworkUser.fromJson(Map<String, dynamic> json) {
    return NetworkUser(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      location: (json['location'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
      skills: ((json['skills'] ?? <dynamic>[]) as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
    );
  }
}
