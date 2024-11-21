import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _moveAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.1415).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _moveAnimation = Tween<double>(begin: -100.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animação de movimento de fundo
            AnimatedBuilder(
              animation: _moveAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_moveAnimation.value, 0),
                  child: child,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                transform: Matrix4.rotationZ(_rotationAnimation.value),
              ),
            ),
            // Ícone giratório
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: child,
                );
              },
              child: Icon(
                Icons.cloud,
                size: 80,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            // Texto de carregamento com animação de opacidade
            Positioned(
              bottom: 30,
              child: FadeTransition(
                opacity: _controller.drive(CurveTween(curve: Curves.easeInOut)),
                child: const Text(
                  'Carregando...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}