import 'package:NearCard/screens/setup/colorSetup.dart';
import 'package:NearCard/screens/setup/companySetup.dart';
import 'package:NearCard/screens/setup/contactSetup.dart';
import 'package:NearCard/screens/setup/finishSetup.dart';
import 'package:NearCard/screens/setup/nameSetup.dart';
import 'package:NearCard/screens/setup/pictureSetup.dart';
import 'package:NearCard/screens/setup/socialSetup.dart';
import 'package:NearCard/screens/setup/titleSetup.dart';
import 'package:NearCard/widgets/alert.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupInitial> {
  SetupBloc()
      : super(SetupInitial(
          currentPage: 0,
          nameController: TextEditingController(),
          prenameController: TextEditingController(),
          titleController: TextEditingController(),
          companyController: TextEditingController(),
          numberController: TextEditingController(),
          addressController: TextEditingController(),
          linkedinController: TextEditingController(),
          websiteController: TextEditingController(),
          picture: "",
          bgColor: "0xff000000",
          textColor: "0xffffffff",
        )) {
    on<SetupEvent>((event, emit) async {
      if (event is SetupEventChange) {
        emit(state.copyWith(
          currentPage: event.page,
        ));
      }
      if (event is SetupEventTakePicture) {
        final ImagePicker picker = ImagePicker();
        // Pick an image.
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          emit(state.copyWith(
            picture: image.path,
          ));
        } else {
          displayError(event.context, "Veuillez choisir une image");
        }
      }
      if (event is SetupEventChangeBgColor) {
        emit(state.copyWith(
          bgColor: "0x" + event.color,
        ));
      }
      if (event is SetupEventChangeTextColor) {
        emit(state.copyWith(
          textColor: "0x" + event.color,
        ));
      }
    });
  }
}
