import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/card.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/components/loading.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/models/usermodel.dart';
import 'package:sharedspace/services/functions.dart';
import 'package:sharedspace/util/convertStringToColor.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // use new Color(matchDetail['colorString']),

  // getUserDetails(firebaseUser) async {
  //   //UserModel user = UserModel(uid: firebaseUser.uid, firstname: 'dsfds');
  //   var data = await userDBS.streamQueryList(
  //       args: [QueryArgsV2('uid', isEqualTo: firebaseUser!.uid)]);

  //   var result = await data.first;
  //   return result[0];
  // }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    //var list = getUserSpaces(firebaseUser);
    //print(userdetails.color);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              prefixIcon: null,
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
                  Navigator.pushReplacementNamed(
                    context,
                    '/settings',
                    arguments: {'isMain': true},
                  ),
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
            // when creating a profile, create a Space for profile also
            myProfileCard(firebaseUser),

            Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MY SPACE',
                    style: headingStyle,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: primaryClr,
                    ),
                    child: GestureDetector(
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // My Spaces
            mySpaces(firebaseUser)
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> mySpaces(User? firebaseUser) {
    return FutureBuilder(
      future: getUserSpaces(firebaseUser),
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
            // display ListView builder
            var data = snapshot.data as List;

            return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return data.isNotEmpty
                      ? SingleChildScrollView(
                          child: GestureDetector(
                            onTap: () {
                              print(data[index].groupid);
                              Navigator.pushReplacementNamed(
                                  context, '/sharedspace',
                                  arguments: {
                                    'groupid': data[index].groupid,
                                    'groupname': data[index].groupname,
                                  });
                            },
                            child: CardBox(
                              name: data[index].groupname,
                              boxColor: data[index].groupcolor == null
                                  ? primaryClr
                                  : StringToColor(data[index].groupcolor),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        );
                }));
          }
        }
        return const DataLoading();
      },
    );
  }

  FutureBuilder<Object?> myProfileCard(User? firebaseUser) {
    return FutureBuilder(
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
            var data = snapshot.data as List;

            //Color myColor = data.color as Color;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return data.isNotEmpty
                      ? SingleChildScrollView(
                          child: GestureDetector(
                          onTap: () {
                            print(data[index].groupid);
                            Navigator.pushReplacementNamed(
                                context, '/sharedspace',
                                arguments: {
                                  'groupid': data[index].groupid,
                                  'groupname':
                                      '${data[index].firstname!} ${data[index].surname!}'
                                });
                          },
                          child: CardBox(
                            name:
                                '${data[index].firstname!} ${data[index].surname!}',
                            boxColor: data[index].color == null
                                ? primaryClr
                                : StringToColor(data[index].color),
                          ),
                        ))
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        );
                }));
          }
        }

        return const DataLoading();
      },
    );
  }
}
