import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/logo.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sharedspace/database/firebase.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // use Flutter Form Builder
  final ScrollController _controller = ScrollController();

  //Form Key
  final _signInformKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final _passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.ease);
      //.then((value) async {
      // await Future.delayed(Duration(seconds: 2));
      // _controller.animateTo(_controller.position.minScrollExtent,
      //     duration: Duration(seconds: 1), curve: Curves.ease);
    });

    // TODO: implement build
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                const Logo(),
                signInForm(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Dont't have an account ? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Divider(
                      color: Colors.white, height: 10.0, thickness: 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                socailMediaLinks()
              ],
            ),
          ),
        ),
      ),
    );
  }

  socailMediaLinks() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: primaryClr,
          ),
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: () {
            //_auth.googleSignIn();
          },
          child: SvgPicture.asset(
            'images/socialMediaSVG/google.svg',
            height: 20,
            width: 20,
            color: Colors.white,
          ),
        ),
      )
    ]);
  }

  signInForm() {
    return FormBuilder(
      key: _signInformKey,
      child: Column(
        children: <Widget>[
          FormBuilderTextField(
            key: _emailFieldKey,
            name: 'email',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
            decoration: inputDecoration(hintText: 'Email', color: Colors.white),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          FormBuilderTextField(
            key: _passwordFieldKey,
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
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.red,
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: MaterialButton(
              onPressed: () async {
                final validateSuccess =
                    _signInformKey.currentState!.saveAndValidate();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );

                if (validateSuccess) {
                  final values = _signInformKey.currentState!.value;
                  var result = await context
                      .read<FlutterFireAuthService>()
                      .signInWithEmailAndPassword(
                          email: values['email'],
                          password: values['password'],
                          context: context);
                  if (result != 'Success') {
                    _signInformKey.currentState!.invalidateField(
                        name: 'password',
                        errorText: 'Username or Password is incorrect!');
                  }
                }
              },
              child: const Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
