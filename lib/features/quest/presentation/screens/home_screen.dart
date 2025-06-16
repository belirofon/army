import 'package:flutter/material.dart';
import 'package:army/features/quest/presentation/screens/game_mode_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Size variable removed as it's not being used
    
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0F1F).withOpacity(0.9),
                  const Color(0xFF1A1E2E).withOpacity(0.9),
                  const Color(0xFF0A0F1F).withOpacity(0.9),
                ],
              ),
            ),
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/camo_pattern.png',
                fit: BoxFit.cover,
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          
          // Decorative elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[900]!.withOpacity(0.2),
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/rank.png',
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.military_tech, color: Colors.white, size: 40),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Рядовой',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Игрок',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      _buildStatChip(Icons.star, '0', Colors.amber),
                      const SizedBox(width: 8),
                      _buildStatChip(Icons.monetization_on, '0', Colors.green[300]!),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Game title
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'АРМЕЙСКИЕ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          height: 0.9,
                        ),
                      ),
                      Text(
                        'БУДНИ',
                        style: TextStyle(
                          color: const Color(0xFF64B5F6),
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          height: 0.9,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Main menu buttons
                  _buildMenuButton(
                    context,
                    'НАЧАТЬ ИГРУ',
                    Icons.play_arrow_rounded,
                    Colors.blue[700]!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameModeScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    context,
                    'АРМЕЙСКИЙ СОСТАВ',
                    Icons.groups_rounded,
                    Colors.green[700]!,
                    onPressed: () {
                      // TODO: Navigate to character selection
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    context,
                    'ДОСТИЖЕНИЯ',
                    Icons.emoji_events_rounded,
                    Colors.orange[700]!,
                    onPressed: () {
                      // TODO: Navigate to achievements
                    },
                  ),
                  
                  const Spacer(),
                  
                  // Footer
                  Center(
                    child: Text(
                      '© 2025 ARMY GAMES STUDIO',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color, {
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatChip(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
