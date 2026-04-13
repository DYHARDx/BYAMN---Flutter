class HomeStatItem {
  const HomeStatItem({required this.value, required this.label});

  final String value;
  final String label;

  factory HomeStatItem.fromJson(Map<String, dynamic> json) {
    return HomeStatItem(
      value: (json['value'] ?? '').toString(),
      label: (json['label'] ?? '').toString(),
    );
  }
}

class FaqItem {
  const FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      question: (json['question'] ?? '').toString(),
      answer: (json['answer'] ?? '').toString(),
    );
  }
}

class HomeFeatureItem {
  const HomeFeatureItem({required this.title, required this.description});

  final String title;
  final String description;

  factory HomeFeatureItem.fromJson(Map<String, dynamic> json) {
    return HomeFeatureItem(
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
    );
  }
}

class TestimonialItem {
  const TestimonialItem({
    required this.name,
    required this.role,
    required this.quote,
    required this.imageUrl,
  });

  final String name;
  final String role;
  final String quote;
  final String imageUrl;

  factory TestimonialItem.fromJson(Map<String, dynamic> json) {
    return TestimonialItem(
      name: (json['name'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      quote: (json['quote'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
    );
  }
}
