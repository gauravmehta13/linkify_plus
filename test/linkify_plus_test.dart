import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkify_plus/linkify_plus.dart';

void main() {
  testWidgets('Linkify renders text', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Linkify(
        text: 'Test https://google.com',
      ),
    ));

    expect(find.text('Test google.com'), findsOneWidget);
  });

  testWidgets('Linkify renders text without humanizing', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Linkify(
        text: 'Test https://google.com',
        options: LinkifyOptions(
          humanize: false,
        ),
      ),
    ));

    expect(find.text('Test https://google.com'), findsOneWidget);
  });

  testWidgets('Linkify renders text with loose URLs', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Linkify(
        text: 'Test google.com',
        options: LinkifyOptions(
          looseUrl: true,
        ),
      ),
    ));

    expect(find.text('Test google.com'), findsOneWidget);
  });

  testWidgets('Linkify renders without remove WWW', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Linkify(
        text: 'Test www.google.com',
      ),
    ));

    expect(find.text('Test www.google.com'), findsOneWidget);
  });

  testWidgets('Linkify renders with remove WWW', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Linkify(
        text: 'Test www.google.com',
        options: LinkifyOptions(
          removeWww: true,
        ),
      ),
    ));

    expect(find.text('Test google.com'), findsOneWidget);
  });
}
