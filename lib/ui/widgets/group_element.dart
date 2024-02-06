import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/utils/extensions/context_extensions.dart';

class GroupElement extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const GroupElement({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(title),
            ),
            Container(
                decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ExpandableNotifier(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: children),
                ))
          ]),
    );
  }
}
