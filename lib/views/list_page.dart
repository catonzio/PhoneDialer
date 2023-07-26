import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import '../widgets/sliver_app_bar_delegate.dart';
//import 'package:phone_dialer/widgets/sliver_app_bar_delegate.dart';
import '../controllers/contacts_controller.dart';
import 'dart:math' as math;

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

class ListPage extends StatelessWidget {
  final ContactsController controller = Get.put(ContactsController());

  ListPage({super.key});

  SliverPersistentHeader makeHeader(String headerText, double height) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: height,
        maxHeight: height,
        child: Container(
          color: Colors.black,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() => controller.isSearching.value ?
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (text) => controller.searchContacts(text),
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search)))
              )
              )
               : Container()),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                controller.isSearching.value = !controller.isSearching.value;
                print("Search button pressed: ${controller.isSearching.value}");
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                print("More button pressed");
              },
            ),
          ]
        )
        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: controller.scrollController,
      slivers: <Widget>[
        SliverFixedExtentList(
          itemExtent: height * 30,
          delegate: SliverChildListDelegate(
            [
              Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Telefono",
                        style: TextStyle(fontSize: 50.0, color: Colors.white),
                      ),
                      if (controller.contacts.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "There are ${controller.contacts.length} contacts",
                            style:
                                const TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        makeHeader('Header Section 2', height * 8),
        Obx(
          () => controller.isLoadingContacts.value
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Column(
                        children: [
                          for (String group in controller.groups.keys.toList()..sort())
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: GroupElement(group: group),
                            )
                        ]
                      ),
                    /*SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      List<String> keys = controller.groups.keys.toList();
                      keys.sort();
                      String group = keys[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: GroupElement(group: group),
                      );
                    }, childCount: controller.groups.keys.length)),*/
                  ]
                ),
              )
        )
      ],
    )
      )
    );
  }
}

class GroupElement extends StatelessWidget {

  final ContactsController controller = Get.find<ContactsController>();
  final String group;

  GroupElement({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    List<int> idxs = controller.groups[group]!;

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(group, style: TextStyle(color: Colors.white)),
            ),
            Container(
              width: double.infinity,
              height: height*6.3*controller.groups[group]!.length.toDouble(),
              decoration: BoxDecoration(
              color: Colors.grey[900],
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buildElementsList(context, idxs)
                )
            )
          ]
        
    ); 
  }

  List<Widget> buildElementsList(BuildContext context, List<int> idxs) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    List<Widget> res = <Widget>[];
    for (int i = 0; i < idxs.length; i++) {
      if (i > 0) {
        res.add(Padding(
          padding: EdgeInsets.fromLTRB(12 + width*2 + height*4, 0, 8, 0),
          child: Divider()
        ));
      }
      res.add(ListElement(contact: controller.contacts[idxs[i]], index: i));
    }
    return res;
  }
}

class ListElement extends StatelessWidget {
  final Contact contact;
  final int index;
  ListElement({super.key, required this.contact, required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;

    return Container(
      // color: Colors.red[(index+1)*50 % 900],
      padding: EdgeInsets.symmetric(horizontal: width*2),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: height*4,
              height: height*4,
              decoration: BoxDecoration(
                // color: Colors.grey[900],
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child: Text("${contact.displayName[0]}", style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12, 0, 8, 0),
              child: Text("${contact.displayName} $index"),
            ),
          ]
        )
    );
  }
}