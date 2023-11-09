import 'dart:io';
import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangePictureScreen extends StatelessWidget {
  const ChangePictureScreen({super.key});

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
                        child: ImageSection(context: context, state: state)),
                    const SizedBox(
                      height: 24,
                    ),
                    DelayedDisplay(
                        delay: const Duration(milliseconds: 500),
                        child: ButtonSection(context: context, state: state)),
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image',
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
          'Veuillez séléctionner votre image de profil',
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

class ImageSection extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const ImageSection({super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SettingsBloc>().add(SettingsEventTakePicture(context));
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: state.picture == ""
                ? state.currentUser.picture == ""
                    ? const Center(
                        child: FaIcon(
                          FontAwesomeIcons.userPlus,
                          size: 70,
                        ),
                      )
                    : Image.network(
                        state.currentUser.picture,
                        fit: BoxFit.cover,
                      )
                : Image.file(
                    File(state.picture),
                    fit: BoxFit.cover,
                  )),
      ),
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
            border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
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
        SizedBox(
          height: 40,
          child: ElevatedButton(
              onPressed: () {
                context.read<SettingsBloc>().add(SettingsEventChangeUserinfo(
                    context: context, field: "picture", value: state.picture));
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
