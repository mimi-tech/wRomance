import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_author_socials.dart';

class SocialNetwork extends StatelessWidget {
  final Actor actor;
  const SocialNetwork(this.actor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
            visible: actor.webUrl.isNotEmpty,
            child: NetworkItem(
                'assets/images/icons/web.png', actor.webUrl, actor, 'web')),
        Visibility(
            visible: actor.instagramUrl.isNotEmpty,
            child: NetworkItem('assets/images/icons/insta.png',
                actor.instagramUrl, actor, 'instagram')),
        Visibility(
            visible: actor.tikTokUrl.isNotEmpty,
            child: NetworkItem('assets/images/icons/tikTok.png',
                actor.tikTokUrl, actor, 'tiktok')),
        Visibility(
            visible: actor.facebookUrl.isNotEmpty,
            child: NetworkItem('assets/images/icons/fb.png', actor.facebookUrl,
                actor, 'facebook')),
        Visibility(
            visible: actor.twitterUrl.isNotEmpty,
            child: NetworkItem('assets/images/icons/twit.png', actor.twitterUrl,
                actor, 'twitter')),
      ],
    );
  }
}

class NetworkItem extends StatelessWidget {
  final String image;
  final String link;
  final Actor actor;
  final String socialName;
  const NetworkItem(this.image, this.link, this.actor, this.socialName,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fixedUrl = link.startsWith("http") ? link : "https://$link";
    final Uri _url = Uri.parse(fixedUrl);
    return GestureDetector(
      onTap: () {
        Analytics.logEvent(EventAuthorSocials(context, actor, socialName));
        launchUrl(_url, mode: LaunchMode.externalApplication);
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: 34,
        child: Image.asset(image),
      ),
    );
  }
}
