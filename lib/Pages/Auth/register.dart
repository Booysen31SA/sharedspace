import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Services/auth.dart';
import 'package:sharedspace/Widgets/roundedInputField.dart';
import 'package:sharedspace/Widgets/textFieldContainer.dart';

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
          title: const Text('Email'),
          content: Center(
            child: stepOne(),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Basic Information'),
          content: const Center(
            child: Text('Basic Information'),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Security'),
          content: const Center(
            child: Text('Security'),
          ),
        )
      ];

  // Controllers
  String? errorMessage;
  String? emailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              header(context),
              stepForm(),
            ],
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
                    fontSize: 26,
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

  stepForm() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: const ColorScheme.light(primary: Colors.orange),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
      ),
      child: Stepper(
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: currentStep,
        onStepTapped: (step) => setState(() {
          currentStep = step;
        }),
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          if (currentStep == 0) {
            if (validation()) {
              _auth.isEmailChecked(emailController);
              // more validataion
            }
          }
          if (isLastStep) {
            if (errorMessage == null) {
              print('Completed');
              _auth.registerWithEmailAndPassword(emailController, 'password');
            } else {
              print('Add error message in last step');
            }
          }
          if (currentStep < (getSteps().length - 1) && validation() == true) {
            setState(() {
              currentStep += 1;
            });
          }
        },
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
                      child: const Text('Back'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  stepOne() {
    return Column(
      children: [
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
        errorMessage == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
      ],
    );
  }

  bool validation() {
    var isCorrect = true;
    if (emailController == null) {
      setState(() {
        errorMessage = 'Please Provide a valid Email';
      });
      return false;
    }

    if (!emailController!.contains('@') || !emailController!.contains('.com')) {
      setState(() {
        errorMessage = 'Email is not a valid email';
      });
      return false;
    }
    return isCorrect;
  }
}
