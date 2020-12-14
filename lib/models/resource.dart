class Resource {
  final int id;
  final double lat;
  final double long;
  final double distance;
  final String googlemapUrl;
  final String address;
  final String phone;
  final String email;
  final String web;
  final String name;
  final String descriptionAr;
  final String descriptionEn;
  final String descriptionEs;
  final String descriptionFr;
  final String tagsAr;
  final String tagsEn;
  final String tagsEs;
  final String tagsFr;
  String lang;

  Resource({
    this.id,
    this.lat,
    this.long,
    this.distance,
    this.googlemapUrl,
    this.address,
    this.phone,
    this.email,
    this.web,
    this.name,
    this.descriptionAr,
    this.descriptionEn,
    this.descriptionEs,
    this.descriptionFr,
    this.tagsAr,
    this.tagsEn,
    this.tagsEs,
    this.tagsFr,
    this.lang = 'es'
  });

  get description {
    switch(this.lang) {
      case 'ar':
        return this.descriptionAr;
      case 'en':
        return this.descriptionEn;
      case 'es':
        return this.descriptionEs;
      case 'fr':
        return this.descriptionFr;
      default:
        return this.descriptionEs;
    }
  }

  get tags {
    switch(this.lang) {
      case 'ar':
        return this.tagsAr;
      case 'en':
        return this.tagsEn;
      case 'es':
        return this.tagsEs;
      case 'fr':
        return this.tagsFr;
      default:
        return this.tagsEs;
    }
  }

  Resource applyLang(String lang) {
    this.lang = lang;
    return this;
  }

  factory Resource.fromMap(Map<String, dynamic> map) {
    return Resource(
        id: map['id'] as int,
        lat: (map['lat'] != "") ? map['lat']  as double: null,
        long: (map['long'] != "") ? map['long']  as double: null,
        distance: map.containsKey('distance') ? map['distance'] as double: null,
        googlemapUrl: map['googlemap_url'] as String,
        address: map['address'] as String,
        phone: map['phone'] as String,
        email: map['email'] as String,
        web: map['web'] as String,
        name: map['name'] as String,
        descriptionAr: map['description_ar'] as String,
        descriptionEn: map['description_en'] as String,
        descriptionEs: map['description_es'] as String,
        descriptionFr: map['description_fr'] as String,
        tagsAr: map['tags_ar'] as String,
        tagsEn: map['tags_en'] as String,
        tagsEs: map['tags_es'] as String,
        tagsFr: map['tags_fr'] as String
    );
  }

  /* This code should be useful only if you can add or update resources.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lat': lat,
      'long': long,
      'googlemap_url': googlemapUrl,
      'address': address,
      'phone': phone,
      'email': email,
      'web': web,
      'name': name,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'description_es': descriptionEs,
      'description_fr': descriptionFr,
      'tags_ar': tagsAr,
      'tags_en': tagsEn,
      'tags_es': tagsEs,
      'tags_fr': tagsFr
    };
  }
  */
}
