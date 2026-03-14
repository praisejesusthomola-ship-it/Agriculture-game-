class Crop {
  String id;
  String name;
  int growthTime;
  double waterNeeded;
  double waterCurrent;
  bool isReadyToHarvest;
  int unlockLevel;
  double sellPrice;
  String imageAsset;

  Crop({required this.id, required this.name, required this.growthTime, required this.waterNeeded, required this.waterCurrent, required this.isReadyToHarvest, required this.unlockLevel, required this.sellPrice, required this.imageAsset});

  void water(double amount) {
    waterCurrent = (waterCurrent + amount).clamp(0, waterNeeded);
  }

  bool isFullyWatered() {
    return waterCurrent >= waterNeeded;
  }

  void reset() {
    waterCurrent = 0;
    isReadyToHarvest = false;
  }
}