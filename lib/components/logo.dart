import 'package:flutter/material.dart';
import 'package:sharedspace/configs/themes.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 45,
            left: 20,
          ),
          child: Row(
            children: [
              const Text(
                "Shared",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: const Text(
                  "Space",
                  style: TextStyle(
                    fontSize: 45,
                    color: primaryClr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
