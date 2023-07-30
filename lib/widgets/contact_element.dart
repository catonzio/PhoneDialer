import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'dart:math' as math;

class ContactElement extends StatelessWidget {
  final Contact contact;
  final int index;
  const ContactElement({super.key, required this.contact, required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;

    return Container(
        // color: Colors.red[(index+1)*50 % 900],
        padding: EdgeInsets.symmetric(horizontal: width * 2),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: height * 4,
                height: height * 4,
                decoration: BoxDecoration(
                    // color: Colors.grey[900],
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Text(
                    "${contact.displayName[0]}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                child: Text("${contact.displayName} $index"),
              ),
            ]));
  }
}
