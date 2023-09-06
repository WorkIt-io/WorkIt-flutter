
class UserModel
{
  final String email;
  final String fullName;
  final String role;
  final String? imageUrl;  
  final String? businessId;
  final String? communityId;


  UserModel({required this.email, required this.fullName, required this.role, this.imageUrl, this.businessId, this.communityId});

  factory UserModel.fromMap(Map<String, dynamic> map)
  {
    return UserModel(email: map['email'], fullName: map['name'], role: map['role'], imageUrl: map['image'], businessId: map['businessId'], communityId: map['communityId']);
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name': fullName,
      'email': email,
      'role': role,
      'image': imageUrl,
      'businessId': businessId,
      'communityId': communityId
    };
  }
}