import 'package:flutter/material.dart';
import 'package:army/features/quest/domain/models/game_mode.dart';
import 'package:army/features/quest/presentation/screens/character_selection_screen.dart';

class GameModeScreen extends StatelessWidget {
  const GameModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0F1F),
              Color(0xFF1A1E2E),
              Color(0xFF0A0F1F),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'РЕЖИМЫ ИГРЫ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(width: 48), // For balance
                  ],
                ),
              ),
              
              // Game Modes Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: sampleGameModes.length,
                    itemBuilder: (context, index) {
                      final mode = sampleGameModes[index];
                      return _buildGameModeCard(context, mode);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeCard(BuildContext context, GameMode mode) {
    return GestureDetector(
      onTap: () {
        if (mode.isLocked) {
          // Show locked dialog or message
          _showLockedDialog(context, mode);
        } else {
          // Navigate to character selection
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CharacterSelectionScreen(),
            ),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              mode.isLocked ? Colors.grey[800]! : const Color(0xFF1E2A4A),
              mode.isLocked ? Colors.grey[900]! : const Color(0xFF0F172A),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: mode.isLocked ? Colors.grey[700]! : const Color(0xFF2E3B5E),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(mode.backgroundImage ?? 'assets/images/camo_pattern.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.1),
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and Title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: mode.isLocked ? Colors.grey[800] : const Color(0xFF2E3B5E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getModeIcon(mode.id),
                          color: mode.isLocked ? Colors.grey[500] : Colors.blue[300],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          mode.title.toUpperCase(),
                          style: TextStyle(
                            color: mode.isLocked ? Colors.grey[400] : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Description
                  Text(
                    mode.description,
                    style: TextStyle(
                      color: mode.isLocked ? Colors.grey[500] : Colors.grey[300],
                      fontSize: 12,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Rewards and Level
                  Row(
                    children: [
                      // XP Reward
                      _buildRewardChip(
                        Icons.star,
                        '${mode.xpReward} XP',
                        Colors.amber,
                      ),
                      const SizedBox(width: 8),
                      // Currency Reward
                      _buildRewardChip(
                        Icons.monetization_on,
                        '${mode.currencyReward}',
                        Colors.green[300]!,
                      ),
                      const Spacer(),
                      // Level or Lock
                      if (mode.isLocked)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange[900]!.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.orange[700]!),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.lock, size: 12, color: Colors.orange),
                              const SizedBox(width: 4),
                              Text(
                                'Ур. ${mode.unlockLevel}',
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        const Icon(Icons.lock_open, size: 16, color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
            
            // Lock overlay if mode is locked
            if (mode.isLocked)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.lock_outline,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRewardChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getModeIcon(String modeId) {
    switch (modeId) {
      case 'basic_training':
        return Icons.school;
      case 'special_ops':
        return Icons.security;
      case 'defense':
        return Icons.shield;
      case 'pvp':
        return Icons.sports_esports;
      default:
        return Icons.help_outline;
    }
  }
  
  void _showLockedDialog(BuildContext context, GameMode mode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blue[700]!, width: 1.5),
        ),
        title: const Text(
          'РЕЖИМ ЗАБЛОКИРОВАН',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock,
              size: 50,
              color: Colors.orange[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Доступно с ${mode.unlockLevel} уровня',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Пройдите предыдущие миссии, чтобы разблокировать этот режим',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'ПОНЯТНО',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}