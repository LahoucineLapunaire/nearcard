import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return Scaffold(
                body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    const DelayedDisplay(
                        delay: Duration(milliseconds: 500),
                        child: TitleSection()),
                    const SizedBox(
                      height: 24,
                    ),
                    DelayedDisplay(
                        delay: const Duration(milliseconds: 700),
                        child: FormSection(context: context, state: state)),
                    const SizedBox(
                      height: 16,
                    ),
                    DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: ButtonSection(
                            blocContext: context, blocState: state)),
                  ],
                ),
              ),
            ));
          }
          return Container();
        },
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            child: const Icon(Icons.person, size: 60, color: Colors.black)),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Nom et Prénom',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Saisissez votre nom et prénom',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class FormSection extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const FormSection({super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Nom',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFe3e3e3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (value) {
              state.nameController.text = value.toUpperCase();
            },
            controller: state.nameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Nom',
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Prenom',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFe3e3e3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (value) {
              //set first letter to uppercase
              if (value.isNotEmpty) {
                value = value[0].toUpperCase() + value.substring(1);
              }
              state.prenameController.text = value;
            },
            controller: state.prenameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.perm_identity),
              hintText: 'Prenom',
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ]),
    );
  }
}

class ButtonSection extends StatelessWidget {
  final BuildContext blocContext;
  final SettingsLoaded blocState;

  const ButtonSection(
      {super.key, required this.blocContext, required this.blocState});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    child: const Text(
                      "Retour",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
              const SizedBox(
                width: 50,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (state.nameController.text.isEmpty &&
                        state.prenameController.text.isEmpty) {
                      displayError(
                          context, "Veuillez saisir votre nom et prénom");
                      return;
                    }
                    context.read<SettingsBloc>().add(
                        SettingsEventChangeUserinfo(
                            field: "prename",
                            value: blocState.prenameController.text,
                            context: blocContext));
                    context.read<SettingsBloc>().add(
                        SettingsEventChangeUserinfo(
                            field: "name",
                            value: blocState.nameController.text,
                            context: blocContext));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff001f3f)),
                  ),
                  child: const Text(
                    'Suivant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
