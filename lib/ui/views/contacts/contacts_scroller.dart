import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_dialer/configs/themes.dart';

class ContactsScroller extends StatelessWidget {
  const ContactsScroller({super.key});

  @override
  Widget build(BuildContext context) {
    double width = context.width / 100;

    return Container(
      width: width * 5,
      height: double.infinity,
      decoration: BoxDecoration(
        color: dividerGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 100,
            child: Container(
              width: width * 5,
              height: width * 6,
              decoration: BoxDecoration(
                  color: yellow.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  21,
                  (index) => Container(
                        height: width * 0.5,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ))),
        ],
      ),
    );
  }
}
