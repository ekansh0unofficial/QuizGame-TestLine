import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  const GameButton({
    Key? key,
    required this.child,
    required this.size,
    required this.color,
    this.duration = const Duration(milliseconds: 160),
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final Duration duration;
  final VoidCallback onPressed;
  final double size;

  @override
  _GameButtonState createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pressedAnimation;

  // Depth of button press effect
  double get buttonDepth => widget.size * 0.2;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  // Set up animations for the button press effect
  void _setupAnimation() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
      vsync: this,
    );
    _pressedAnimation = Tween<double>(begin: -buttonDepth, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant GameButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Rebuild animation controller if duration changes
    if (oldWidget.duration != widget.duration) {
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Handle tap down (start press animation)
  void _onTapDown(_) {
    _animationController.animateTo(1.0);
  }

  // Handle tap up (reverse animation and call onPressed callback)
  void _onTapUp(_) {
    _animationController.reverse().whenComplete(widget.onPressed);
  }

  // Handle tap cancel (reset animation)
  void _onTapCancel() {
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = widget.size * 0.25;
    final double horizontalPadding = widget.size * 0.50;
    final BorderRadius borderRadius =
        BorderRadius.circular(horizontalPadding * 0.7);

    return Container(
      padding: const EdgeInsets.only(bottom: 2, left: 0.5, right: 0.5),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: borderRadius,
      ),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Stack(
              children: <Widget>[
                // Background shadow layer
                Container(
                  decoration: BoxDecoration(
                    color: _adjustColor(s: -0.20, l: -0.20),
                    borderRadius: borderRadius,
                  ),
                ),
                // Animated button layer
                AnimatedBuilder(
                  animation: _pressedAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0.0, _pressedAnimation.value),
                      child: child,
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: borderRadius,
                        child: Stack(
                          children: <Widget>[
                            // Highlight layer
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: _adjustColor(),
                                borderRadius: borderRadius,
                              ),
                              child: const SizedBox.expand(),
                            ),
                            // Base button layer
                            Transform.translate(
                              offset: Offset(0.0, verticalPadding * 2),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: _adjustColor(),
                                  borderRadius: borderRadius,
                                ),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Button content (e.g., text or icon)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: verticalPadding,
                          horizontal: horizontalPadding,
                        ),
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Adjust the color using HSL values
  Color _adjustColor({double h = 0.0, double s = 0.0, double l = 0.0}) {
    final hslColor = HSLColor.fromColor(widget.color);
    final double adjustedHue = (hslColor.hue + h).clamp(0.0, 360.0);
    final double adjustedSaturation = (hslColor.saturation + s).clamp(0.0, 1.0);
    final double adjustedLightness = (hslColor.lightness + l).clamp(0.0, 1.0);

    return HSLColor.fromAHSL(
      1.0,
      adjustedHue,
      adjustedSaturation,
      adjustedLightness,
    ).toColor();
  }
}
