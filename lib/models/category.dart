class Category {
  final int id;
  final String slug;
  final String color;
  final String icon;
  final int order;
  final String nameAr;
  final String nameEn;
  final String nameEs;
  final String nameFr;
  final String descriptionAr;
  final String descriptionEn;
  final String descriptionEs;
  final String descriptionFr;
  String lang;

  Category({
    this.id,
    this.slug,
    this.color,
    this.icon,
    this.order,
    this.nameAr,
    this.nameEn,
    this.nameEs,
    this.nameFr,
    this.descriptionAr,
    this.descriptionEn,
    this.descriptionEs,
    this.descriptionFr,
    this.lang = 'es',
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

  Category applyLang(String lang) {
    this.lang = lang;
    return this;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['id'] as int,
        slug: map['slug'] as String,
        color: map['color'] as String,
        icon: map['icon'] as String,
        order: map['order'] as int,
        nameAr: map['name_ar'] as String,
        nameEn: map['name_en'] as String,
        nameEs: map['name_es'] as String,
        nameFr: map['name_fr'] as String,
        descriptionAr: map['description_ar'] as String,
        descriptionEn: map['description_en'] as String,
        descriptionEs: map['description_es'] as String,
        descriptionFr: map['description_fr'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'color': color,
      'icon': icon,
      'order': order,
      'name_ar': nameAr,
      'name_en': nameEn,
      'name_es': nameEs,
      'name_fr': nameFr,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'description_es': descriptionEs,
      'description_fr': descriptionFr
    };
  }
}