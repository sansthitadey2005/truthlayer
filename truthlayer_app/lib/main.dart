import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(const TruthLayerApp());
}

class TruthLayerApp extends StatelessWidget {
  const TruthLayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🌙 DARK THEME
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.deepPurpleAccent,
        colorScheme: ColorScheme.dark(
          primary: Colors.deepPurpleAccent,
          secondary: Colors.blueAccent,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F0C29), // deep galaxy
                Color(0xFF302B63),
                Color(0xFF24243E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),

          width: 350,
          height: 320,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔮 APP TITLE
              const Text(
                'TruthLayer', 
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 30),

              // 🔐 LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen()),);},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // 📝 REGISTER BUTTON
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => const RegisterScreen()),);},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blueAccent),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
