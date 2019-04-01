class HelpCamp {
  String id;
  String name;
  String description;
  String address;
  double lat;
  double lang;

  HelpCamp(this.id, this.name, this.description, this.address, this.lat,
      this.lang);

  HelpCamp.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['first_name'],
        description = json['last_name'],
        address = json['email'],
        lat = json['password'],
        lang = json['type'];


}
