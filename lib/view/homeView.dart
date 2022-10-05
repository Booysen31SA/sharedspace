import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/card.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/components/loading.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase_helpers.dart';
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
      appBar: Header(
        appBar: AppBar(),
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
            Navigator.pushNamed(
              context,
              '/settings',
              arguments: {'isMain': true},
            ),
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      onTap: () {
                        Navigator.pushNamed(context, '/creation', arguments: {
                          'creationtitle': 'Create Shared Space',
                          'screen': 'home'
                        });
                      },
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
            myspaceStream(firebaseUser)
          ],
        ),
      ),
    );
  }

  StreamBuilder myspaceStream(User? firebaseUser) {
    return StreamBuilder(
        stream: getSpaceGroups(firebaseUser),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshots) {
          if (snapshots.hasError) {
            return Center(
              child: Text(
                '${snapshots.error} occurred',
                style: const TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshots.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.7,
              child: ListView(
                shrinkWrap: true,
                children: snapshots.data.docs.map<Widget>((groups) {
                  return SizedBox(
                    child: StreamBuilder(
                      stream: getGroupDetails(groups['groupid']),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return SizedBox(
                            child: ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children:
                                  snapshot.data.docs.map<Widget>((details) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/sharedspace',
                                        arguments: {
                                          'groupid': details['groupid'],
                                          'groupname': details['groupname'],
                                        });
                                  },
                                  child: CardBox(
                                    name: details['groupname'],
                                    boxColor: details['groupcolor'] == null
                                        ? primaryClr
                                        : stringToColor(details['groupcolor']),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }

                        return const DataLoading();
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          }

          return const DataLoading();
        });
  }

  StreamBuilder myProfileCard(User? firebaseUser) {
    return StreamBuilder(
      stream: getUserDetails(firebaseUser),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error} occurred',
              style: const TextStyle(fontSize: 18),
            ),
          );
        } else if (snapshot.hasData) {
          // var idk = snapshot.data.docs.map((document) {
          //   Map<String, dynamic> data =
          //       document.data()! as Map<String, dynamic>;
          //   print(data);
          // });

          //Color myColor = data.color as Color;
          return ListView(
            shrinkWrap: true,
            children: snapshot.data.docs.map<Widget>((document) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/sharedspace', arguments: {
                    'groupid': document['groupid'],
                    'groupname':
                        '${document['firstname']!} ${document['surname']!}',
                    'isprofile': true
                  });
                },
                child: CardBox(
                  name: '${document['firstname']!} ${document['surname']!}',
                  boxColor: document['color'] == null
                      ? primaryClr
                      : stringToColor(document['color'] as String),
                ),
              );
            }).toList(),
          );
        }

        return const DataLoading();
      },
    );
  }
}
