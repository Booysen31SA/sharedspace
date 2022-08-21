import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Services/auth.dart';
import 'package:sharedspace/Widgets/roundedInputField.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String? emailController;
  String? passwordController;
  String? errorMessage = null;
  bool passText = true;
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    bool validation() {
      var isCorrect = true;
      if (emailController == null || passwordController == null) {
        setState(() {
          errorMessage = 'Please Provide a Eamil and Password';
        });
        return false;
      }
      if (emailController == '' || passwordController == '') {
        setState(() {
          errorMessage = 'Please Provide a Eamil and Password';
        });
        return false;
      }

      if (!emailController!.contains('@') ||
          !emailController!.contains('.com')) {
        setState(() {
          errorMessage = 'Email is not a valid email';
        });
        return false;
      }

      if (passwordController!.length < 6) {
        setState(() {
          errorMessage = 'Password Must be longer than 6 characters';
        });
        return false;
      }
      return isCorrect;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: Duration(seconds: 1), curve: Curves.ease);
      //.then((value) async {
      // await Future.delayed(Duration(seconds: 2));
      // _controller.animateTo(_controller.position.minScrollExtent,
      //     duration: Duration(seconds: 1), curve: Curves.ease);
    });

    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 80),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                //header(context),
                // const SizedBox(
                //   height: 25,
                // ),
                // const Center(
                //   child: Text(
                //     'WELCOME',
                //     style: loginFormHeaders,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Center(
                //   child: Text(
                //     'TO',
                //     style: loginFormHeaders,
                //   ),
                // ),

                header(context),
                const SizedBox(
                  height: 50,
                ),
                TextFieldContainer(
                  child: RoundedInputField(
                    hintText: 'Email',
                    IconData: const Icon(
                      Icons.person,
                      color: primaryLightClr,
                    ),
                    onChanged: (value) {
                      setState(() {
                        errorMessage = null;
                        emailController = value;
                      });
                    },
                  ),
                ),
                TextFieldContainer(
                  child: RoundedInputField(
                    obscureText: passText,
                    hintText: 'Password',
                    IconData: const Icon(
                      Icons.lock,
                      color: primaryLightClr,
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility,
                      color: primaryLightClr,
                    ),
                    onChanged: (value) {
                      setState(() {
                        errorMessage = null;
                        passwordController = value;
                      });
                    },
                  ),
                ),
                errorMessage == null
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29),
                    color: Colors.red,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                    onPressed: () {
                      var isCorrect = validation();
                      if (isCorrect) {
                        _auth.emailAndPasswordSignIn(
                            emailController, passwordController);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 40,
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Dont't have an Account ? ",
                      style: TextStyle(color: primaryLightClr),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/register');
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: primaryLightClr,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: <Widget>[
                      divider(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: primaryLightClr,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      divider(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: primaryLightClr,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _auth.googleSignIn();
                        },
                        child: SvgPicture.asset(
                          'images/socialMediaSVG/google.svg',
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded divider() {
    return const Expanded(
      child: Divider(
        color: Color(0xFFD90909),
        height: 1.5,
      ),
    );
  }

  header(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 45,
            left: 20,
          ),
          child: Row(
            children: [
              const Text(
                "Shared",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: const Text(
                  "Space",
                  style: TextStyle(
                    fontSize: 45,
                    color: primaryClr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 1,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(29),
        ),
        child: child);
  }
}
