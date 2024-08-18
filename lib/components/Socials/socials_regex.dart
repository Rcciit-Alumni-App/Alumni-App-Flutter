import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SocialMediaPlatform {
  facebook,
  instagram,
  linkedin,
  github,
  x,
  others
}

class SocialsRegex {
  static RegExp githubUrlPattern = RegExp(
    r'^(http(s)?:\/\/)?(www\.)?github\.com\/(?!-)(?:[A-z0-9-]){1,39}[^-]\/?$',
    caseSensitive: false,
  );

  static RegExp instagramUrlPattern = RegExp(
    r'^(http(s)?:\/\/)?(www\.)?instagram\.com\/([A-Za-z0-9_](?:(?:[A-Za-z0-9_]|(?:\.(?!\.))){0,28}(?:[A-Za-z0-9_]))?)\/?$',
    caseSensitive: false,
  );

  static RegExp linkedInUrlPattern = RegExp(
    r'^(http(s)?:\/\/)?(www\.)?linkedin\.com\/(in|profile|pub)\/([A-Za-z0-9_-]+)\/?$',
    caseSensitive: false,
  );

  static RegExp twitterUrlPattern = RegExp(
    r'^(http(s)?:\/\/)?(www\.)?twitter\.com\/[A-Za-z0-9_]{1,15}\/?$',
    caseSensitive: false,
  );

  static RegExp facebookUrlPattern = RegExp(
    r'(?:https?:)?\/\/(?:www\.)?(?:facebook|fb)\.com\/(?![A-Za-z]+\.php)(?!marketplace|gaming|watch|me|messages|help|search|groups)[A-Za-z0-9_\-\.]+\/?|'
    r'(?:https?:)?\/\/(?:www\.)facebook\.com\/(?:profile\.php\?id=)?[0-9]+',
    caseSensitive: false,
  );

  static SocialMediaPlatform detectSocialMediaPlatform(String url) {
    if (facebookUrlPattern.hasMatch(url)) {
      return SocialMediaPlatform.facebook;
    } else if (githubUrlPattern.hasMatch(url)) {
      return SocialMediaPlatform.github;
    } else if (instagramUrlPattern.hasMatch(url)) {
      return SocialMediaPlatform.instagram;
    } else if (linkedInUrlPattern.hasMatch(url)) {
      return SocialMediaPlatform.linkedin;
    } else if (twitterUrlPattern.hasMatch(url)) {
      return SocialMediaPlatform.x;
    } else {
      return SocialMediaPlatform.others;
    }
  }

  static getIcon(SocialMediaPlatform socialMediaPlatform) {
    switch (socialMediaPlatform) {
      case SocialMediaPlatform.facebook:
        return FontAwesomeIcons.facebook;
      case SocialMediaPlatform.x:
        return FontAwesomeIcons.twitter;
      case SocialMediaPlatform.instagram:
        return FontAwesomeIcons.instagram;
      case SocialMediaPlatform.linkedin:
        return FontAwesomeIcons.linkedin;
      case SocialMediaPlatform.github:
        return FontAwesomeIcons.github;
      default:
        return Icons.public;
    }
  }
}
