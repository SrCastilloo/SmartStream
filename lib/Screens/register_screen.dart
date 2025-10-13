import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_stream/models/usermodel.dart';
import 'package:smart_stream/requests/user_request.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Register());
  }
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? correo;
    String? contrasena;
    String? nickname;

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
          SizedBox(height: size.height * 0.03),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                labelText: 'NickName',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.person, color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6A1B9A), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Introduce un nombre';
                else {
                  if (value.length < 3) {
                    return 'Introduce más de 3 caracteres';
                  }
                }
                nickname = value;
                return null;
              },
            ),
          ),
          SizedBox(height: size.height * 0.03),

          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.email, color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6A1B9A), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Introduce un correo';
                else {
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Correo invalido';
                  }
                }
                correo = value;
                return null;
              },
            ),
          ),

          SizedBox(height: size.height * 0.03),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              obscureText: true,
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.password, color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6A1B9A), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Introduce una contraseña';
                else {
                  if (value.length < 8) {
                    return 'Introduce al menos 8 caracteres';
                  }
                }
                contrasena = value;
                return null;
              },
            ),
          ),
          SizedBox(height: size.height * 0.03),
          ElevatedButton(
            onPressed: () async {
              List<Usermodel> listaUsuarios = await obtenerUsuarios();
              bool encontrado = false;
              Usermodel newUser = Usermodel(
                nickname: nickname,
                correo: correo,
                contrasena: contrasena,
              );

              for (Usermodel user in listaUsuarios) {
                if (user.correo == newUser.correo) {
                  encontrado = true;
                  break;
                }
              }

              if (!encontrado) //podemos crear al usuario
                print("Enhorabuena, usted se puede registrar");
              else
                print("Usuario con correo existente");
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
        ],
      ),
    );
  }
}

//el navigator.pop sirve para eliminar la pantalla actual de la pilla y llevarte
//a la pantalla anterior
