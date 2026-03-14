class Task {
  String id;
  String name;
  String description;
  String taskType;
  bool isCompleted;
  double rewardMoney;
  double rewardExperience;
  int timeLimit;
  DateTime createdAt;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.taskType,
    required this.isCompleted,
    required this.rewardMoney,
    required this.rewardExperience,
    required this.timeLimit,
    required this.createdAt,
  });

  bool isExpired() {
    final now = DateTime.now();
    final duration = now.difference(createdAt);
    return duration.inMinutes > timeLimit;
  }

  Duration getTimeRemaining() {
    final now = DateTime.now();
    final endTime = createdAt.add(Duration(minutes: timeLimit));
    return endTime.difference(now);
  }
}