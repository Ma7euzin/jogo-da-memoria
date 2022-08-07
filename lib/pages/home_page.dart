import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memoria/pages/ajuda.dart';

import '../constants.dart';
import '../theme.dart';
import '../widgets/logo.dart';
import '../widgets/recordes.dart';
import '../widgets/start_button.dart';
import 'nivel_page.dart';

import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NivelPage(modo: modo),
      ),
    );
  }

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            StartButton(
              title: 'Normal',
              color: Colors.white,
              action: () => selecionarNivel(Modo.normal, context),
            ),
            StartButton(
              title: 'Desafiante',
              color: NarutoTheme.color,
              action: () => selecionarNivel(Modo.naruto, context),
            ),
            StartButton(
              title: 'Ajuda',
              color: NarutoTheme.color,
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Ajuda(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Recordes(),
            isLoaded
                ? SizedBox(
                    height: 62,
                    width: 370,
                    child: AdWidget(
                      ad: bannerAd!,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      /*bottomNavigationBar: Container(
        child: AdWidget(ad: bannerAd!),
      ),*/
    );
  }
}
