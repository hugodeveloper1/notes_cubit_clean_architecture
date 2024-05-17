import 'package:flutter/material.dart';

class HomeSearchSliver extends StatelessWidget {
  const HomeSearchSliver({
    super.key,
    required this.searchText,
  });

  final String searchText;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FlexibleSpaceBar(
          background: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              height: kTextTabBarHeight,
              child: Text(
                searchText,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
