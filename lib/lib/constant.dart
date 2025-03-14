import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///COLORS
const Color appbarGreyColor = Color.fromRGBO(224, 225, 221, 1);
const Color black = Colors.black;
const Color white = Colors.white;
const Color grey = Colors.grey;
const Color primary = Color.fromRGBO(19, 141, 71, 1);
const Color green = Color.fromRGBO(106, 184, 127, 1);
const Color greenLight = Color.fromRGBO(130, 229, 156, 1);
const Color darkGreen = Color.fromRGBO(0, 94, 25, 1);
const Color orange = Colors.orange;
const Color red = Color.fromARGB(255, 204, 65, 55);
const Color yellow = Colors.lime;

/// FONTS SIZE
const textSizeSmall = 6.0;
const textSizeSMedium = 8.0;
const textSizeMedium = 11.0;
const textSizeLargeMedium = 14.0;
const textSizeNormal = 18.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 31.0;
const textSizeXXLarge = 41.0;
const textSizeXXXLarge = 53.0;

///DateTime
DateFormat formatTime = DateFormat('d MMMM yyyy à H:mm', "fr");
DateFormat formatTimeAchive = DateFormat('MMMM yyyy', "fr");
DateFormat dateFormatTime = DateFormat('d MMMM yyyy à H:mm', "fr");
DateFormat dateFormatShortDayList = DateFormat('E', 'fr');

DateFormat dateFormatSearch = DateFormat('d MMMM yyyy', "fr");

///PADDING
const paddingSmall = 2.0;
const paddingSMedium = 8.0;
const paddingMedium = 11.0;
const paddingLargeMedium = 14.0;
const paddingNormal = 18.0;
const paddingLarge = 24.0;
const paddingXLarge = 31.0;
const paddingXXLarge = 41.0;
const paddingXXXLarge = 53.0;

/// Border radius
const double borderRadius = 15;

///Name of table
const procesVerbalTable = "proces_verbal";
const procesVerbalWithUsersTable = "proces_verbal_with_user";
const userTable = "users";

///Name of stockage
const bucket = "proces_verbal";

///Name of document stored for verbal trials
const decisionPoursuiteTitle = "Décision de poursuite";
const avisInstructeurTitle = "Avis d'instructeur";
const miseEnRecouvrementTitle = "Mise en recouvrement";
const mesureDeContrainteTitle = "Mesure de contrainte";

///Name of document stored for verbal trials
const avisInstructeurFile = "avis_instructeur_file";
const clotureProcesVerbalFile = "cloture_proces_verbal_file";
const decisionPoursuiteFile = "decision_poursuite_file";
const mesureDeContrainteFile = "mesure_de_contrainte_file";
const miseEnRecouvrementFile = "mise_en_recouvrement_file";

//Images
const String backgroundImage = 'assets/images/background.gif';
const String loadingImage = 'assets/images/loading.gif';
const String logoDGDA = 'assets/images/logo_DGDA.png';
const String phoneAsset = 'assets/signUp/phone.png';
const String otpAsset = 'assets/signUp/otp.png';
const String personalDataAsset = "assets/signUp/personalData.png";
const String passwordAsset = "assets/signUp/password.png";
//Assets
String imageMan =
    "https://th.bing.com/th/id/OIP.ZNvhPEffndmncsj6ztCOzwAAAA?rs=1&pid=ImgDetMain";

//Duration
const timeToWaitBeforeAvisInstructeur =
    Duration(minutes: 2); //To be set to 15days in production
const timeToWaitBeforeMiseEnRecouvrement =
    Duration(minutes: 2); //To be set to 30days in production
const timeToWaitBeforeMesureDeContrainte =
    Duration(minutes: 2); //To be set to 30days in production

///Spacer
const spacerHeight = SizedBox(height: paddingNormal);
const spacerWidth = SizedBox(width: paddingNormal);

