import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  static const Color stravaOrange = Color(0xFFFC5200);

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  _updateCounter(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = val;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("ACTIVITY COUNTER", 
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1.2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Spacer(),
          const Text(
            "TOTAL REPS",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Text(
            "$_counter",
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.0,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircleButton(Icons.remove, () => _updateCounter(_counter - 1), false),
                    _buildCircleButton(Icons.add, () => _updateCounter(_counter + 1), true),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => _updateCounter(0),
                  child: Text(
                    "RESET ACTIVITY",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onPressed, bool isPrimary) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: isPrimary ? stravaOrange : Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          boxShadow: isPrimary ? [
            BoxShadow(
              color: stravaOrange.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ] : null,
        ),
        child: Icon(icon, size: 32, color: isPrimary ? Colors.white : Colors.white70),
      ),
    );
  }
}
