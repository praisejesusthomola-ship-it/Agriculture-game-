class Player {
  String username;
  int totalLevel;
  double totalExperience;
  double totalMoney;
  DateTime lastPlayedDate;
  int totalTasksCompleted;

  Player({
    required this.username,
    required this.totalLevel,
    required this.totalExperience,
    required this.totalMoney,
    required this.lastPlayedDate,
    required this.totalTasksCompleted,
  });

  void addExperience(double amount) {
    totalExperience += amount;
    totalLevel = (totalExperience ~/ 1000) + 1;
  }

  void addMoney(double amount) {
    totalMoney += amount;
  }

  void spendMoney(double amount) {
    if (totalMoney >= amount) {
      totalMoney -= amount;
    }
  }

  void completeTask() {
    totalTasksCompleted++;
  }
}