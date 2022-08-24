import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Services/auth.dart';
import 'package:sharedspace/Services/service.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

final AuthService _auth = AuthService();

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(children: [
            header(
              context,
              'Settings',
              primaryClr,
            ),
            mainSettings(context),
          ]),
        ),
      ),
    );
  }
}

header(context, name, spaceColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () => {
          Get.back(),
        },
        child: Row(
          children: [
            Icon(
              backArrow,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '$name',
              style: TextStyle(
                fontSize: 26,
                color: spaceColor,
              ),
            ),
          ],
        ),
      )
    ],
  );
}

mainSettings(context) {
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
            Switch.adaptive(
              value: Get.isDarkMode,
              onChanged: (value) => {
                ThemeService().switchTheme(),
              },
            )
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
                TextButton(
                  onPressed: () => null,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  child: const Text('Delete Account'),
                ),
                TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  child: const Text('Log Out'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
