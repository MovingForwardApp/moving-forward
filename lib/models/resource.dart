class Resource {
  final int id;
  final double lat;
  final double long;
  final String address;
  final String phone;
  final String email;
  final String web;
  final String name;
  final String description;
  final String tags;

  Resource({
    this.id,
    this.lat,
    this.long,
    this.address,
    this.phone,
    this.email,
    this.web,
    this.name,
    this.description,
    this.tags
  });

  factory Resource.fromMap(Map<String, dynamic> map) {
    return Resource(
      id: map['id'] as int,
      lat: map['lat'] as double,
      long: map['long'] as double,
      address: map['address'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      web: map['web'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      tags: map['tags'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lat': lat,
      'long': long,
      'address': address,
      'phone': phone,
      'email': email,
      'web': web,
      'name': name,
      'description': description,
      'tags': tags
    };
  }
}
