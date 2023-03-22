import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class GeneralAppBar extends StatelessWidget {
  final Widget child;
  const GeneralAppBar(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        Container(
          height: 56 + paddingTop,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: paddingTop, left: 56, right: 56),
            alignment: Alignment.center,
            // color: const Color(0xFF11203B).withOpacity(0.5),
            // color: ThemeColors.accentBackground.withOpacity(0.86),
            child: Center(
              child: child,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 8, top: 4 + MediaQuery.of(context).padding.top),
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Log.dialog(context, "Navigation pop");
            },
            icon: Image.asset(
              "assets/images/icons/arrow_left.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}
