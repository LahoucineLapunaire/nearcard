import 'dart:io';
import 'package:NearCard/blocs/setup/setup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColorSetup extends StatelessWidget {
  const ColorSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupInitial>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Color(int.parse(state.bgColor)),
        body: Column(
          children: [
            CardSection(context: context, state: state),
            ColorSection(context: context, state: state),
          ],
        ),
      );
    });
  }
}

class CardSection extends StatelessWidget {
  final BuildContext context;
  final SetupInitial state;

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
                      ? Center(
                          child: FaIcon(
                            FontAwesomeIcons.userPlus,
                            size: 40,
                            color: Color(int.parse(state.textColor)),
                          ),
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
              "${state.nameController.text} ${state.prenameController.text}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(int.parse(state.textColor)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              state.titleController.text,
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
              state.companyController.text,
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
  final SetupInitial state;

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
                              context.read<SetupBloc>().add(
                                  SetupEventChangeBgColor(
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
                              context.read<SetupBloc>().add(
                                  SetupEventChangeTextColor(
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
            const ButtonSection(),
          ],
        ),
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
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
                    context
                        .read<SetupBloc>()
                        .add(SetupEventChange(state.currentPage - 1));
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
                    context
                        .read<SetupBloc>()
                        .add(SetupEventChange(state.currentPage + 1));
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
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        );
      },
    );
  }
}
