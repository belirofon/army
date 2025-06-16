class GameMode {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final bool isLocked;
  final int unlockLevel;
  final String? backgroundImage;
  final int xpReward;
  final int currencyReward;

  GameMode({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    this.isLocked = false,
    this.unlockLevel = 1,
    this.backgroundImage,
    this.xpReward = 100,
    this.currencyReward = 50,
  });

  // Create a copy with updated values
  GameMode copyWith({
    String? id,
    String? title,
    String? description,
    String? iconPath,
    bool? isLocked,
    int? unlockLevel,
    String? backgroundImage,
    int? xpReward,
    int? currencyReward,
  }) {
    return GameMode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      isLocked: isLocked ?? this.isLocked,
      unlockLevel: unlockLevel ?? this.unlockLevel,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      xpReward: xpReward ?? this.xpReward,
      currencyReward: currencyReward ?? this.currencyReward,
    );
  }
}

// Sample game modes data
final List<GameMode> sampleGameModes = [
  GameMode(
    id: 'basic_training',
    title: 'Курс молодого бойца',
    description: 'Основы военной подготовки для новобранцев',
    iconPath: 'assets/icons/modes/basic_training.png',
    isLocked: false,
    xpReward: 100,
    currencyReward: 50,
  ),
  GameMode(
    id: 'special_ops',
    title: 'Спецоперации',
    description: 'Опасные миссии за линией фронта',
    iconPath: 'assets/icons/modes/special_ops.png',
    isLocked: true,
    unlockLevel: 3,
    xpReward: 250,
    currencyReward: 120,
  ),
  GameMode(
    id: 'defense',
    title: 'Оборона',
    description: 'Удерживайте позицию от волн противника',
    iconPath: 'assets/icons/modes/defense.png',
    isLocked: true,
    unlockLevel: 2,
    xpReward: 180,
    currencyReward: 80,
  ),
  GameMode(
    id: 'pvp',
    title: 'PvP Арена',
    description: 'Сразитесь с другими игроками',
    iconPath: 'assets/icons/modes/pvp.png',
    isLocked: true,
    unlockLevel: 5,
    xpReward: 350,
    currencyReward: 200,
  ),
];
