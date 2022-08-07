import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memoria/game_settings.dart';

import '../constants.dart';
import '../models/game_play.dart';
import '../widgets/card_nivel.dart';

import 'dart:io' show Platform;

class NivelPage extends StatefulWidget {
  final Modo modo;

  const NivelPage({Key? key, required this.modo}) : super(key: key);

  @override
  State<NivelPage> createState() => _NivelPageState();
}

class _NivelPageState extends State<NivelPage> {
  AdRequest? adRequest;
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    String bannerId = Platform.isAndroid
        ? "ca-app-pub-2028996810271423/8897900323"
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
    final niveis = GameSettings.niveis
        .map((n) => CardNivel(gamePlay: GamePlay(modo: widget.modo, nivel: n)))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nível do Jogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 58),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          padding: const EdgeInsets.all(20),
          children: niveis,
        ),
      ),
      floatingActionButton: isLoaded
                ? SizedBox(
                    height: 62,
                    width: 360,
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : const SizedBox(),
            
    );
  }
}
