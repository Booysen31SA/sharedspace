import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Models/cardListModel.dart';

class CardList extends StatelessWidget {
  final CardListModel cardListModel;
  const CardList({Key? key, required this.cardListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed('/space', arguments: cardListModel),
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 15,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardListModel.spaceColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    cardListModel.imageUrl.toString(),
                  ),
                  maxRadius: 28,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cardListModel.firstName} ${cardListModel.surname}',
                      style: const TextStyle(
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
      ),
    );
  }
}
