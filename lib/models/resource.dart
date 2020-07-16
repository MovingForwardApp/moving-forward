class Resource {
  final int id;
  final int categoryId;
  final double lat;
  final double long;
  final String googlemapUrl;
  final String address;
  final String phone;
  final String email;
  final String web;
  final String nameAr;
  final String nameEn;
  final String nameEs;
  final String nameFr;
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
    this.categoryId,
    this.lat,
    this.long,
    this.googlemapUrl,
    this.address,
    this.phone,
    this.email,
    this.web,
    this.nameAr,
    this.nameEn,
    this.nameEs,
    this.nameFr,
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

  get name {
    switch(this.lang) {
      case 'ar':
        return this.nameAr;
      case 'en':
        return this.nameEn;
      case 'es':
        return this.nameEs;
      case 'fr':
        return this.nameFr;
      default:
        return this.nameEs;
    }
  }

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
        categoryId: map['category_id'] as int,
        lat: map['lat'] as double,
        long: map['long'] as double,
        googlemapUrl: map['googlemap_url'] as String,
        address: map['address'] as String,
        phone: map['phone'] as String,
        email: map['email'] as String,
        web: map['web'] as String,
        nameAr: map['name_ar'] as String,
        nameEn: map['name_en'] as String,
        nameEs: map['name_es'] as String,
        nameFr: map['name_fr'] as String,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'lat': lat,
      'long': long,
      'googlemap_url': googlemapUrl,
      'address': address,
      'phone': phone,
      'email': email,
      'web': web,
      'name_ar': nameAr,
      'name_en': nameEn,
      'name_es': nameEs,
      'name_fr': nameFr,
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
}
