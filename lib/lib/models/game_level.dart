class GameLevel {
  int levelNumber;
  String name;
  String description;
  List<String> unlockedCrops;
  int requiredExperience;
  double rewardMoney;
  List<String> newTaskTypes;

  GameLevel({
    required this.levelNumber,
    required this.name,
    required this.description,
    required this.unlockedCrops,
    required this.requiredExperience,
    required this.rewardMoney,
    required this.newTaskTypes,
  });
}

class LevelManager {
  static final List<GameLevel> levels = [
    GameLevel(
      levelNumber: 1,
      name: 'Farmer Beginner',
      description: 'Learn the basics of farming',
      unlockedCrops: ['wheat', 'corn'],
      requiredExperience: 0,
      rewardMoney: 100,
      newTaskTypes: ['plant', 'water'],
    ),
    GameLevel(
      levelNumber: 2,
      name: 'Experienced Farmer',
      description: 'Expand your farm',
      unlockedCrops: ['tomato', 'lettuce'],
      requiredExperience: 1000,
      rewardMoney: 200,
      newTaskTypes: ['harvest'],
    ),
    GameLevel(
      levelNumber: 3,
      name: 'Master Farmer',
      description: 'Manage a larger farm',
      unlockedCrops: ['carrot', 'potato'],
      requiredExperience: 2000,
      rewardMoney: 300,
      newTaskTypes: ['fertilize'],
    ),
    GameLevel(
      levelNumber: 4,
      name: 'Farm Manager',
      description: 'Manage animals on your farm',
      unlockedCrops: ['apple', 'orange'],
      requiredExperience: 3000,
      rewardMoney: 500,
      newTaskTypes: ['feed_animals'],
    ),
  ];

  static GameLevel? getLevelByNumber(int levelNumber) {
    try {
      return levels.firstWhere((level) => level.levelNumber == levelNumber);
    } catch (e) {
      return null;
    }
  }

  static List<String> getUnlockedCropsForLevel(int level) {
    List<String> unlockedCrops = [];
    for (var gameLevel in levels) {
      if (gameLevel.levelNumber <= level) {
        unlockedCrops.addAll(gameLevel.unlockedCrops);
      }
    }
    return unlockedCrops;
  }
}