import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  late final AnimationController _controller;
  late final Animation<double> _heartAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _heartAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    ).disableAnimations) {
      _controller.value = 0.5;
    } else {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDetailPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DetailPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations & Transitions'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Implicit Animation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: reduceMotion ? 0 : 400),
                curve: Curves.easeInOut,
                width: _isExpanded ? 240 : 140,
                height: _isExpanded ? 180 : 120,
                decoration: BoxDecoration(
                  color: _isExpanded
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade200,
                  borderRadius: BorderRadius.circular(_isExpanded ? 32 : 12),
                ),
                child: const Center(
                  child: Icon(Icons.crop_square, color: Colors.white, size: 48),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          const Text(
            'Ketuk kotak untuk mengubah ukuran dan warna.',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 36),
          const Divider(),
          const SizedBox(height: 20),

          const Text(
            'Explicit Animation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Center(
            child: AnimatedBuilder(
              animation: _heartAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: reduceMotion ? 1.0 : _heartAnimation.value,
                  child: child,
                );
              },
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 80,
                semanticLabel: 'Ikon hati',
              ),
            ),
          ),

          const SizedBox(height: 12),
          const Text(
            'Ikon hati berdenyut menggunakan AnimationController '
            'dan Tween.',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 36),
          const Divider(),
          const SizedBox(height: 20),

          const Text(
            'Hero Animation & Page Transition',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Center(
            child: Semantics(
              button: true,
              label: 'Buka halaman detail dengan animasi roket',
              child: IconButton(
                tooltip: 'Buka halaman detail',
                onPressed: _openDetailPage,
                iconSize: 64,
                icon: const Hero(
                  tag: 'rocket-hero',
                  child: Icon(
                    Icons.rocket_launch,
                    color: Colors.deepPurple,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
          const Text(
            'Ketuk roket untuk membuka halaman detail.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
