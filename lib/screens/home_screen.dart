import 'package:flutter/material.dart';
import 'counter_screen.dart';
import 'todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color stravaOrange = Color(0xFFFC5200);
    const Color darkBg = Color(0xFF121212);

    return Scaffold(
      backgroundColor: darkBg,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: stravaOrange.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: stravaOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.bolt, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "TaskFlow",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    "DASHBOARD",
                    style: TextStyle(
                      color: stravaOrange,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuCard(
                    context,
                    "Activity Counter",
                    "Keep track of your reps",
                    Icons.add_circle_outline,
                    const CounterScreen(),
                    stravaOrange,
                  ),
                  _buildMenuCard(
                    context,
                    "Training Tasks",
                    "Daily goals & checklists",
                    Icons.format_list_bulleted_rounded,
                    const TodoScreen(),
                    stravaOrange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String title, String subtitle, IconData icon, Widget screen, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => _navigateTo(context, screen),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Icon(icon, color: accentColor, size: 32),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
