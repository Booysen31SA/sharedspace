import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

int currentStep = 0;
int maxStep = getSteps().length - 1;
final AuthService _auth = AuthService();

List<Step> getSteps() => [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text('Email'),
        content: const Center(
          child: Text('Email Address'),
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

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Column(
          children: [
            header(context),
            stepForm(),
          ],
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
            print('Email Check');
          }
          if (isLastStep) {
            print('Completed');
            _auth.registerWithEmailAndPassword('email', 'password');
          }
          if (currentStep < maxStep) {
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
}
