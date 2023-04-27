import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SquareAnimation(),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<AlignmentGeometry> _animation;
  bool isStartPosition = true;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.5,
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _controller.addListener(() {
      isStartPosition == true ? setState(() => isStartPosition = false) : null;
    });
    _animation.addStatusListener((status) {
      // Repaint screen to enable/disable buttons
      setState(() {});
    });
  }

  static const squareSize = 50.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          AlignTransition(
            alignment: _animation,
            child: Stack(
              children: [
                Container(
                  width: squareSize,
                  height: squareSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(),
                  ),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IgnorePointer(
                ignoring:
                    _animation.isCompleted || isStartPosition ? false : true,
                child: ElevatedButton(
                    onPressed: () {
                      _controller.reverse();
                    },
                    child: const Text("To the left")),
              ),
              IgnorePointer(
                ignoring:
                    _animation.isDismissed || isStartPosition ? false : true,
                child: ElevatedButton(
                    onPressed: () {
                      _controller.forward();
                    },
                    child: const Text("To the right")),
              )
            ],
          )
        ],
      ),
    );
  }
}
