import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:phone_dialer/utils/extensions/context_extensions.dart';

class GroupElement extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const GroupElement({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(30));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(title),
            ),
            Material(
              elevation: 1,
              color: Colors.transparent,
              borderRadius: borderRadius,
              child: Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      border: Border.all(),
                      borderRadius: borderRadius),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ExpandableNotifier(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: children),
                  )),
            )
          ]),
    );
  }
}
