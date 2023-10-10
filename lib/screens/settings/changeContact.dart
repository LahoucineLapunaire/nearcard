import 'package:NearCard/blocs/settings/settings_bloc.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class ChangeContactScreen extends StatelessWidget {
  const ChangeContactScreen({super.key});

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
                            context: context, state: state as SettingsLoaded)),
                    SizedBox(
                      height: 16,
                    ),
                    DelayedDisplay(
                        delay: Duration(milliseconds: 500),
                        child: ButtonSection(
                            context: context, state: state as SettingsLoaded)),
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
  final BuildContext context;
  final SettingsLoaded state;

  const FormSection({super.key, required this.context, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  state.numberController.value, TextEditingValue(text: value));
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
    ;
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
                print("salut");
                print(state.numberController.text);
                print(state.addressController.text);
                if (state.numberController.text.isNotEmpty) {
                  context.read<SettingsBloc>().add(SettingsEventChangeUserinfo(
                      context: context,
                      field: "number",
                      value: state.numberController.text));
                }
                if (state.addressController.text.isNotEmpty) {
                  context.read<SettingsBloc>().add(SettingsEventChangeUserinfo(
                      context: context,
                      field: "address",
                      value: state.addressController.text));
                }
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
