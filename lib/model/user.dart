import 'package:cloud_firestore/cloud_firestore.dart';

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
  GeoPoint location;
  List<dynamic> cardSent;
  List<dynamic> cardReceived;
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
    required this.location,
    required this.cardSent,
    required this.cardReceived,
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
      location: json['location'],
      cardSent: json['cardSent'],
      cardReceived: json['cardReceived'],
      cardShare: json['cardShare'],
    );
  }

  //function that set a particular field to a certain value
  void setField(String field, String value) {
    switch (field) {
      case 'name':
        name = value;
        break;
      case 'prename':
        prename = value;
        break;
      case 'title':
        title = value;
        break;
      case 'company':
        company = value;
        break;
      case 'number':
        number = value;
        break;
      case 'address':
        address = value;
        break;
      case 'linkedin':
        linkedin = value;
        break;
      case 'website':
        website = value;
        break;
      case 'picture':
        picture = value;
        break;
      case 'bgColor':
        bgColor = value;
        break;
      case 'textColor':
        textColor = value;
        break;
      case 'location':
        location = value as GeoPoint;
        break;
      case 'cardSent':
        cardSent = value as List<Map<String, dynamic>>;
        break;
      case 'cardReceived':
        cardReceived = value as List<Map<String, dynamic>>;
        break;
      default:
        break;
    }
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
        'location': location,
        'cardSent': cardSent,
        'cardReceived': cardReceived,
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
