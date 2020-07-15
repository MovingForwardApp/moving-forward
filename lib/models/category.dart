class Category {
  final int id;
  final String slug;
  final String color;
  final String icon;
  final int order;
  final String name;
  final String description;

  Category({
    this.id,
    this.slug,
    this.color,
    this.icon,
    this.order,
    this.name,
    this.description
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['id'] as int,
        slug: map['slug'] as String,
        color: map['color'] as String,
        icon: map['icon'] as String,
        order: map['order'] as int,
        name: map['name'] as String,
        description: map['description'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slug': slug,
      'color': color,
      'icon': icon,
      'order': order,
      'name': name,
      'description': description
    };
  }
}