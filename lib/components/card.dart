import 'package:flutter/material.dart';
import 'package:sharedspace/configs/themes.dart';

class CardBox extends StatelessWidget {
  final Color? boxColor;
  final String? name;
  const CardBox({Key? key, this.boxColor, this.name}) : super(key: key);

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
        color: boxColor,
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
              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name != null
                        ? '$name'
                        : 'No name given, Please update details',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              ),
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
