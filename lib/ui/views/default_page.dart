import 'package:flutter/material.dart';
import 'package:phone_dialer/utils/extensions/context_extensions.dart';
import 'package:phone_dialer/ui/widgets/bottom_bar.dart';

class DefaultPage extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;

  const DefaultPage({super.key, this.appBar, required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: context.colorScheme.background,
        body: body,
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
