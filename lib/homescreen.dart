import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> animationHeight;
  late Animation<double> animationWidth;
  late Animation<double> animationShape;
  late Animation<Color?> animationColor;
  late Animation<Offset> animationOffset;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      upperBound: 1,
      lowerBound: 0,
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.completed) {
          animationController.forward();
        }
      },
    );

    animationWidth = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 50, end: 140), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.25),
      ),
    );
    animationHeight = TweenSequence(
      [
        TweenSequenceItem<double>(tween: Tween(begin: 50, end: 140), weight: 2),
      ],
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.25, 0.5),
      ),
    );

    animationOffset =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -100)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.25, 0.5),
      ),
    );
    animationShape = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 140), weight: 1)
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1),
      ),
    );

    animationColor =
        ColorTween(begin: const Color(0xffC6C8EC), end: Colors.amber.shade700)
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.75, 1),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(),
            AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: animationOffset.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(animationShape.value),
                      border: Border.all(
                        color: Colors.blue.shade400,
                        width: 3,
                      ),
                      color: animationColor.value,
                    ),
                    height: animationHeight.value,
                    width: animationWidth.value,
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (animationController.status == AnimationStatus.completed) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
              child: const Text("Click here for ANimation"),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
