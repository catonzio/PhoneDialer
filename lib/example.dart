import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:phone_dialer/controllers/contacts_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('List Demo')),
        body: CollapsingList(),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CollapsingList extends StatelessWidget {
  final ContactsController controller = Get.put(ContactsController());

  CollapsingList({super.key});

  SliverPersistentHeader makeHeader(String headerText, double height) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: height,
        maxHeight: height,
        child: Container(
            color: Colors.lightBlue, child: Center(child: Text(headerText))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: height * 0.4,
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.red,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Header Section 1",
                        style: TextStyle(fontSize: 40.0, color: Colors.black),
                      ),
                      if (controller.contacts.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "There are ${controller.contacts.length} contacts",
                            style:
                                const TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        makeHeader('Header Section 2', height * 0.08),
        Obx(
          () => controller.isLoadingContacts.value
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                          'List item ${controller.contactsFiltered[index].displayName}'),
                    );
                  }, childCount: controller.contactsFiltered.length)),
        )
      ],
    );
  }
}
