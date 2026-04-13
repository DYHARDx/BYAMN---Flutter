enum OpportunityType { internship, course, job, tool, competition }

class OpportunityItem {
  const OpportunityItem({
    required this.id,
    required this.title,
    required this.provider,
    required this.category,
    required this.duration,
    required this.rating,
    required this.tags,
    required this.url,
    required this.type,
    required this.imageUrl,
    required this.location,
    required this.summary,
    required this.isFree,
  });

  final String id;
  final String title;
  final String provider;
  final String category;
  final String duration;
  final double rating;
  final List<String> tags;
  final String url;
  final OpportunityType type;
  final String imageUrl;
  final String location;
  final String summary;
  final bool isFree;

  factory OpportunityItem.fromJson(Map<String, dynamic> json) {
    final String rawType = (json['type'] ?? 'course').toString();
    final OpportunityType type = switch (rawType) {
      'internship' => OpportunityType.internship,
      'job' => OpportunityType.job,
      'tool' => OpportunityType.tool,
      'competition' => OpportunityType.competition,
      _ => OpportunityType.course,
    };

    return OpportunityItem(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      provider: (json['provider'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      duration: (json['duration'] ?? '').toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      tags: ((json['tags'] ?? <dynamic>[]) as List<dynamic>)
          .map((dynamic item) => item.toString())
          .toList(),
      url: (json['url'] ?? '').toString(),
      type: type,
      imageUrl: (json['imageUrl'] ?? '').toString(),
      location: (json['location'] ?? '').toString(),
      summary: (json['summary'] ?? '').toString(),
      isFree: (json['isFree'] as bool?) ?? true,
    );
  }
}
