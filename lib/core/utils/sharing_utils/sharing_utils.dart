
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SharingUtils {
  // Future<bool> sendEmail(
  //     {required List<String> emailReceivers,
  //     required String body,
  //     required String subject,
  //     required List<String> emailCC,
  //     required List<String> emailBCC,
  //     List<String>? attachmentPaths}) async {
  //   final Email email = Email(
  //     body: body,
  //     subject: subject,
  //     recipients: emailReceivers,
  //     cc: emailCC,
  //     bcc: emailBCC,
  //     attachmentPaths: attachmentPaths,
  //     isHTML: false,
  //   );
  //
  //   try {
  //     await FlutterEmailSender.send(email);
  //     return true;
  //   } catch (error) {
  //     log(
  //       error.toString(),
  //       name: 'send email errot: ',
  //     );
  //     return false;
  //   }
  // }

  sendSmsMessage({required String phoneNumber}) {
    launch(
      'sms:$phoneNumber',
    );
  }

  phoneCall({required String phoneNumber}) {
    launch(
      'tel:$phoneNumber',
    );
  }

  Future<bool?> launchURL({required String url}) async {
    if (await canLaunch(url)) {
      return await launch(url, forceSafariVC: false);
    } else {
      return null;
      // throw 'Could not launch $url';
    }
  }

  // Future<String?> shareToSystem({required String msg}) async {
  //   return await FlutterShareMe().shareToSystem(msg: msg);
  // }

  Future<void>? shareToSystem({required String msg}) async {
    print('msg : $msg');
    try {
      return await Share.share(msg);
    } catch (e) {
      return null;
    }
  }
}
