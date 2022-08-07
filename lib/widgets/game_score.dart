import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/game_controller.dart';

import 'dart:io' show Platform;

class GameScore extends StatefulWidget {
  final Modo modo;
  const GameScore({Key? key, required this.modo}) : super(key: key);

  @override
  State<GameScore> createState() => _GameScoreState();
}

class _GameScoreState extends State<GameScore> {
  AdRequest? adRequest;

  BannerAd? bannerAd;

  InterstitialAd? interstitialAd;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    String bannerId = Platform.isAndroid
        ? "ca-app-pub-3940256099942544/6300978111"
        : "ca-app-pub-3940256099942544/2934735716";
 
    adRequest = const AdRequest(
      nonPersonalizedAds: false,
    );

    BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
      },
      onAdClosed: (ad) {
        bannerAd!.load();
      },
      onAdFailedToLoad: (ad, error) {
        bannerAd!.load();
      },
    );
    bannerAd = BannerAd(
      size: AdSize.leaderboard,
      adUnitId: bannerId,
      listener: bannerAdListener,
      request: adRequest!,
    );
    bannerAd!.load();
    
  }

  @override
  void dispose() {
    bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.modo == Modo.naruto
                ? Icons.my_location
                : Icons.touch_app_rounded),
            const SizedBox(width: 10),
            Observer(
                builder: (_) => Text(controller.score.toString(),
                    style: const TextStyle(fontSize: 25))),
          ],
        ),
        Image.asset('images/host.png', width: 38, height: 60),
        TextButton(
            child: const Text('Sair', style: TextStyle(fontSize: 18)),
            onPressed: () {
              isLoaded ? InterstitialAd.load(
          adUnitId: Platform.isAndroid 
          ?"ca-app-pub-2028996810271423/3613235315"
          :"ca-app-pub-3940256099942544/4411468910", 
          request: const AdRequest(), 
          adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
           interstitialAd = ad;
           interstitialAd!.show();
           Navigator.of(context).pop();
          }, onAdFailedToLoad: (error){
            debugPrint(error.message);
          }),
          ): Navigator.of(context).pop();
            }),
      ],
    );
  }
}
