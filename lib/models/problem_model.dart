class ProblemsModel {
  String id;
  String title;
  String description;
  String authorName;
  String solverName;
  String authorId;
  String solverId;
  List<String> imgIds;
  List<String> answerImgIds;
  List<String> tags;
  int baseToken;
  bool isSolved;
  List<String> solveCommendIds;
  String chooseSolveCommendId;
  DateTime createdAt;
  DateTime deadline;
  int rewardToken;
  String answer;
  String chatRoomId;
  String reportId;
  bool isUpvoted = false;

  ProblemsModel({
    this.id = '',
    this.title = '',
    this.authorName = '',
    this.solverName = '',
    this.authorId = '',
    this.solverId = '',
    DateTime? createdAt,
    DateTime? deadline,
    this.description = '',
    this.imgIds = const [],
    this.answerImgIds = const [],
    this.tags = const [],
    this.isSolved = false,
    this.baseToken = 0,
    this.solveCommendIds = const [],
    this.chooseSolveCommendId = '',
    this.rewardToken = 0,
    this.answer = '',
    this.chatRoomId = '',
    this.isUpvoted = false,
    this.reportId = '',
  })  : createdAt = createdAt ?? DateTime.now(),
        deadline = deadline ?? DateTime(0);

  static fromMap(Map<String, dynamic> data) {
    return ProblemsModel(
      id: data.containsKey('id') ? data['id'] : '',
      title: data.containsKey('title') ? data['title'] : '',
      description: data.containsKey('description') ? data['description'] : '',
      authorName: data.containsKey('authorName') ? data['authorName'] : '',
      solverName: data.containsKey('solverName') ? data['solverName'] : '',
      authorId: data.containsKey('authorId') ? data['authorId'] : '',
      imgIds:
          data.containsKey('imgIds') ? List<String>.from(data['imgIds']) : [],
      solverId: data.containsKey('solverId') ? data['solverId'] : '',
      answerImgIds: data.containsKey('answerImgIds')
          ? List<String>.from(data['answerImgIds'])
          : [],
      tags: data.containsKey('tags') ? List<String>.from(data['tags']) : [],
      isSolved: data.containsKey('isSolved') ? data['isSolved'] : false,
      baseToken: data.containsKey('baseToken') ? data['baseToken'] : 0,
      solveCommendIds: data.containsKey('solveCommendIds')
          ? List<String>.from(data['solveCommendIds'])
          : [],
      chooseSolveCommendId: data.containsKey('chooseSolveCommendId')
          ? data['chooseSolveCommendId']
          : '',
      createdAt: data.containsKey('createdAt')
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
      deadline: data.containsKey('deadline')
          ? DateTime.parse(data['deadline'])
          : DateTime(0),
      rewardToken: data.containsKey('rewardToken') ? data['rewardToken'] : 0,
      answer: data.containsKey('answer') ? data['answer'] : '',
      chatRoomId: data.containsKey('chatRoomId') ? data['chatRoomId'] : '',
      isUpvoted: data.containsKey('isUpvoted') ? data['isUpvoted'] : false,
      reportId: data.containsKey('reportId') ? data['reportId'] : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authorName': authorName,
      'solverName': solverName,
      'authorId': authorId,
      'solverId': solverId,
      'imgIds': imgIds,
      'answerImgIds': answerImgIds,
      'tags': tags,
      'isSolved': isSolved,
      'baseToken': baseToken,
      'solveCommendIds': solveCommendIds,
      'chooseSolveCommendId': chooseSolveCommendId,
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'rewardToken': rewardToken,
      'answer': answer,
      'chatRoomId': chatRoomId,
      'isUpvoted': isUpvoted,
      'reportId': reportId,
    };
  }

  bool get isOverDeadline {
    final DateTime now = DateTime.now();
    return now.isAfter(deadline);
  }

  String get existTimeString {
    final DateTime now = DateTime.now();
    final Duration existTime = now.difference(createdAt);
    final int days = existTime.inDays;
    final int hours = existTime.inHours;
    final int minutes = existTime.inMinutes;
    final int seconds = existTime.inSeconds;

    if (days > 0) {
      return '$days days';
    } else if (hours > 0) {
      return '$hours hours';
    } else if (minutes > 0) {
      return '$minutes minutes';
    } else {
      return '$seconds seconds';
    }
  }
}
