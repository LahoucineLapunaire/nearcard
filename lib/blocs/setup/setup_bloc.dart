import 'dart:io';

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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'setup_event.dart';
part 'setup_state.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

void sendEmailVerification() async {
  print("Sending email");

  User? user = auth.currentUser;
  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
  }
}

void firstSetup(
    BuildContext context,
    String name,
    String prename,
    String title,
    String company,
    String number,
    String address,
    String linkedin,
    String website,
    String picture,
    String bgColor,
    String textColor) async {
  String downloadURL = "";
  if (picture != "") {
    // update picture into firebase storage
    Reference imageRef;

    Reference webStorageRef =
        storage.refFromURL("gs://nearcard-fa985.appspot.com/users");
    Reference storageRef = storage.ref("users");

    if (kIsWeb) {
      // Set the image reference for web
      imageRef = webStorageRef.child("${auth.currentUser!.uid}.jpg");
    } else {
      // Set the image reference for mobile
      imageRef = storageRef.child("${auth.currentUser!.uid}.jpg");
    }
    UploadTask uploadTask;
    if (kIsWeb) {
      // Upload image data for web
      Uint8List imageData = await XFile(picture).readAsBytes();
      uploadTask = imageRef.putData(imageData);
    } else {
      // Upload image file for mobile
      uploadTask = imageRef.putFile(File(picture));
    }
    await uploadTask.whenComplete(() async {
      downloadURL = await imageRef.getDownloadURL();
    });
  }
  firestore.collection("users").doc(auth.currentUser!.uid).set({
    "name": name,
    "prename": prename,
    "title": title,
    "company": company,
    "number": number,
    "address": address,
    "linkedin": linkedin,
    "website": website,
    "picture": downloadURL,
    "bgColor": bgColor,
    "textColor": textColor,
  });
}

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
      if (event is SetupEventFirstSetup) {
        firstSetup(
          event.context,
          event.name,
          event.prename,
          event.title,
          event.company,
          event.number,
          event.address,
          event.linkedin,
          event.website,
          event.picture,
          event.bgColor,
          event.textColor,
        );
        sendEmailVerification();
      }
    });
  }
}
