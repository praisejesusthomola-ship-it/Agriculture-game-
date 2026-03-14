import 'package:flutter/foundation.dart';
import '../models/crop.dart';
import '../models/player.dart';
import '../models/farm.dart';
import '../models/task.dart';
import '../models/game_level.dart';

class GameService extends ChangeNotifier {
  late Player player;
  late Farm farm;
  List<Task> activeTasks = [];
  List<Crop> plantedCrops = [];

  GameService() {
    initializeGame();
  }

  void initializeGame() {
    player = Player(
      username: 'Player',
      totalLevel: 1,
      totalExperience: 0,
      totalMoney: 500,
      lastPlayedDate: DateTime.now(),
      totalTasksCompleted: 0,
    );

    farm = Farm(
      name: 'My Farm',
      level: 1,
      money: 500,
      experience: 0,
      ownedCrops: ['wheat', 'corn'],
      farmGrid: List.generate(5, (index) => List.generate(5, (_) => 'empty')),
    );

    generateDailyTasks();
    notifyListeners();
  }

  void generateDailyTasks() {
    activeTasks.clear();
    activeTasks = [
      Task(
        id: '1',
        name: 'Plant Wheat',
        description: 'Plant 3 wheat seeds',
        taskType: 'plant',
        isCompleted: false,
        rewardMoney: 50,
        rewardExperience: 100,
        timeLimit: 60,
        createdAt: DateTime.now(),
      ),
      Task(
        id: '2',
        name: 'Water Crops',
        description: 'Water all planted crops',
        taskType: 'water',
        isCompleted: false,
        rewardMoney: 40,
        rewardExperience: 80,
        timeLimit: 120,
        createdAt: DateTime.now(),
      ),
      Task(
        id: '3',
        name: 'Harvest Ready Crops',
        description: 'Harvest all ready crops',
        taskType: 'harvest',
        isCompleted: false,
        rewardMoney: 100,
        rewardExperience: 150,
        timeLimit: 90,
        createdAt: DateTime.now(),
      ),
    ];
    notifyListeners();
  }

  void completeTask(String taskId) {
    int index = activeTasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      Task task = activeTasks[index];
      if (!task.isCompleted && !task.isExpired()) {
        task.isCompleted = true;
        player.addMoney(task.rewardMoney);
        player.addExperience(task.rewardExperience);
        player.completeTask();
        farm.money += task.rewardMoney;
        farm.experience += task.rewardExperience;
        farm.level = player.totalLevel;
        notifyListeners();
      }
    }
  }

  void plantCrop(String cropName, int gridX, int gridY) {
    if (gridX < 5 && gridY < 5 && farm.farmGrid[gridX][gridY] == 'empty') {
      Crop newCrop = Crop(
        id: '\( {gridX}_ \){gridY}',
        name: cropName,
        growthTime: 30,
        waterNeeded: 10,
        waterCurrent: 0,
        isReadyToHarvest: false,
        unlockLevel: 1,
        sellPrice: 50,
        imageAsset: 'assets/crops/$cropName',
      );
      plantedCrops.add(newCrop);
      farm.farmGrid[gridX][gridY] = cropName;
      notifyListeners();
    }
  }

  void waterCrop(String cropId) {
    int index = plantedCrops.indexWhere((crop) => crop.id == cropId);
    if (index != -1) {
      plantedCrops[index].water(5);
      notifyListeners();
    }
  }

  void harvestCrop(String cropId) {
    int index = plantedCrops.indexWhere((crop) => crop.id == cropId);
    if (index != -1) {
      Crop crop = plantedCrops[index];
      if (crop.isFullyWatered()) {
        double money = crop.sellPrice;
        player.addMoney(money);
        farm.money += money;
        int gridX = int.parse(crop.id.split('_')[0]);
        int gridY = int.parse(crop.id.split('_')[1]);
        farm.farmGrid[gridX][gridY] = 'empty';
        plantedCrops.removeAt(index);
        notifyListeners();
      }
    }
  }

  void fertilizeCrop(String cropId) {
    int index = plantedCrops.indexWhere((crop) => crop.id == cropId);
    if (index != -1) {
      plantedCrops[index].growthTime = (plantedCrops[index].growthTime - 10).clamp(0, 30);
      notifyListeners();
    }
  }

  void feedAnimals() {
    player.addMoney(30);
    farm.money += 30;
    notifyListeners();
  }

  List<String> getUnlockedCrops() {
    return LevelManager.getUnlockedCropsFor(player.totalLevel);
  }

  double getProgressToNextLevel() {
    return (player.totalExperience % 1000) / 1000.0;
  }
}