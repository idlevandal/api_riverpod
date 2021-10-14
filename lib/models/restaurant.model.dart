
class Restaurant {
  Restaurant({
    required this.name,
    required this.cuisine,
    required this.hasIndoorSeating,
    this.yearOpened,
    required this.reviews,
    required this.staff,
    required this.menuItems,
  });
  final String name;
  final String cuisine;
  final int? yearOpened;
  final bool hasIndoorSeating;
  final List<Review> reviews;
  final List<Staff> staff;
  final List<MenuItem> menuItems;

  factory Restaurant.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String?; // cast to nullable string
    if (name == null) {
      throw UnsupportedError('Invalid data: $data -> "name" is missing');
    }
    final cuisine = data['cuisine'] as String;
    final yearOpened = data['yearOpened'] as int?;
    final hasIndoorSeating = data['hasIndoorSeating'] ?? false; // use null-coalescing operator (??) to provide default value.
    final reviewsData = data['reviews'] as List<dynamic>?;
    final reviews = reviewsData != null
        ? reviewsData.map((rev) => Review.fromJson(rev)).toList()
        : <Review>[];
    final staffData = data['staff'] as List<dynamic>?;
    final staff = staffData != null
        ? staffData.map((el) => Staff.fromJson(el)).toList()
        : <Staff>[];
    final menuItemsData = data['menuItems'] as List<dynamic>?;
    final menuItems = menuItemsData != null
        ? menuItemsData.map((el) => MenuItem.fromJson(el)).toList()
        : <MenuItem>[];
    return Restaurant(
      name: name,
      cuisine: cuisine,
      yearOpened: yearOpened,
      hasIndoorSeating: hasIndoorSeating,
      reviews: reviews,
      staff: staff,
      menuItems: menuItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cuisine': cuisine,
      if (yearOpened != null) 'year_opened': yearOpened,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }

  @override
  String toString() => toJson().toString();
}

class Review {
  Review({required this.score, this.review});
  // non-nullable - assuming the score field is always present
  final double score;
  // nullable - assuming the review field is optional
  final String? review;

  factory Review.fromJson(Map<String, dynamic> data) {
    final score = data['score'].toDouble() as double;
    final review = data['review'] as String?;
    return Review(score: score, review: review);
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      // here we use collection-if to account for null values
      if (review != null) 'review': review,
    };
  }

  @override
  String toString() => toJson().toString();
}

class Staff {
  Staff({required this.name, required this.phoneNumber});

  String name;
  String phoneNumber;

  factory Staff.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final phoneNumber = data['phoneNumber'] as String;
    return Staff(name: name, phoneNumber: phoneNumber);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber
    };
  }

  @override
  String toString() => toJson().toString();
}

class MenuItem {
  String title;
  String description;
  double price;

  MenuItem({required this.title, required this.description, required this.price});

  factory MenuItem.fromJson(Map<String, dynamic> data) {
    final title = data['title'];
    final description = data['description'];
    final price = data['price'];
    return MenuItem(title: title, description: description, price: price);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
    };
  }

  @override
  String toString() => toJson().toString();
}