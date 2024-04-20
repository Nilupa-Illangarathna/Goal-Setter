import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> shareOnSocialMedia({required BuildContext context,required body, required imageUrl,required topic}) async {
  // Open the social media selector
  final selectedApp = await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share on Facebook'),
              onTap: () {
                Navigator.pop(context, 'Facebook');
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share on Instagram'),
              onTap: () {
                Navigator.pop(context, 'Instagram');
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share on WhatsApp'),
              onTap: () {
                Navigator.pop(context, 'WhatsApp');
              },
            ),
          ],
        ),
      );
    },
  );

  // Handle the selected social media app
  if (selectedApp != null) {
    switch (selectedApp) {
      case 'WhatsApp':
      // Share on WhatsApp
        final url = 'whatsapp://send?text=$body';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      case 'Facebook':
      // Share on Facebook
        final post = 'https://www.facebook.com/sharer/sharer.php?u=$imageUrl&quote=$body';
        if (await canLaunch(post)) {
          await launch(post);
        } else {
          throw 'Could not launch $post';
        }
        break;
      case 'Instagram':
      // Share on Instagram
        final post = 'https://www.instagram.com/share?url=$imageUrl&caption=$body';
        if (await canLaunch(post)) {
          await launch(post);
        } else {
          throw 'Could not launch $post';
        }
        break;
    }
  }
}
