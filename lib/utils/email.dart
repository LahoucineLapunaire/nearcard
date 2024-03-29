import 'package:NearCard/widgets/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

FirebaseAuth auth = FirebaseAuth.instance;

void sendSupportMessage(BuildContext context, String name, String prename,
    String object, String emailContent) async {
  try {
    // Get user preferences
    final prefs = await SharedPreferences.getInstance();
    // Retrieve SMTP key from preferences or use an empty string as default
    var smtpkey = prefs.getString('smtp_key') ?? '';
    // Define the SMTP server using Gmail
    final smtpServer = gmail('moderation.ilili@gmail.com', smtpkey);
    // Create a message
    final message = Message()
      ..from =
          Address(auth.currentUser!.email ?? "", auth.currentUser?.displayName)
      ..recipients.add('moderation.ilili@gmail.com')
      ..subject = '[Support] $object' // Subject of the email
      ..html = '''
<!DOCTYPE html>
<html>
<head>
<style>
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }
  h1 {
    color: #333333;
    font-size: 24px;
    margin-bottom: 10px;
  }
  h2 {
    color: #0066ff;
    font-size: 20px;
    margin-bottom: 10px;
  }
  p {
    color: #666666;
    font-size: 16px;
    line-height: 1.5;
  }
</style>
</head>
<body>
<h1>Support message from ${"$name $prename"} (uid: ${auth.currentUser?.uid}) (email: ${auth.currentUser?.email})</h1>
<h2>Object: $object</h2>
<p>$emailContent</p>
</body>
</html>
'''; // HTML content of the email
    // Send the email using the specified SMTP server
    await send(message, smtpServer);
    // Show a success message
    displayMessage(context, "L'émail a été envoyé avec succès");

    // Print a confirmation message to the console

    // Close the current screen or navigate back
    Navigator.pop(context);
  } catch (e) {
    // Handle any errors that occur during the email sending process
    displayError(context, "l'émail n'a pas pu être envoyé");
  }
}
