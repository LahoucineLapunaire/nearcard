import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          DropdownButton<String>(
            value: 'Option 1', // La valeur actuellement sélectionnée
            onChanged: (String? newValue) {
              // Fonction appelée lorsque l'utilisateur change la sélection
              // Vous pouvez mettre à jour l'état ici en fonction de la sélection
              print(newValue);
            },
            items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const UserInfoSection(),
          const SizedBox(height: 16),
          const NotificationSection(),
          const SizedBox(height: 16),
          const SupportSection(),
          const SizedBox(height: 16),
          const LegalSection(),
          const SizedBox(height: 16),
          const LogoutSection(),
        ],
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('User Info'),
        const SizedBox(height: 8),
        const Placeholder(),
      ],
    );
  }
}

class NotificationSection extends StatelessWidget {
  const NotificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Notifications'),
        const SizedBox(height: 8),
        const Placeholder(),
      ],
    );
  }
}

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Support'),
        const SizedBox(height: 8),
        const Placeholder(),
      ],
    );
  }
}

class LegalSection extends StatelessWidget {
  const LegalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Legal'),
        const SizedBox(height: 8),
        const Placeholder(),
      ],
    );
  }
}

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(children: [
        const Icon(Icons.logout),
        const SizedBox(width: 8),
        const Text('Logout'),
      ]),
    );
  }
}
