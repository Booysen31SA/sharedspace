import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';
import 'package:sharedspace/services/services.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  var isDarkMode = Get.isDarkMode;
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments['isMain']);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(
              prefixIcon: GestureDetector(
                onTap: () => {
                  Navigator.pushReplacementNamed(context, '/home'),
                },
                child: Icon(backArrow, color: primaryClr),
              ),
              heading: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 26,
                  color: primaryClr,
                ),
              ),
            ),
            arguments['isMain']
                ? mainSettings(firebaseUser)
                : groupSettings(firebaseUser),
          ],
        ),
      ),
    );
  }

  userDetails(firebaseUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('uuid',
                style: TextStyle(
                  fontSize: 20,
                )),
            Text(
              firebaseUser == null
                  ? 'User is not logged in'
                  : firebaseUser.uid.toString(),
              style: const TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Email',
                style: TextStyle(
                  fontSize: 20,
                )),
            Text(
                firebaseUser == null
                    ? 'User is not logged in'
                    : firebaseUser.email.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ))
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }

  mainSettings(firebaseUser) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dark Mode',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    ThemeService().switchTheme();
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  userDetails(firebaseUser),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.red)),
                    child: MaterialButton(
                      onPressed: () async {
                        await context
                            .read<FlutterFireAuthService>()
                            .signOut(context: context);

                        Navigator.popAndPushNamed(context, '/');
                      },
                      child: const Text(
                        'LogOut',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  groupSettings(firebaseUser) {
    // Group name
    // Group Color
    //Group id read only
    // Group admin read only
    // date created read only
    // users in group
    return Container(
      child: const Center(
        child: Text('Group Setting'),
      ),
    );
  }
}
