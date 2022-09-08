import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/card.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase_helpers.dart';
import 'package:sharedspace/models/usermodel.dart';
import 'package:sharedspace/util/convertStringToColor.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // use new Color(matchDetail['colorString']),

  getUserDetails(firebaseUser) async {
    //UserModel user = UserModel(uid: firebaseUser.uid, firstname: 'dsfds');
    var data = await userDBS.streamQueryList(
        args: [QueryArgsV2('uid', isEqualTo: firebaseUser!.uid)]);

    var result = await data.first;
    return result[0];
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    var userdetails = getUserDetails(firebaseUser);
    //print(userdetails.color);

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
            FutureBuilder(
              future: getUserDetails(firebaseUser),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var data = snapshot.data as UserModel;

                    //Color myColor = data.color as Color;
                    return CardBox(
                      boxColor: data.color == null
                          ? primaryClr
                          : StringToColor(data.color),
                    );
                  }
                }

                // Displaying LoadingSpinner to indicate waiting state
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
