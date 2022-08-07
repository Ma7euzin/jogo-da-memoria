import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memoria/theme.dart';

import 'dart:io' show Platform;

class Ajuda extends StatefulWidget {
  const Ajuda({Key? key}) : super(key: key);

  @override
  State<Ajuda> createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  final List<String> _helps = [
    'Bem vido ao jogo da memória da SuetamSoft',
    'primeiro você precisa escolher um modo de jogo',
    'existem dois modos, Normal e o desafiante',
    'No modo normal o jogo da memoria é mais fácil pois só acaba quando você encontrar todas as cartas',
    'No modo Desafiante é o modo mais difícil pois vc tem X tentativas para encontrar os pares',
    'desafie sua mente...',
    '...e seja FELIZ!',
  ];

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            AppBar(
              title: const Text('Ajuda'),
            ),
            const SizedBox(height: 15.0),
            ..._buildHelp(),
            const SizedBox(height: 20.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
              height: 38.0,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: NarutoTheme.color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: const Text('Bom Jogo!', style: TextStyle(fontSize: 23)),
            ),
            isLoaded
                ? SizedBox(
                    height: 52,
                    width: 370,
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHelp() {
    return _helps
        .asMap()
        .entries
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              '${e.key + 1}. ${e.value}',
              style: const TextStyle(fontSize: 23),
            ),
          ),
        )
        .toList();
  }
}
