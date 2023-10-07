import 'package:NearCard/blocs/setup/setup_bloc.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:NearCard/widgets/breadcrumb.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class ContactSetup extends StatelessWidget {
  const ContactSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 56,
                ),
                StepperBreadcrumbs(currentStep: state.currentPage),
                SizedBox(
                  height: 32,
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: 500), child: TitleSection()),
                SizedBox(
                  height: 24,
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: 700), child: FormSection()),
                SizedBox(
                  height: 16,
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: 500), child: ButtonSection()),
              ],
            ),
          ),
        );
      },
    ));
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
            child: FaIcon(FontAwesomeIcons.solidAddressBook,
                size: 60, color: Colors.black)),
        SizedBox(
          height: 16,
        ),
        Text(
          'Contact',
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
          'Veuillez saisir votre numéro de téléphone et votre adresse',
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

TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue) {
  final text = newValue.text.replaceAll(RegExp(r'\D'), '');
  final buffer = StringBuffer();
  if (text.length > 2) {
    buffer.write('${text.substring(0, 2)} ');
    if (text.length > 4) {
      buffer.write('${text.substring(2, 4)} ');
      if (text.length > 6) {
        buffer.write('${text.substring(4, 6)} ');
        if (text.length > 8) {
          buffer.write('${text.substring(6, 8)} ');
          if (text.length > 10) {
            buffer.write('${text.substring(8, 10)}');
          } else {
            buffer.write('${text.substring(8)}');
          }
        } else {
          buffer.write('${text.substring(6)}');
        }
      } else {
        buffer.write('${text.substring(4)}');
      }
    } else {
      buffer.write('${text.substring(2)}');
    }
  } else {
    buffer.write(text);
  }
  return TextEditingValue(
    text: buffer.toString(),
    selection: TextSelection.collapsed(offset: buffer.length),
  );
}

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupBloc, SetupInitial>(
      builder: (context, state) {
        return Container(
          width: 300,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Telephone',
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
                controller: state.numberController,
                onChanged: (value) {
                  state.numberController.value = formatEditUpdate(
                      state.numberController.value,
                      TextEditingValue(text: value));
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Telephone',
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
              height: 16,
            ),
            const Text(
              'Adresse (optionnel)',
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
                controller: state.addressController,
                onTap: () async {
                  try {
                    final predictions = await PlacesAutocomplete.show(
                        region: "fr",
                        offset: 0,
                        mode: Mode.fullscreen,
                        hint: "Search",
                        radius: 1000,
                        types: [],
                        strictbounds: false,
                        context: context,
                        apiKey: "AIzaSyADw6o3DRaFrF_gdtpEtn_HM6PYhVQnNi8",
                        language: "fr",
                        components: [Component(Component.country, "fr")]);
                    state.addressController.text = predictions!.description!;
                  } catch (e) {
                    print(e);
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Adresse',
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
      },
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
                border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
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
            Container(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    if (state.numberController.text.isNotEmpty &&
                        state.addressController.text.isNotEmpty) {
                      context
                          .read<SetupBloc>()
                          .add(SetupEventChange(state.currentPage + 1));
                    } else {
                      displayError(context, "Veuillez remplir tous les champs");
                    }
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
