import 'package:pops/models/model_base.dart';

class UsersModel extends ModelBase {
  @override
  String id;
  String name;
  String email;
  String phone;
  String selfIntroduction;
  String headshotId;
  int reportNum;
  List<String> commandProblemIds;
  List<String> askProblemIds;
  List<String> pastExpertiseTags;
  List<String> expertiseTags;
  List<String> displaySystemTags;
  List<String> hideSystemTags;
  List<String> auditFailedTags;
  List<String> audittingTags;
  List<String> notices;
  List<FeedbacksModel> feedbacks;
  List<FolderModel> folders;
  List<String> chatRoomsIds;
  int tokens;
  double score;
  int numberOfScores;
  bool isPhoneVerified;

  UsersModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.headshotId = '',
    this.reportNum = 0,
    this.phone = '',
    this.commandProblemIds = const [],
    this.selfIntroduction = '',
    this.expertiseTags = const [],
    this.pastExpertiseTags = const [],
    this.displaySystemTags = const [],
    this.hideSystemTags = const [],
    this.auditFailedTags = const [],
    this.audittingTags = const [],
    this.askProblemIds = const [],
    this.chatRoomsIds = const [],
    this.feedbacks = const [],
    this.notices = const [],
    this.folders = const [],
    this.tokens = 0,
    this.score = 0,
    this.numberOfScores = 0,
    this.isPhoneVerified = false,
  });

  factory UsersModel.fromMap(Map<String, dynamic> data) {
    List<FeedbacksModel> feedbacks = [];
    if (data.containsKey('feedbacks')) {
      for (final Map<String, dynamic> feedback in data['feedbacks']) {
        feedbacks.add(FeedbacksModel.fromMap(feedback));
      }
    }
    List<FolderModel> folders = [];
    if (data.containsKey('folders')) {
      for (final Map<String, dynamic> folder in data['folders']) {
        folders.add(FolderModel.fromMap(folder));
      }
    }

    return UsersModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      headshotId: data['headshotId'] ?? '',
      reportNum: data['reportNum'] ?? 0,
      selfIntroduction: data['selfIntroduction'] ?? '',
      commandProblemIds: data['commandProblemIds'] == null
          ? []
          : data['commandProblemIds'].cast<String>(),
      askProblemIds: data['askProblemIds'] == null
          ? []
          : data['askProblemIds'].cast<String>(),
      expertiseTags: data['expertiseTags'] == null
          ? []
          : data['expertiseTags'].cast<String>(),
      pastExpertiseTags: data['pastExpertiseTags'] == null
          ? []
          : data['pastExpertiseTags'].cast<String>(),
      displaySystemTags: data['displaySystemTags'] == null
          ? []
          : data['displaySystemTags'].cast<String>(),
      hideSystemTags: data['hideSystemTags'] == null
          ? []
          : data['hideSystemTags'].cast<String>(),
      auditFailedTags: data['auditFailedTags'] == null
          ? []
          : data['auditFailedTags'].cast<String>(),
      audittingTags: data['audittingTags'] == null
          ? []
          : data['audittingTags'].cast<String>(),
      chatRoomsIds: data['chatRoomsIds'] == null
          ? []
          : data['chatRoomsIds'].cast<String>(),
      tokens: data['tokens'] ?? 0,
      score: data['score'] ?? 0.0,
      numberOfScores: data['numberOfScores'] ?? 0,
      feedbacks: feedbacks,
      folders: folders,
      notices: data['notices'] == null ? [] : data['notices'].cast<String>(),
      isPhoneVerified: data['isPhoneVerified'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'headshotId': headshotId,
      'phone': phone,
      'reportNum': reportNum,
      'selfIntroduction': selfIntroduction,
      'commandProblemIds': commandProblemIds,
      'askProblemIds': askProblemIds,
      'expertiseTags': expertiseTags,
      'pastExpertiseTags': pastExpertiseTags,
      'displaySystemTags': displaySystemTags,
      'hideSystemTags': hideSystemTags,
      'auditFailedTags': auditFailedTags,
      'audittingTags': audittingTags,
      'chatRoomsIds': chatRoomsIds,
      'tokens': tokens,
      'score': score,
      'numberOfScores': numberOfScores,
      'feedbacks': feedbacks.map((e) => e.toMap()).toList(),
      'folders': folders.map((e) => e.toMap()).toList(),
      'notices': notices,
      'isPhoneVerified': isPhoneVerified,
    };
  }
}

class FeedbacksModel {
  String userName;
  String feedback;
  int score;

  FeedbacksModel({
    required this.userName,
    required this.feedback,
    required this.score,
  });

  static FeedbacksModel fromMap(Map<String, dynamic> data) {
    return FeedbacksModel(
      userName: data['userName'] ?? '',
      feedback: data['feedback'] ?? '',
      score: data['score'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'feedback': feedback,
      'score': score,
    };
  }
}

class FolderModel {
  String name;
  List<String> problemIds;

  FolderModel({
    required this.name,
    this.problemIds = const [],
  });

  static FolderModel fromMap(Map<String, dynamic> data) {
    return FolderModel(
      name: data['name'] ?? '',
      problemIds:
          data['problemIds'] == null ? [] : data['problemIds'].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'problemIds': problemIds,
    };
  }
}