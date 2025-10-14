import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final String nickname;
  const MainScreen({super.key, required this.nickname});

  @override
  Widget build(BuildContext build) {
    return Scaffold(body: mainscreen(nickname: nickname));
  }
}

class mainscreen extends StatelessWidget {
  final String nickname;
  const mainscreen({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E3C72), // azul oscuro
            Color(0xFF2A5298), // azul medio
            Color(0xFF6A1B9A), // violeta intenso
          ],
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Hola $nickname')],
      ),
    );
  }
}
