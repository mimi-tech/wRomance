import 'package:flutter/material.dart';
import 'package:womanly_mobile/main.dart';

/// This widget helps us to see how widget tree will look like for different screen sizes
class DebugSpaceDevourer extends StatelessWidget {
  final Widget child;
  const DebugSpaceDevourer({Key? key, required this.child}) : super(key: key);

  static double get height => enabled ? 0 : 0;
  static double get width => enabled ? 0 : 0;
  static const enabled = true;

  @override
  Widget build(BuildContext context) {
    if (!isTestEnvironment() || !enabled) {
      return child;
    }

    final original = MediaQuery.of(context);
    final data = original.copyWith(
      size: Size(original.size.width - width, original.size.height - height),
    );

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 3),
                curve: Curves.ease,
                color: Colors.green,
                height: height,
              ),
              Expanded(
                child: MediaQuery(
                  data: data,
                  child: child,
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.ease,
          color: Colors.green,
          width: width,
        ),
      ],
    );
  }
}
