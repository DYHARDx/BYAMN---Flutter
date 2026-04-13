import 'package:flutter/material.dart';

import '../data/repositories/static_content_repository.dart';
import '../models/home_models.dart';
import '../models/network_user.dart';
import '../models/notification_item.dart';
import '../models/opportunity_models.dart';

enum SortBy { ratingDesc, titleAsc }

class ContentProvider extends ChangeNotifier {
  ContentProvider({required StaticContentRepository repository})
    : _repository = repository {
    _load();
  }

  final StaticContentRepository _repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String heroTitle = '';
  String heroSubtitle = '';
  List<HomeStatItem> stats = <HomeStatItem>[];
  List<HomeFeatureItem> features = <HomeFeatureItem>[];
  List<TestimonialItem> testimonials = <TestimonialItem>[];
  List<FaqItem> faqItems = <FaqItem>[];
  final Set<int> expandedFaq = <int>{};

  List<OpportunityItem> _allCourses = <OpportunityItem>[];
  List<OpportunityItem> _allInternships = <OpportunityItem>[];
  List<OpportunityItem> _allJobs = <OpportunityItem>[];
  List<OpportunityItem> _allTools = <OpportunityItem>[];
  List<OpportunityItem> _allCompetitions = <OpportunityItem>[];
  List<NetworkUser> _allUsers = <NetworkUser>[];
  List<AppNotificationItem> _notifications = <AppNotificationItem>[];

  SortBy _courseSortBy = SortBy.ratingDesc;
  SortBy _internSortBy = SortBy.ratingDesc;

  bool _coursesGrid = true;
  bool _internshipsGrid = false;

  int _coursePage = 1;
  int _internshipPage = 1;
  int _jobPage = 1;
  int _userPage = 1;
  final int pageSize = 10;

  SortBy get courseSortBy => _courseSortBy;
  SortBy get internshipSortBy => _internSortBy;
  bool get coursesGrid => _coursesGrid;
  bool get internshipsGrid => _internshipsGrid;
  int get coursePage => _coursePage;
  int get internshipPage => _internshipPage;
  int get jobPage => _jobPage;
  int get userPage => _userPage;

  List<AppNotificationItem> get notifications => _notifications;
  List<OpportunityItem> get competitionHighlights =>
      _allCompetitions.take(5).toList();
  List<OpportunityItem> get toolHighlights => _allTools.take(6).toList();
  List<OpportunityItem> get jobHighlights => _allJobs.take(6).toList();

  int get totalJobPages => (_allJobs.length / pageSize).ceil().clamp(1, 999);
  int get totalUserPages => (_allUsers.length / pageSize).ceil().clamp(1, 999);

  int get totalCoursePages =>
      (_allCourses.length / pageSize).ceil().clamp(1, 999);
  int get totalInternshipPages =>
      (_allInternships.length / pageSize).ceil().clamp(1, 999);

  List<OpportunityItem> get pagedCourses {
    final List<OpportunityItem> sorted = _sorted(_allCourses, _courseSortBy);
    return _pageItems(sorted, _coursePage);
  }

  List<OpportunityItem> get pagedInternships {
    final List<OpportunityItem> sorted = _sorted(
      _allInternships,
      _internSortBy,
    );
    return _pageItems(sorted, _internshipPage);
  }

  List<OpportunityItem> get pagedJobs {
    final List<OpportunityItem> sorted = _sorted(_allJobs, SortBy.ratingDesc);
    return _pageItems(sorted, _jobPage);
  }

  List<NetworkUser> get pagedUsers {
    final int start = (_userPage - 1) * pageSize;
    final int end = (start + pageSize).clamp(0, _allUsers.length);
    if (start >= _allUsers.length) return <NetworkUser>[];
    return _allUsers.sublist(start, end);
  }

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 700));

    heroTitle = _repository.heroTitle();
    heroSubtitle = _repository.heroSubtitle();
    stats = _repository.homeStats();
    features = _repository.features();
    testimonials = _repository.testimonials();
    faqItems = _repository.faq();

    _allCourses = _repository.opportunitiesByType(OpportunityType.course);
    _allInternships = _repository.opportunitiesByType(
      OpportunityType.internship,
    );
    _allJobs = _repository.opportunitiesByType(OpportunityType.job);
    _allTools = _repository.opportunitiesByType(OpportunityType.tool);
    _allCompetitions = _repository.opportunitiesByType(
      OpportunityType.competition,
    );
    _allUsers = _repository.networkUsers();
    _notifications = _repository.notifications();

    _isLoading = false;
    notifyListeners();
  }

  void setCoursesGrid(bool value) {
    _coursesGrid = value;
    notifyListeners();
  }

  void setInternshipsGrid(bool value) {
    _internshipsGrid = value;
    notifyListeners();
  }

  void setCourseSort(SortBy sortBy) {
    _courseSortBy = sortBy;
    _coursePage = 1;
    notifyListeners();
  }

  void setInternshipSort(SortBy sortBy) {
    _internSortBy = sortBy;
    _internshipPage = 1;
    notifyListeners();
  }

  void nextCoursePage() {
    if (_coursePage < totalCoursePages) {
      _coursePage = _coursePage + 1;
      notifyListeners();
    }
  }

  void previousCoursePage() {
    if (_coursePage > 1) {
      _coursePage = _coursePage - 1;
      notifyListeners();
    }
  }

  void nextInternshipPage() {
    if (_internshipPage < totalInternshipPages) {
      _internshipPage = _internshipPage + 1;
      notifyListeners();
    }
  }

  void previousInternshipPage() {
    if (_internshipPage > 1) {
      _internshipPage = _internshipPage - 1;
      notifyListeners();
    }
  }

  void nextJobPage() {
    if (_jobPage < totalJobPages) {
      _jobPage = _jobPage + 1;
      notifyListeners();
    }
  }

  void previousJobPage() {
    if (_jobPage > 1) {
      _jobPage = _jobPage - 1;
      notifyListeners();
    }
  }

  void nextUserPage() {
    if (_userPage < totalUserPages) {
      _userPage = _userPage + 1;
      notifyListeners();
    }
  }

  void previousUserPage() {
    if (_userPage > 1) {
      _userPage = _userPage - 1;
      notifyListeners();
    }
  }

  void toggleFaq(int index, bool isExpanded) {
    if (isExpanded) {
      expandedFaq.remove(index);
    } else {
      expandedFaq.add(index);
    }
    notifyListeners();
  }

  List<OpportunityItem> _sorted(List<OpportunityItem> list, SortBy by) {
    final List<OpportunityItem> cloned = List<OpportunityItem>.from(list);
    if (by == SortBy.ratingDesc) {
      cloned.sort(
        (OpportunityItem a, OpportunityItem b) => b.rating.compareTo(a.rating),
      );
      return cloned;
    }
    cloned.sort(
      (OpportunityItem a, OpportunityItem b) => a.title.compareTo(b.title),
    );
    return cloned;
  }

  List<OpportunityItem> _pageItems(List<OpportunityItem> list, int page) {
    final int start = (page - 1) * pageSize;
    final int end = (start + pageSize).clamp(0, list.length);
    if (start >= list.length) return <OpportunityItem>[];
    return list.sublist(start, end);
  }
}
