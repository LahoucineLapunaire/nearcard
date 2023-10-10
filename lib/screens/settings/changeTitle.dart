import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangeTitleScreen extends StatelessWidget {
  const ChangeTitleScreen({super.key});

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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 56,
                      ),
                      DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          child: TitleSection()),
                      SizedBox(
                        height: 24,
                      ),
                      DelayedDisplay(
                          delay: Duration(milliseconds: 700),
                          child: FormSection(
                              context: context,
                              state: state as SettingsLoaded)),
                      SizedBox(
                        height: 16,
                      ),
                      DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          child: ButtonSection(
                              context: context,
                              state: state as SettingsLoaded)),
                    ],
                  ),
                ),
              ),
            );
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
            child: FaIcon(FontAwesomeIcons.userTie,
                size: 60, color: Colors.black)),
        SizedBox(
          height: 16,
        ),
        Text(
          'Titre',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'Veuillez saisir votre Titre ou Votre Poste',
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
    return Container(
      width: 300,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Titre',
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
              state.titleController.text = value;
            },
            controller: state.titleController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.work),
              hintText: 'Titre',
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ]),
    );
  }
}

class ButtonSection extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const ButtonSection({super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
        Container(
          height: 40,
          child: ElevatedButton(
              onPressed: () {
                state.titleController.text.isNotEmpty
                    ? context.read<SettingsBloc>().add(
                        SettingsEventChangeUserinfo(
                            field: 'title',
                            value: state.titleController.text,
                            context: context))
                    : displayError(context, 'Veuillez saisir votre Titre');
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff001f3f)),
              ),
              child: const Text(
                'Suivant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
