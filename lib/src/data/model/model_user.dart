class UserModel {
  late final int id;
  late String username;
  late String firstname;
  late String lastname;
  late final String nickname;
  late String image;
  late String url;
  late final int level;
  late String description;
  late final String tag;
  late final double rate;
  late final int comment;
  late int total;
  late final String token;
  late String email;

  UserModel({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.nickname,
    required this.image,
    required this.url,
    required this.level,
    required this.description,
    required this.tag,
    required this.rate,
    required this.comment,
    required this.total,
    required this.token,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'] ?? 0,
      username: json['username'] ?? 'Unknown',
      firstname: json['firstname'] ?? 'Unknown',
      lastname: json['lastname'] ?? 'Unknown',
      nickname: json['user_nicename'] ?? 'Unknown',
      image: json['image'] ?? 'Unknown',
      url: json['website'] ?? 'Unknown',
      level: json['user_level'] ?? 0,
      description: json['description'] ?? 'Unknown',
      tag: json['tag'] ?? 'Unknown',
      rate: double.tryParse('${json['rating_avg']}') ?? 0.0,
      comment: int.tryParse('${json['total_comment']}') ?? 0,
      total: json['total'] ?? 0,
      token: json['accessToken'] ?? "Unknown",
      email: json['email'] ?? 'Unknown',
    );
  }

  UserModel updateUser({
    String? name,
    String? username,
    String? firstname,
    String? lastname,
    String? email,
    String? url,
    String? description,
    String? image,
    int? total,
  }) {
    this.username = username ?? this.username;
    this.firstname = firstname ?? this.firstname;
    this.lastname = lastname ?? this.lastname;
    this.email = email ?? this.email;
    this.url = url ?? this.url;
    this.description = description ?? this.description;
    this.image = image ?? this.image;
    this.total = total ?? this.total;
    return clone();
  }

  UserModel.fromSource(source) {
    id = source.id;
    username = source.username;
    firstname = source.firstname;
    lastname = source.lastname;
    nickname = source.nickname;
    image = source.image;
    url = source.url;
    level = source.level;
    description = source.description;
    tag = source.tag;
    rate = source.rate;
    comment = source.comment;
    total = source.total;
    token = source.token;
    email = source.email;
  }

  UserModel clone() {
    return UserModel.fromSource(this);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'user_nicename': nickname,
      'user_photo': image,
      'user_url': url,
      'user_level': level,
      'description': description,
      'tag': tag,
      'rating_avg': rate,
      'total_comment': rate,
      'total': total,
      'token': token,
      'email': email
    };
  }
}
