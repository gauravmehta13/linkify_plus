import 'src/email.dart';
import 'src/hash_url.dart';
import 'src/url.dart';

export 'src/email.dart' show EmailLinkifier, EmailElement;
export 'src/url.dart' show UrlLinkifier, UrlElement;
export 'src/user_tag.dart' show UserTagLinkifier, UserTagElement;

abstract class LinkifyElement {
  final String text;

  LinkifyElement(this.text);

  @override
  bool operator ==(other) => equals(other);

  bool equals(other) => other is LinkifyElement && other.text == text;
}

class LinkableElement extends LinkifyElement {
  final String url;

  LinkableElement(String? text, this.url) : super(text ?? url);

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) =>
      other is LinkableElement && super.equals(other) && other.url == url;
}

/// Represents an element containing text
class TextElement extends LinkifyElement {
  TextElement(String text) : super(text);

  @override
  String toString() {
    return "TextElement: '$text'";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) => other is TextElement && super.equals(other);
}

abstract class Linkifier {
  const Linkifier();

  List<LinkifyElement> parse(
      List<LinkifyElement> elements, LinkifyOptions options);
}

class LinkifyOptions {
  /// Removes http/https from shown URLs.
  final bool humanize;

  /// Removes www. from shown URLs.
  final bool removeWww;

  /// Enables loose URL parsing (any string with "." is a URL).
  final bool looseUrl;

  /// When used with [looseUrl], default to `https` instead of `http`.
  final bool defaultToHttps;

  /// Excludes `.` at end of URLs.
  final bool excludeLastPeriod;

  /// If set, will use this text instead of the URL.
  final String? urlText;

  const LinkifyOptions({
    this.humanize = true,
    this.removeWww = false,
    this.looseUrl = false,
    this.defaultToHttps = false,
    this.excludeLastPeriod = true,
    this.urlText,
  });
}

const _urlLinkifier = UrlLinkifier();
const _emailLinkifier = EmailLinkifier();
const _hashUrlLinkifier = HashUrlLinkifier();
const List<Linkifier> defaultLinkifiers = [
  _hashUrlLinkifier,
  _urlLinkifier,
  _emailLinkifier
];

/// Turns [text] into a list of [LinkifyElement]
///
/// Use [humanize] to remove http/https from the start of the URL shown.
/// Will default to `false` (if `null`)
///
/// Uses [linkTypes] to enable some types of links (URL, email).
/// Will default to all (if `null`).
List<LinkifyElement> linkify(
  String text, {
  LinkifyOptions options = const LinkifyOptions(),
  List<Linkifier> linkifiers = defaultLinkifiers,
}) {
  var list = <LinkifyElement>[TextElement(text)];

  if (text.isEmpty) {
    return [];
  }

  if (linkifiers.isEmpty) {
    return list;
  }

  for (Linkifier linkifier in linkifiers) {
    list = linkifier.parse(list, options);
  }

  return list;
}
