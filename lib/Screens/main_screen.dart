import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MainScreen extends StatelessWidget {
  final String nickname;
  const MainScreen({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Mainscreen(nickname: nickname));
  }
}

class Mainscreen extends StatelessWidget {
  final String nickname;
  const Mainscreen({super.key, required this.nickname});

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
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF6A1B9A)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hola $nickname',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),

          //  Carrusel infinito
          SizedBox(
            height: 230,
            child: _InfiniteCarousel(
              items: items,
              onTap: (realIndex) {
                final item = items[realIndex];
                switch (item['titulo']) {
                  case 'Deportes':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DeportesScreen()),
                    );
                    break;
                  case 'Películas':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PeliculasScreen()),
                    );
                    break;
                  case 'Series':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SeriesScreen()),
                    );
                    break;
                  default:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(title: item['titulo']!),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Carrusel infinito con PageView.builder y efecto de escala en el ítem central.
class _InfiniteCarousel extends StatefulWidget {
  final List<Map<String, String>> items;
  final ValueChanged<int> onTap;

  const _InfiniteCarousel({required this.items, required this.onTap});

  @override
  State<_InfiniteCarousel> createState() => _InfiniteCarouselState();
}

class _InfiniteCarouselState extends State<_InfiniteCarousel> {
  late final PageController _controller;
  // Arrancamos lejos para poder deslizar "infinito" hacia ambos lados
  late final int _initialPage;

  @override
  void initState() {
    super.initState();
    _initialPage = widget.items.length * 1000;
    _controller = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.72, // ancho visible de cada tarjeta
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _pageValue() {
    // Devuelve el valor fraccional de la página actual para animaciones suaves
    try {
      return _controller.hasClients && _controller.positions.isNotEmpty
          ? (_controller.page ?? _initialPage.toDouble())
          : _initialPage.toDouble();
    } catch (_) {
      return _initialPage.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final page = _pageValue();

        return PageView.builder(
          controller: _controller,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final realIndex = index % widget.items.length;
            final item = widget.items[realIndex];

            // Efecto de escala y elevación según la distancia al centro
            final delta = (page - index).abs();
            final clamped = math.min(1.0, delta);
            final scale = 1.0 - clamped * 0.10; // hasta -10% de escala
            final elevation =
                10.0 * (1.0 - clamped); // más al centro -> más sombra

            return Center(
              child: Transform.scale(
                scale: scale,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 4.0,
                  ),
                  child: _FancyCarouselCard(
                    imagePath: item['path']!,
                    title: item['titulo']!,
                    elevation: elevation,
                    onTap: () => widget.onTap(realIndex),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _FancyCarouselCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double elevation;
  final VoidCallback onTap;

  const _FancyCarouselCard({
    required this.imagePath,
    required this.title,
    this.elevation = 8,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(22));

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      elevation: 0,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap, // ripple + callback
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: Colors.white.withOpacity(0.22), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 18 * (elevation / 10.0 + 0.4),
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(imagePath, fit: BoxFit.cover),

                // Overlay para contraste
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.55),
                        Colors.black.withOpacity(0.12),
                        Colors.black.withOpacity(0.02),
                      ],
                    ),
                  ),
                ),

                // Borde interior sutil
                Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.06),
                      width: 1,
                    ),
                  ),
                ),

                // Chip “glass” con el título
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: _GlassTitleChip(text: title),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassTitleChip extends StatelessWidget {
  final String text;
  const _GlassTitleChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.16),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.35), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.play_circle_fill, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
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
