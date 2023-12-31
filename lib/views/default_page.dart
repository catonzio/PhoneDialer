import 'package:flutter/material.dart';
import 'package:phone_dialer/extensions/context_extensions.dart';
import 'package:phone_dialer/widgets/bottom_bar.dart';

class DefaultPage extends StatelessWidget {
  final Widget body;
  const DefaultPage({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.colorScheme.background,
        body: body,
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
