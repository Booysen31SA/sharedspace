import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/card.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // use new Color(matchDetail['colorString']),

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              heading: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    decoration: const BoxDecoration(
                        color: primaryClr,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40))),
                    child: const Text(
                      "Shared",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "Space",
                    style: TextStyle(
                      fontSize: 35,
                      color: primaryClr,
                    ),
                  ),
                ],
              ),
              suffixIcon: GestureDetector(
                child: const Icon(
                  Icons.settings,
                  color: primaryClr,
                ),
                onTap: () => {
                  Navigator.pushNamed(context, '/settings'),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text(
                'MY PROFILE',
                style: headingStyle,
              ),
            ),

            //card
            const CardBox()
          ],
        ),
      ),
    );
  }
}
