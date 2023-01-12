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
  List<String> expertiselabels;
  List<String> displaySystemlabels;
  List<String> auditFailedlabels;
  List<String> audittinglabels;
  List<String> notices;
  List<FeedbacksModel> feedbacks;
  List<FolderModel> folders;
  List<String> chatRoomsIds;
  int tokens;
  double score;
  int numberOfScores;

  UsersModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.headshotId = '',
    this.reportNum = 0,
    this.phone = '',
    this.commandProblemIds = const [],
    this.selfIntroduction = '',
    this.expertiselabels = const [],
    this.displaySystemlabels = const [],
    this.auditFailedlabels = const [],
    this.audittinglabels = const [],
    this.askProblemIds = const [],
    this.chatRoomsIds = const [],
    this.feedbacks = const [],
    this.notices = const [],
    this.folders = const [],
    this.tokens = 0,
    this.score = 0,
    this.numberOfScores = 0,
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
      expertiselabels: data['expertiselabels'] == null
          ? []
          : data['expertiselabels'].cast<String>(),
      displaySystemlabels: data['displaySystemlabels'] == null
          ? []
          : data['displaySystemlabels'].cast<String>(),
      auditFailedlabels: data['auditFailedlabels'] == null
          ? []
          : data['auditFailedlabels'].cast<String>(),
      audittinglabels: data['audittinglabels'] == null
          ? []
          : data['audittinglabels'].cast<String>(),
      chatRoomsIds: data['chatRoomsIds'] == null
          ? []
          : data['chatRoomsIds'].cast<String>(),
      tokens: data['tokens'] ?? 0,
      score: data['score'] ?? 0.0,
      numberOfScores: data['numberOfScores'] ?? 0,
      feedbacks: feedbacks,
      folders: folders,
      notices: data['notices'] == null ? [] : data['notices'].cast<String>(),
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
      'expertiselabels': expertiselabels,
      'displaySystemlabels': displaySystemlabels,
      'auditFailedlabels': auditFailedlabels,
      'audittinglabels': audittinglabels,
      'chatRoomsIds': chatRoomsIds,
      'tokens': tokens,
      'score': score,
      'numberOfScores': numberOfScores,
      'feedbacks': feedbacks.map((e) => e.toMap()).toList(),
      'folders': folders.map((e) => e.toMap()).toList(),
      'notices': notices,
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
