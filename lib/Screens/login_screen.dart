import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_stream/models/usermodel.dart';
import 'package:smart_stream/requests/user_request.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Login());
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

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
                  correo = value;
                }

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
              Usermodel logeoUser = new Usermodel(
                correo: correo,
                contrasena: contrasena,
                nickname: nickname,
              );

              List<Usermodel> listaUsuarios = await obtenerUsuarios();
              bool encontrado = false;

              for (Usermodel user in listaUsuarios) {
                if (user.correo == correo) {
                  encontrado = true;
                  break;
                }
              }

              if (!encontrado) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  title: 'Correo no existente',
                  desc: 'No existe un usuario con este correo.',
                  btnOkOnPress: () {},
                ).show();
              } else //intentamos procesar el login
              {
                bool intentologin = await intentoLogin(logeoUser);

                if (intentologin)
                  print('Bienvenido');
                else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.scale,
                    title: 'Credenciales incorrectas',
                    desc: 'Revisa que la contraseña es correcta',
                    btnOkOnPress: () {},
                  ).show();
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),

            child: Text(
              'Iniciar sesión',
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
