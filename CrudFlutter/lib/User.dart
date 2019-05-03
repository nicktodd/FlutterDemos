class User  {

  int id;
  String name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['item_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'item_id': id,
  };

  @override
  String toString()
  {
    return "id: ${id} name:${name}";
  }

}