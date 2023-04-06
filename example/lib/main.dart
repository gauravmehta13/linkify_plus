import 'dart:async';

import 'package:flutter/material.dart';
import 'package:linkify_plus/linkify/linkify.dart';
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
                options: LinkifyOptions(),
                text: "Made by #https://cretezy.com#Resource1#",
              ),
            ),
            Center(
              child: Linkify(
                onOpen: _onOpen,
                textScaleFactor: 2,
                options: LinkifyOptions(),
                text:
                    "Made by #https://dev.ihealthlabs.com/account/sign-up-success#New  Name# and #https://cretezy.com#Resource1#",
              ),
            ),
            Center(
              child: Linkify(
                onOpen: _onOpen,
                textScaleFactor: 2,
                options: LinkifyOptions(),
                text:
                    "Made by #https://dev.ihealthlabs.com/account/sign-up-success#iHealth# and unMade by #https://dev.google.com/account/sign-up-success#iHealth3# and unMade by https://dev.google.com/account/sign-up-success",
              ),
            ),
            Center(
              child: SelectableLinkify(
                onOpen: _onOpen,
                linkifiers: [UserTagLinkifier()],
                textScaleFactor: 4,
                text: 'Hello @JohnDoe, did you see what @JaneDoe posted?',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    await launch(link.url);
  }
}
