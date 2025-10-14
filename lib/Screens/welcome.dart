import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_stream/Screens/login_screen.dart';
import 'package:smart_stream/Screens/register_screen.dart'; //fuentes de google

class Bienvenida extends StatelessWidget {
  const Bienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //rutas de navegación de la app
        '/registro': (context) => RegisterScreen(),
        '/iniciosesion': (context) => LoginScreen(),
      },
      home: PantallaInicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PantallaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        children: [
          Icon(Icons.play_arrow, size: 80, color: Colors.white),
          Text(
            'SmartStream',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            'Streaming sin límites',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: size.width * 0.08),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {
                  //redirige al registro
                  Navigator.pushNamed(context, '/registro'),
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                child: Text(
                  'Registro',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.05),
              ElevatedButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/iniciosesion'),
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
