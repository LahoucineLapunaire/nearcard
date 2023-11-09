import 'dart:io';
import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangeColorScreen extends StatelessWidget {
  const ChangeColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return Scaffold(
              backgroundColor: Color(int.parse(state.bgColor)),
              body: Column(
                children: [
                  CardSection(context: context, state: state),
                  ColorSection(context: context, state: state),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const CardSection({super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(int.parse(state.textColor)), width: 2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: state.picture == ""
                      ? state.currentUser.picture == ""
                          ? Center(
                              child: FaIcon(
                                FontAwesomeIcons.userPlus,
                                size: 40,
                                color: Color(int.parse(state.textColor)),
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
            const SizedBox(
              height: 20,
            ),
            Text(
              "${state.currentUser.name} ${state.currentUser.prename}",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Color(int.parse(state.textColor)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              state.currentUser.title,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: Color(int.parse(state.textColor)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              state.currentUser.company,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                color: Color(int.parse(state.textColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorSection extends StatelessWidget {
  final BuildContext context;
  final SettingsLoaded state;

  const ColorSection({super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 2.0, color: Colors.black),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Couleur de fond',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return AlertDialog(
                        title: const Text(
                            'Choisissez la couleur de fond de votre carte !'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: Color(int.parse(state.textColor)),
                            onColorChanged: (value) {
                              context.read<SettingsBloc>().add(
                                  SettingsEventChangeBgColor(
                                      value.value.toRadixString(16)));
                            },
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Sélectionner'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Color(int.parse(state.bgColor)),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const SizedBox(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Couleur de texte',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return AlertDialog(
                        title: const Text(
                            'Choisissez la couleur de texte de votre carte !'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: Color(int.parse(state.textColor)),
                            onColorChanged: (value) {
                              context.read<SettingsBloc>().add(
                                  SettingsEventChangeTextColor(
                                      value.value.toRadixString(16)));
                            },
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Sélectionner'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  color: Color(int.parse(state.textColor)),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const SizedBox(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonSection(
              context: context,
              state: state,
            ),
          ],
        ),
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
                    context: context, field: "bgColor", value: state.bgColor));
                context.read<SettingsBloc>().add(SettingsEventChangeUserinfo(
                    context: context,
                    field: "textColor",
                    value: state.textColor));
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
