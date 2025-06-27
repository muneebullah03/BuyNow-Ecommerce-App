class UserModel {
  String uid;
  String email;
  String name;
  String imageBase64;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.imageBase64,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'imageBase64': imageBase64,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      imageBase64: map['imageBase64'] ?? '',
    );
  }
}
