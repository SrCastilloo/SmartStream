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
    final items = const [
      {'path': 'assets/images/deportes.jpg', 'titulo': 'Deportes'},
      {'path': 'assets/images/pelis.jpeg', 'titulo': 'Películas'},
      {'path': 'assets/images/series.jpg', 'titulo': 'Series'},
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
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
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Hola $nickname',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(
            height: 210,
            child: CarouselView(
              itemExtent: 200,
              // espaciado entre tarjetas
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: List.generate(items.length * 20, (i) {
                // <- ver punto 2
                final item = items[i % items.length];

                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  color:
                      Colors.transparent, //  no “tapona” el gradiente del fondo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // imagen
                        Image.asset(item['path']!, fit: BoxFit.cover),

                        // velo sutil para legibilidad sin romper el fondo
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.55),
                                  Colors.black.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // texto
                        Positioned(
                          left: 12,
                          right: 12,
                          bottom: 10,
                          child: Text(
                            item['titulo']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(blurRadius: 6, color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
