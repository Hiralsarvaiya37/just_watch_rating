class UserInformationModel {
  int id;
  String name;
  String username;
  String email;
  String street;
  String suite;
  String city;
  String zipcode;
  String lat;
  String lng;
  String phone;
  String website;
  String companyName;
  String catchPhrase;
  String bs;

  UserInformationModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.lat,
    required this.lng,
    required this.phone,
    required this.website,
    required this.companyName,
    required this.catchPhrase,
    required this.bs,
  });

  factory UserInformationModel.fromJson(Map<String, dynamic> json) {
    return UserInformationModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      street: json['address']['street'],
      suite: json['address']['suite'],
      city: json['address']['city'],
      zipcode: json['address']['zipcode'],
      lat: json['address']['geo']['lat'],
      lng: json['address']['geo']['lng'],
      phone: json['phone'],
      website: json['website'],
      companyName: json['company']['name'],
      catchPhrase: json['company']['catchPhrase'],
      bs: json['company']['bs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'address': {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': {'lat': lat, 'lng': lng},
      },
      'phone': phone,
      'website': website,
      'company': {'name': companyName, 'catchPhrase': catchPhrase, 'bs': bs},
    };
  }
}
