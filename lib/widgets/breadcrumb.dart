import 'package:flutter/material.dart';

class StepperBreadcrumbs extends StatelessWidget {
  final List<String> steps = [
    'Nom',
    'Titre',
    'Entreprise',
    'Contact',
    'Social',
    'Image',
    'Couleur',
  ];
  final int currentStep;

  StepperBreadcrumbs({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isActive = index == currentStep;

          return Column(
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? const Color(0xff001f3f) : Colors.grey,
                ),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isActive)
                Text(
                  step,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
