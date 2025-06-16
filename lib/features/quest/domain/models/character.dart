class Character {
  final String id;
  final String name;
  final String nickname;
  final int age;
  final String description;
  final String imagePath;
  final Map<String, int> stats;
  final List<String> abilities;
  final bool isUnlocked;
  final int unlockCost;

  Character({
    required this.id,
    required this.name,
    required this.nickname,
    required this.age,
    required this.description,
    required this.imagePath,
    required this.stats,
    required this.abilities,
    this.isUnlocked = true,
    this.unlockCost = 0,
  });

  // Helper getters for common stats
  int get strength => stats['strength'] ?? 0;
  int get health => stats['health'] ?? 0;
  int get agility => stats['agility'] ?? 0;
  int get intelligence => stats['intelligence'] ?? 0;

  // Create a copy with updated values
  Character copyWith({
    String? id,
    String? name,
    String? nickname,
    int? age,
    String? description,
    String? imagePath,
    Map<String, int>? stats,
    List<String>? abilities,
    bool? isUnlocked,
    int? unlockCost,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      age: age ?? this.age,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      stats: stats ?? Map.from(this.stats),
      abilities: abilities ?? List.from(this.abilities),
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockCost: unlockCost ?? this.unlockCost,
    );
  }
}

// Sample characters data
final List<Character> sampleCharacters = [
  Character(
    id: '1',
    name: 'Алексей Петров',
    nickname: 'Барс',
    age: 28,
    description: 'Бывший спортсмен, специалист по рукопашному бою. Отличается лидерскими качествами и физической выносливостью.',
    imagePath: 'assets/images/characters/soldier1.png',
    stats: {
      'strength': 4,
      'health': 3,
      'agility': 4,
      'intelligence': 2,
    },
    abilities: [
      'Лидерство: +15% к эффективности отряда',
      'Рукопашный бой: +20% к урону в ближнем бою',
    ],
  ),
  Character(
    id: '2',
    name: 'Дмитрий Соколов',
    nickname: 'Снайпер',
    age: 32,
    description: 'Точный и хладнокровный снайпер с большим опытом боевых действий. Мастер маскировки и выживания в полевых условиях.',
    imagePath: 'assets/images/characters/sniper.png',
    stats: {
      'strength': 2,
      'health': 2,
      'agility': 3,
      'intelligence': 4,
    },
    abilities: [
      'Меткая стрельба: +25% к точности',
      'Маскировка: сложнее обнаружить противнику',
    ],
  ),
  // Add more characters as needed
];
