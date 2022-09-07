import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/logo.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //Form Key
  final _registerFormKey = GlobalKey<FormBuilderState>();
  final _registerEmailFieldKey = GlobalKey<FormBuilderState>();
  final _registerFirstNameFieldKey = GlobalKey<FormBuilderState>();
  final _registerLastNameFieldKey = GlobalKey<FormBuilderState>();
  final _registerPasswordFieldKey = GlobalKey<FormBuilderState>();

  var _passwordVisible = false;

  // use Flutter Form Builder
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Logo(),
                registerForm(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerForm() {
    return FormBuilder(
        key: _registerFormKey,
        child: Column(children: <Widget>[
          FormBuilderTextField(
            key: _registerEmailFieldKey,
            name: 'email',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
            decoration: inputDecoration(hintText: 'Email', color: Colors.white),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderTextField(
            key: _registerFirstNameFieldKey,
            name: 'firstname',
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()]),
            decoration:
                inputDecoration(hintText: 'First Name', color: Colors.white),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderTextField(
            key: _registerLastNameFieldKey,
            name: 'lastname',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            decoration:
                inputDecoration(hintText: 'Last Name', color: Colors.white),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderTextField(
            key: _registerPasswordFieldKey,
            obscureText: !_passwordVisible,
            name: 'password',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(6),
            ]),
            decoration: inputDecoration(
              hintText: 'Password',
              color: Colors.white,
              suffixIcon: IconButton(
                  icon: Icon(
                    // based on _passwordVisible
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.red,
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: MaterialButton(
              onPressed: () {
                final validateSuccess =
                    _registerFormKey.currentState!.saveAndValidate();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );

                if (validateSuccess) {
                  final values = _registerFormKey.currentState!.value;
                  var result = context
                      .read<FlutterFireAuthService>()
                      .signUpWithEmailAndPassword(
                          email: values['email'],
                          password: values['password'],
                          firstname: values['firstname'],
                          lastname: values['lastname'],
                          context: context);
                }
              },
              child: const Text(
                'REGISTER',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ]));
  }
}
