import 'package:flutter/material.dart';
import 'package:army/features/quest/domain/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[900]!,
                  Colors.grey[850]!,
                  Colors.grey[900]!,
                ],
              ),
            ),
          ),
          
          // Content
          Column(
            children: [
              // App Bar
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement edit nickname
                    },
                  ),
                ],
              ),
              
              // Character Image
              Hero(
                tag: 'character-${character.id}',
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Image.asset(
                    character.imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.person, size: 150, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
              
              // Character Info Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and nickname
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                character.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '${character.age} лет',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 4),
                        Text(
                          'Позывной: ${character.nickname}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue[300],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Stats Section
                        const Text(
                          'ХАРАКТЕРИСТИКИ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        _buildStatRow('Сила', character.strength, Icons.fitness_center, Colors.red[400]!),
                        _buildStatRow('Здоровье', character.health, Icons.favorite, Colors.green[400]!),
                        _buildStatRow('Ловкость', character.agility, Icons.bolt, Colors.blue[400]!),
                        _buildStatRow('Интеллект', character.intelligence, Icons.psychology, Colors.purple[400]!),
                        
                        const SizedBox(height: 24),
                        
                        // Abilities Section
                        const Text(
                          'СПОСОБНОСТИ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        ...character.abilities.map((ability) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  ability,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                        
                        const SizedBox(height: 24),
                        
                        // Description
                        const Text(
                          'ОПИСАНИЕ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          character.description,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Select Button
                        if (!character.isUnlocked)
                          _buildUnlockButton()
                        else
                          _buildSelectButton(context),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatRow(String label, int value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: value / 5,
                    backgroundColor: Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$value/5',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSelectButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Return the selected character when navigating back
          Navigator.pop(context, character);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Colors.blue[900]!,
        ),
        child: const Text(
          'ВЫБРАТЬ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
  
  Widget _buildUnlockButton() {
    return Column(
      children: [
        Text(
          'Разблокировать за ${character.unlockCost} монет',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implement unlock character
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[700],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              shadowColor: Colors.amber[900]!,
            ),
            child: const Text(
              'РАЗБЛОКИРОВАТЬ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}