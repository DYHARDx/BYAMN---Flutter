import 'dart:convert';

import '../../models/home_models.dart';
import '../../models/network_user.dart';
import '../../models/notification_item.dart';
import '../../models/opportunity_models.dart';
import '../static/byamn_static_json.dart';

class StaticContentRepository {
  Map<String, dynamic> parseHome() {
    return jsonDecode(byamnHomeJson) as Map<String, dynamic>;
  }

  String heroTitle() {
    final Map<String, dynamic> data = parseHome();
    return (data['heroTitle'] ?? '').toString();
  }

  String heroSubtitle() {
    final Map<String, dynamic> data = parseHome();
    return (data['heroSubtitle'] ?? '').toString();
  }

  List<HomeStatItem> homeStats() {
    final Map<String, dynamic> data = parseHome();
    final List<dynamic> list = (data['stats'] ?? <dynamic>[]) as List<dynamic>;
    return list
        .map(
          (dynamic item) => HomeStatItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  List<HomeFeatureItem> features() {
    final Map<String, dynamic> data = parseHome();
    final List<dynamic> list =
        (data['features'] ?? <dynamic>[]) as List<dynamic>;
    return list
        .map(
          (dynamic item) =>
              HomeFeatureItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  List<TestimonialItem> testimonials() {
    final Map<String, dynamic> data = parseHome();
    final List<dynamic> list =
        (data['testimonials'] ?? <dynamic>[]) as List<dynamic>;
    return list
        .map(
          (dynamic item) =>
              TestimonialItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  List<FaqItem> faq() {
    final Map<String, dynamic> data = parseHome();
    final List<dynamic> list = (data['faq'] ?? <dynamic>[]) as List<dynamic>;
    return list
        .map((dynamic item) => FaqItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  List<OpportunityItem> opportunities() {
    final List<dynamic> list =
        jsonDecode(byamnOpportunitiesJson) as List<dynamic>;
    return list
        .map(
          (dynamic item) =>
              OpportunityItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }

  List<OpportunityItem> opportunitiesByType(
    OpportunityType type, {
    int minimumCount = 520,
  }) {
    final List<OpportunityItem> seeds = opportunities()
        .where((OpportunityItem item) => item.type == type)
        .toList();

    if (seeds.isEmpty) return <OpportunityItem>[];

    final List<OpportunityItem> expanded = <OpportunityItem>[];
    for (int index = 0; index < minimumCount; index++) {
      final OpportunityItem base = seeds[index % seeds.length];
      final int rank = index + 1;
      expanded.add(
        OpportunityItem(
          id: '${base.id}_$rank',
          title: '${base.title} #$rank',
          provider: base.provider,
          category: base.category,
          duration: base.duration,
          rating: (base.rating - ((index % 6) * 0.05)).clamp(3.6, 5.0),
          tags: base.tags,
          url: base.url,
          type: base.type,
          imageUrl: 'https://picsum.photos/seed/${base.id}_$rank/800/500',
          location: index % 3 == 0 ? 'Remote' : base.location,
          summary: '${base.summary} (Batch $rank)',
          isFree: index % 4 != 0,
        ),
      );
    }
    return expanded;
  }

  List<NetworkUser> networkUsers({int minimumCount = 520}) {
    final List<dynamic> list =
        jsonDecode(byamnNetworkUsersJson) as List<dynamic>;
    final List<NetworkUser> seeds = list
        .map(
          (dynamic item) => NetworkUser.fromJson(item as Map<String, dynamic>),
        )
        .toList();

    if (seeds.isEmpty) return <NetworkUser>[];

    final List<NetworkUser> users = <NetworkUser>[];
    for (int index = 0; index < minimumCount; index++) {
      final NetworkUser base = seeds[index % seeds.length];
      final int rank = index + 1;
      users.add(
        NetworkUser(
          id: '${base.id}_$rank',
          name: '${base.name} $rank',
          role: base.role,
          location: base.location,
          imageUrl: 'https://picsum.photos/seed/network_$rank/300/300',
          skills: base.skills,
        ),
      );
    }
    return users;
  }

  List<AppNotificationItem> notifications() {
    final List<dynamic> list =
        jsonDecode(byamnNotificationsJson) as List<dynamic>;
    return list
        .map(
          (dynamic item) =>
              AppNotificationItem.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}
