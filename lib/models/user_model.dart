
class UserModel
{
  final String email;
  final String fullName;
  final String role;
  final String? imageUrl;

  UserModel({required this.email, required this.fullName, required this.role, this.imageUrl});

  factory UserModel.fromMap(Map<String, dynamic> map)
  {
    return UserModel(email: map['email'], fullName: map['name'], role: map['role'], imageUrl: map['image']);
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name': fullName,
      'email': email,
      'role': role,
      'image': imageUrl,
    };
  }
}