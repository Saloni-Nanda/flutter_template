import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_paradise/common/theme/theme.dart';
import 'dart:math' as math;
import '../../utils/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late List<AnimationController> _cubeControllers;

  final List<Color> cubeColors = [
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();

    _cubeControllers = List.generate(
      4,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
      ),
    );

    for (int i = 0; i < _cubeControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _cubeControllers[i].repeat();
        }
      });
    }

Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Get.offNamed(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _cubeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Widget _buildCubeFace(Color color, Matrix4 transform, double opacity) {
  //   return Transform(
  //     transform: transform,
  //     alignment: Alignment.center,
  //     child: Container(
  //       width: 10,
  //       height: 10,
  //       decoration: BoxDecoration(
  //         color: color,
  //       ),
  //     ),
  //   );
  // }

  Widget _build3DCube(Color color, int index) {
    return AnimatedBuilder(
      animation: _cubeControllers[index],
      builder: (context, child) {
        final progress = _cubeControllers[index].value;
        // Multiple rotations for more visible effect
        final angleX = progress * 4 * math.pi; 
        final angleY = progress * 5 * math.pi;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.003), // More perspective
          alignment: Alignment.center,
          child: Transform(
            transform: Matrix4.identity()
              ..rotateX(angleX)
              ..rotateY(angleY),
            alignment: Alignment.center,
            child: SizedBox(
              width: 10,
              height: 10,
              child: Stack(
                children: [
                  // Front face (Blue-ish tint)
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, 0.0, 5.0),
                    alignment: Alignment.center,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                  ),
                  // Back face
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, 0.0, -5.0)
                      ..rotateY(math.pi),
                    alignment: Alignment.center,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                  ),
                  // Right face
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateY(math.pi / 2)
                      ..translate(0.0, 0.0, 5.0),
                    alignment: Alignment.center,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                  ),
                  // Left face
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateY(-math.pi / 2)
                      ..translate(0.0, 0.0, 5.0),
                    alignment: Alignment.center,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                  ),
                  // Top face
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateX(math.pi / 2)
                      ..translate(0.0, 0.0, 5.0),
                    alignment: Alignment.center,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                  ),
                  // Bottom face
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateX(-math.pi / 2)
                      ..translate(0.0, 0.0, 5.0),
                    alignment: Alignment.center,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha:0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.hotel,
                size: 50,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Hotel Paradise",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColor.primary,
              ),
            ),
            const SizedBox(height: 48),
            
            // 3D Rotating Cubes
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: _build3DCube(cubeColors[index], index),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}