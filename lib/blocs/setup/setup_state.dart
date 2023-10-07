part of 'setup_bloc.dart';

@immutable
sealed class SetupState {}

final class SetupInitial extends SetupState {
  List<Widget> pages = [
    NameSetup(),
    TitleSetup(),
    CompanySetup(),
    ContactSetup(),
    SocialSetup(),
    PictureSetup(),
    ColorSetup(),
    FinishSetup(),
  ];
  int currentPage = 0;

  TextEditingController nameController;
  TextEditingController prenameController;
  TextEditingController titleController;
  TextEditingController companyController;
  TextEditingController numberController;
  TextEditingController addressController;
  TextEditingController linkedinController;
  TextEditingController websiteController;
  String picture;
  String bgColor;
  String textColor;

  SetupInitial({
    required this.currentPage,
    required this.nameController,
    required this.prenameController,
    required this.titleController,
    required this.companyController,
    required this.numberController,
    required this.addressController,
    required this.linkedinController,
    required this.websiteController,
    required this.picture,
    required this.bgColor,
    required this.textColor,
  });

  SetupInitial copyWith({
    int? currentPage,
    TextEditingController? nameController,
    TextEditingController? prenameController,
    TextEditingController? titleController,
    TextEditingController? companyController,
    TextEditingController? numberController,
    TextEditingController? addressController,
    TextEditingController? linkedinController,
    TextEditingController? websiteController,
    String? picture,
    String? bgColor,
    String? textColor,
    bool? isCardLarge,
  }) {
    return SetupInitial(
      currentPage: currentPage ?? this.currentPage,
      nameController: nameController ?? this.nameController,
      prenameController: prenameController ?? this.prenameController,
      titleController: titleController ?? this.titleController,
      companyController: companyController ?? this.companyController,
      numberController: numberController ?? this.numberController,
      addressController: addressController ?? this.addressController,
      linkedinController: linkedinController ?? this.linkedinController,
      websiteController: websiteController ?? this.websiteController,
      picture: picture ?? this.picture,
      bgColor: bgColor ?? this.bgColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
