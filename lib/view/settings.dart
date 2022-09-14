import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/colorPicker.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/components/loading.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';
import 'package:sharedspace/models/sharedspacegroup.dart';
import 'package:sharedspace/services/functions.dart';
import 'package:sharedspace/services/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sharedspace/util/convertStringToColor.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  var isDarkMode = Get.isDarkMode;
  //Form Key
  final _groupSettingFormKey = GlobalKey<FormBuilderState>();
  final _groupSettingGroupNameFieldKey = GlobalKey<FormBuilderState>();
  final _groupSettingGroupIDFieldKey = GlobalKey<FormBuilderState>();
  var __groupSettingGroupColorFieldKey;
  final _groupSettingUserUidFieldKey = GlobalKey<FormBuilderState>();
  final _groupSettingDateCreatedFieldKey = GlobalKey<FormBuilderState>();

  bool isReloading = false;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    //print(arguments['isMain']);
    //'groupid': arguments['groupid']

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(
              prefixIcon: GestureDetector(
                onTap: () => {
                  if (arguments['isMain'])
                    {
                      Navigator.pushReplacementNamed(context, '/home'),
                    }
                  else
                    {
                      Navigator.pushReplacementNamed(context, '/sharedspace',
                          arguments: {
                            'groupid': arguments['groupid'],
                            'groupname': arguments['groupname'],
                          }),
                    }
                },
                child: Icon(backArrow, color: primaryClr),
              ),
              heading: Text(
                arguments['isMain'] ? 'Settings' : 'Group Settings',
                style: const TextStyle(
                  fontSize: 26,
                  color: primaryClr,
                ),
              ),
            ),
            arguments['isMain']
                ? mainSettings(firebaseUser)
                : groupSettings(firebaseUser, arguments['groupid']),
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
              Text(
                'Dark Mode',
                style: settingSizes,
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

  groupSettings(firebaseUser, groupid) {
    // Group Color
    // Group admin read only
    // date created read only
    // users in group do last
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          top: 15,
          left: 15,
        ),
        child: FutureBuilder(
          future: getSharedSpaceDetailsByGroupId(groupid),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                var data = snapshot.data as SharedSpaceGroup;
                if (!isReloading) {
                  __groupSettingGroupColorFieldKey =
                      stringToColor(data.groupcolor.toString());
                }
                return FormBuilder(
                  key: _groupSettingFormKey,
                  child: Column(
                    children: <Widget>[
                      // Group id
                      nameTextBox(
                        text: 'Group ID',
                        key: _groupSettingGroupIDFieldKey,
                        data: data.groupid.toString(),
                        readOnly: true,
                      ),
                      // Group Name
                      nameTextBox(
                        text: 'Group Name',
                        key: _groupSettingGroupNameFieldKey,
                        data: data.groupname.toString(),
                      ),

                      // Colour Picker
                      Container(
                        margin: const EdgeInsets.only(top: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Change Color',
                              style: settingSizes,
                            ),
                            GestureDetector(
                              onTap: () {
                                colorPicker(
                                  context: context,
                                  color: __groupSettingGroupColorFieldKey,
                                  onPress: changeColorOnTap,
                                  onChange: changeColor,
                                );
                              },
                              child: SizedBox(
                                width: 260,
                                height: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: __groupSettingGroupColorFieldKey,
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Created User
                      nameTextBox(
                        text: 'Created by',
                        key: _groupSettingUserUidFieldKey,
                        data: data.useruid,
                        readOnly: true,
                      ),

                      // Date Created
                      nameTextBox(
                        text: 'Date Created',
                        key: _groupSettingDateCreatedFieldKey,
                        data: data.datecreated.toString(),
                        readOnly: true,
                      ),
                    ],
                  ),
                );

                //return Text(data.groupname.toString());
              }
            }
            return const DataLoading();
          }),
        ),
      ),
    );
  }

  nameTextBox({text, key, data, readOnly}) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: settingSizes,
          ),
          SizedBox(
            width: 260,
            child: FormBuilderTextField(
              readOnly: readOnly ?? false,
              key: key,
              name: text,
              initialValue: data,
              decoration: inputDecoration(
                borderColor: primaryClr,
                isfocusBorder: true,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void changeColorOnTap() {
    setState(() {
      __groupSettingGroupColorFieldKey = __groupSettingGroupColorFieldKey;
    });
    Navigator.of(context).pop();
  }

  void changeColor(Color color) {
    isReloading = true;
    setState(() => {__groupSettingGroupColorFieldKey = color});
  }
}
