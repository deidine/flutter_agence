library contactus;

import 'package:flutter/material.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

///Class for adding contact details/profile details as a complete new page in your flutter app.
class ContactUs extends StatelessWidget {
  ///Logo of the Company/individual
  final ImageProvider? logo;

  ///Ability to add an image
  final Image? image;

  ///Phone Number of the company/individual
  final String? phoneNumber;

  ///Text for Phonenumber
  final String? phoneNumberText;

  ///Name of the Company/individual
  final String companyName;

  ///Font size of Company name
  final double? companyFontSize;

  ///TagLine of the Company or Position of the individual
  final String? tagLine;

  ///TextColor of the text which will be displayed on the card.
  final Color textColor;

  ///Color of the Card.
  final Color cardColor;

  ///Color of the company/individual name displayed.
  final Color companyColor;

  ///Color of the tagLine of the Company/Individual to be displayed.
  final Color taglineColor;

  /// font of text
  final String? textFont;

  /// font of the company/individul to be displayed
  final String? companyFont;

  /// font of the tagline to be displayed
  final String? taglineFont;

  /// divider color which is placed between the tagline & contact informations
  final Color? dividerColor;

  /// divider thickness which is placed between the tagline & contact informations

  final double? dividerThickness;

  ///font weight for tagline and company name
  final FontWeight? companyFontWeight;
  final FontWeight? taglineFontWeight;

  /// avatar radius will place the circularavatar according to developer/UI need
  final double? avatarRadius;

  ///Constructor which sets all the values.
  ContactUs({
    required this.companyName,
    required this.textColor,
    required this.cardColor,
    required this.companyColor,
    required this.taglineColor,
    // required this.email,
    // this.emailText,
    this.logo,
    this.image,
    this.phoneNumber,
    this.phoneNumberText,
    this.tagLine,
    this.companyFontSize,
    this.textFont,
    this.companyFont,
    this.taglineFont,
    this.dividerColor,
    this.companyFontWeight,
    this.taglineFontWeight,
    this.avatarRadius,
    this.dividerThickness, String email = "cv",
  });

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 8.0,
          contentPadding: const EdgeInsets.all(18.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => launch('tel:' + phoneNumber!),
                  child: Container(
                    height: 50.0,
                    alignment: Alignment.center,
                    child: const Text('Call'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () => launch('sms:' + phoneNumber!),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: const Text('Message'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () => launch('https://wa.me/' + phoneNumber!),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: const Text('WhatsApp'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: logo != null,
                child: CircleAvatar(
                  radius: avatarRadius ?? 50.0,
                  backgroundImage: logo,
                ),
              ),
              Visibility(
                  visible: image != null, child: image ?? const SizedBox.shrink()),
              Text(
                companyName,
                style: TextStyle(
                  fontFamily: companyFont ?? 'Pacifico',
                  fontSize: companyFontSize ?? 40.0,
                  color: companyColor,
                  fontWeight: companyFontWeight ?? FontWeight.bold,
                ),
              ),
              Visibility(
                visible: tagLine != null,
                child: Text(
                  tagLine ?? "",
                  style: TextStyle(
                    fontFamily: taglineFont ?? 'Pacifico',
                    color: taglineColor,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    fontWeight: taglineFontWeight ?? FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Divider(
                color: dividerColor ?? Colors.teal[200],
                thickness: dividerThickness ?? 4.0,
                indent: 50.0,
                endIndent: 50.0,
              ),
              const SizedBox(
                height: 10.0,
              ),

              Visibility(
                visible: phoneNumber != null,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Typicons.phone),
                    title: Text(
                      phoneNumberText ?? 'Phone Number',
                      style: TextStyle(
                        color: textColor,
                        fontFamily: textFont,
                      ),
                    ),
                    onTap: () => showAlert(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


