import 'package:flutter/material.dart';
import 'package:sharedspace/configs/themes.dart';

class CardBox extends StatelessWidget {
  const CardBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryClr,
        borderRadius: BorderRadius.circular(30), // change to user value
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  'images/profileImg.png',
                ),
                maxRadius: 28,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Matthew Booysen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 40,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
