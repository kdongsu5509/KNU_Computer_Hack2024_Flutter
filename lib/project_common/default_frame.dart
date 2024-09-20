import 'package:flutter/material.dart';

class DefaultFrame extends StatelessWidget {
  final Widget child;
  const DefaultFrame({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}
