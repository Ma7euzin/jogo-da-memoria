import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../repositories/recordes_repository.dart';
import '../theme.dart';
import 'dart:io' show Platform;

class RecordesPage extends StatefulWidget {
  final Modo modo;

  const RecordesPage({Key? key, required this.modo}) : super(key: key);

  @override
  State<RecordesPage> createState() => _RecordesPageState();
}

class _RecordesPageState extends State<RecordesPage> {
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

  getModo() {
    return widget.modo == Modo.normal ? 'Normal' : 'Desafiante';
  }

  List<Widget> getRecordesList(Map recordes) {
    final List<Widget> widgets = [];

    recordes.forEach((nivel, score) {
      widgets.add(ListTile(
        title: Text('Nível $nivel'),
        trailing: Text(score.toString()),
        tileColor: Colors.grey[900],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ));

      widgets.add(const Divider(color: Colors.transparent));
    });

    if (widgets.isEmpty) {
      widgets.add(
        const Center(
          child: Text('AINDA NÃO RECORDES!'),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<RecordesRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Observer(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 24),
                child: Center(
                  child: Text(
                    'Modo ${getModo()}',
                    style:
                        const TextStyle(fontSize: 28, color: NarutoTheme.color),
                  ),
                ),
              ),
              ...getRecordesList(widget.modo == Modo.normal
                  ? repository.recordesNormal
                  : repository.recordesRound6),
              const Spacer(),
              isLoaded
                  ? SizedBox(
                      height: 50,
                      width: 350,
                      child: AdWidget(
                        ad: bannerAd!,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
