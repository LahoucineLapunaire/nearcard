class CurrentUser {
  String name;
  String prename;
  String title;
  String company;
  String number;
  String address;
  String linkedin;
  String website;
  String picture;
  String bgColor;
  String textColor;
  bool cardShare;

  CurrentUser({
    required this.name,
    required this.prename,
    required this.title,
    required this.company,
    required this.number,
    required this.address,
    required this.linkedin,
    required this.website,
    required this.picture,
    required this.bgColor,
    required this.textColor,
    required this.cardShare,
  });

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      name: json['name'],
      prename: json['prename'],
      title: json['title'],
      company: json['company'],
      number: json['number'],
      address: json['address'],
      linkedin: json['linkedin'],
      website: json['website'],
      picture: json['picture'],
      bgColor: json['bgColor'],
      textColor: json['textColor'],
      cardShare: json['cardShare'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'prename': prename,
        'title': title,
        'company': company,
        'number': number,
        'address': address,
        'linkedin': linkedin,
        'website': website,
        'picture': picture,
        'bgColor': bgColor,
        'textColor': textColor,
        'cardShare': cardShare,
      };
}

class VisitedUser {
  String name;
  String prename;
  String title;
  String company;
  String number;
  String address;
  String linkedin;
  String website;
  String picture;
  String bgColor;
  String textColor;

  VisitedUser({
    required this.name,
    required this.prename,
    required this.title,
    required this.company,
    required this.number,
    required this.address,
    required this.linkedin,
    required this.website,
    required this.picture,
    required this.bgColor,
    required this.textColor,
  });

  factory VisitedUser.fromJson(Map<String, dynamic> json) {
    return VisitedUser(
      name: json['name'],
      prename: json['prename'],
      title: json['title'],
      company: json['company'],
      number: json['number'],
      address: json['address'],
      linkedin: json['linkedin'],
      website: json['website'],
      picture: json['picture'],
      bgColor: json['bgColor'],
      textColor: json['textColor'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'prename': prename,
        'title': title,
        'company': company,
        'number': number,
        'address': address,
        'linkedin': linkedin,
        'website': website,
        'picture': picture,
        'bgColor': bgColor,
        'textColor': textColor,
      };
}
