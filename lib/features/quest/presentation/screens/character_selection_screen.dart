import 'package:flutter/material.dart';
import 'package:army/features/quest/domain/models/character.dart';
import 'character_details_screen.dart';

class CharacterSelectionScreen extends StatefulWidget {
  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() => _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор бойца'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
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
          
          // Main content
          Column(
            children: [
              // Character showcase
              Expanded(
                flex: 7,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: sampleCharacters.length,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final character = sampleCharacters[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailsScreen(character: character),
                          ),
                        );
                      },
                      child: AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.8, 1.0);
                          }
                          return Transform.scale(
                            scale: Curves.easeOut.transform(value),
                            child: child,
                          );
                        },
                        child: Hero(
                          tag: 'character-${character.id}',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.grey[800]!,
                                      Colors.grey[900]!,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Character image
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Image.asset(
                                          character.imagePath,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Center(
                                              child: Icon(Icons.person, size: 100, color: Colors.grey),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    // Character info
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${character.name} (${character.nickname})',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${character.age} лет',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            // Stats row
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                _buildStat('СИЛА', character.strength, Icons.fitness_center),
                                                _buildStat('ЗДОР.', character.health, Icons.favorite),
                                                _buildStat('ЛОВК.', character.agility, Icons.bolt),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Page indicator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    sampleCharacters.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _selectedIndex == index ? 16.0 : 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: _selectedIndex == index 
                            ? Colors.blue[400] 
                            : Colors.blue[900],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Select button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedIndex < sampleCharacters.length) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                              CharacterDetailsScreen(character: sampleCharacters[_selectedIndex]),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    shadowColor: Colors.blue[900],
                  ),
                  child: const Text(
                    'ВЫБРАТЬ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, int value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue[400], size: 20),
        const SizedBox(height: 4),
        Text(
          '${'★' * value}${'☆' * (5 - value)}',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 12,
            letterSpacing: 2,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.amber.withOpacity(0.8),
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
