import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DenisonLogo extends StatelessWidget {
  const DenisonLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 10),
        child: Image.asset(
          'assets/images/denison.png',
          height: 100,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
