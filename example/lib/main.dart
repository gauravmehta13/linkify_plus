import 'dart:async';

import 'package:flutter/material.dart';
import 'package:linkify_plus/linkify_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(LinkifyExample());

class LinkifyExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'linkify_plus example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('linkify_plus example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Linkify(
                onOpen: _onOpen,
                textScaleFactor: 2,
                options: LinkifyOptions(urlText: "Cretzy"),
                text: "Made by https://cretezy.com\n\nMail: example@gmail.com",
              ),
            ),
            Center(
              child: SelectableLinkify(
                onOpen: _onOpen,
                textScaleFactor: 4,
                text: "Made by https://cretezy.com\n\nMail: example@gmail.com",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
