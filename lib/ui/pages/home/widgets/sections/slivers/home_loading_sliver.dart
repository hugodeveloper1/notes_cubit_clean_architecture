import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeLoadingSection extends StatelessWidget {
  const HomeLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.center,
            height: kTextTabBarHeight,
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}
