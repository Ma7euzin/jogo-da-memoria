import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memoria/widgets/start_button.dart';

import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/game_controller.dart';

import 'dart:io' show Platform;

class FeedbackGame extends StatefulWidget {
  final Resultado resultado;

  const FeedbackGame({Key? key, required this.resultado}) : super(key: key);

  @override
  State<FeedbackGame> createState() => _FeedbackGameState();
}

class _FeedbackGameState extends State<FeedbackGame> {
  String getResultado() {
    return widget.resultado == Resultado.aprovado ? 'aprovado' : 'eliminado';
  }

  AdRequest? adRequest;
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  bool isLoaded = false;

  RewardedAd? rewardedAd;

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
    final controller = context.read<GameController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${getResultado().toUpperCase()}!',
            style: const TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset('images/${getResultado()}.png'),
          ),
          widget.resultado == Resultado.eliminado
              ? StartButton(
                  title: 'Tentar novamente',
                  color: Colors.white,
                  action: () => controller.restartGame(),
                )
              : StartButton(
                  title: 'Próximo Nível',
                  color: Colors.white,
                  action: () => controller.nextLevel(),
                ),
          const SizedBox(
            height: 20,
          ),
          isLoaded
              ? SizedBox(
                  height: 50,
                  width: 470,
                  child: AdWidget(
                    ad: bannerAd!,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
