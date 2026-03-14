class Farm {
  String name;
  int level;
  double money;
  double experience;
  List<String> ownedCrops;
  List<List<String>> farmGrid;

  Farm({
    required this.name,
    required this.level,
    required this.money,
    required this.experience,
    required this.ownedCrops,
    required this.farmGrid,
  });

  // Additional methods can be added here to manipulate farm data
}