import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Services/auth.dart';
import 'package:sharedspace/Widgets/roundedInputField.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

final AuthService _auth = AuthService();

class _RegisterState extends State<Register> {
  int currentStep = 0;

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text(
            'Email',
            style: stepHeadding,
          ),
          content: stepOne(),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(
            'Basic Information',
            style: stepHeadding,
          ),
          content: stepTwo(),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text(
            'Security',
            style: stepHeadding,
          ),
          content: stepThree(),
        )
      ];

  // Controllers
  String? emailErrorMessage;
  String? emailController;

  String? firstNameController;
  String? firstNameErrorMessage;

  String? surnameErrorMessage;
  String? surnameController;

  String? passwordErrorMessage;
  String? passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(context),
                stepForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account ? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/signin');
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: primaryClr,
                          fontWeight: FontWeight.bold,
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

  header(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            left: 20,
          ),
          child: Row(
            children: [
              const Text(
                "Shared",
                style: TextStyle(
                  fontSize: 26,
                  color: primaryClr,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                decoration: const BoxDecoration(
                  color: primaryClr,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: const Text(
                  "Space",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  stepForm() {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(primary: primaryClr),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
            ),
      ),
      child: Stepper(
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: currentStep,
        onStepTapped: (step) => setState(() {
          currentStep = step;
        }),
        onStepContinue: onStepContinue,
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep -= 1;
            });
          }
        },
        controlsBuilder: (context, ControlsDetails controls) {
          final isLastStep = currentStep == getSteps().length - 1;
          return Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controls.onStepContinue,
                    child: Text(isLastStep ? 'CONTINUE' : 'NEXT'),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                if (currentStep > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controls.onStepCancel,
                      child: const Text('BACK'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  void onStepContinue() {
    final isLastStep = currentStep == getSteps().length - 1;
    bool canContinue = false;

    if (currentStep == 0) {
      if (emailValidation()) {
        _auth.isEmailChecked(emailController);
        canContinue = true;
      }
    }
    if (currentStep == 1) {
      if (firstNameValidation() && surnameValidation()) {
        canContinue = true;
      } else {
        canContinue = false;
      }
    }

    if (currentStep == 2) {
      if (passwordValidation()) {
        canContinue = true;
      } else {
        canContinue = false;
      }
    }
    if (isLastStep && canContinue == true) {
      _auth.registerWithEmailAndPassword(emailController, passwordController,
          firstNameController, surnameController);
    }
    if (currentStep < (getSteps().length - 1) && canContinue == true) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  stepOne() {
    return Column(
      children: [
        RoundedInputField(
          isBorder: true,
          hintText: 'Email',
          IconData: const Icon(
            Icons.email,
            color: primaryClr,
          ),
          onChanged: (value) {
            setState(() {
              emailErrorMessage = null;
              emailController = value;
            });
          },
        ),
        emailErrorMessage == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  emailErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
      ],
    );
  }

  stepTwo() {
    return Column(
      children: [
        firstName(),
        surname(),
      ],
    );
  }

  stepThree() {
    return Column(
      children: [
        RoundedInputField(
          isBorder: true,
          hintText: 'Password',
          IconData: const Icon(
            Icons.lock,
            color: primaryClr,
          ),
          onChanged: (value) {
            setState(() {
              passwordErrorMessage = null;
              passwordController = value;
            });
          },
        ),
        passwordErrorMessage == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  passwordErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
      ],
    );
  }

  firstName() {
    return Column(
      children: [
        RoundedInputField(
          isBorder: true,
          hintText: 'First Name',
          IconData: const Icon(
            Icons.person,
            color: primaryClr,
          ),
          onChanged: (value) {
            setState(() {
              firstNameErrorMessage = null;
              firstNameController = value;
            });
          },
        ),
        firstNameErrorMessage == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  firstNameErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
      ],
    );
  }

  surname() {
    return Column(
      children: [
        RoundedInputField(
          isBorder: true,
          hintText: 'Surname',
          IconData: const Icon(
            Icons.person,
            color: primaryClr,
          ),
          onChanged: (value) {
            setState(() {
              surnameErrorMessage = null;
              surnameController = value;
            });
          },
        ),
        surnameErrorMessage == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  surnameErrorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
      ],
    );
  }

  bool emailValidation() {
    var isCorrect = true;
    if (emailController == null) {
      setState(() {
        emailErrorMessage = 'Please Provide a valid Email';
      });
      return false;
    }

    if (!emailController!.contains('@') || !emailController!.contains('.com')) {
      setState(() {
        emailErrorMessage = 'Email is not a valid email';
      });
      return false;
    }
    return isCorrect;
  }

  bool firstNameValidation() {
    if (firstNameController == null) {
      setState(() {
        firstNameErrorMessage = 'Please enter your first name';
      });
      return false;
    }
    return true;
  }

  bool surnameValidation() {
    if (surnameController == null) {
      setState(() {
        surnameErrorMessage = 'Please enter your surname';
      });
      return false;
    }
    return true;
  }

  bool passwordValidation() {
    if (passwordController == null || passwordController!.length < 6) {
      setState(() {
        passwordErrorMessage = 'Password needs to be greater than 6 character';
      });
    }
    return true;
  }
}
