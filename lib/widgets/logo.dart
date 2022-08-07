import 'package:flutter/material.dart';

import '../theme.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Image.asset('images/host.png', width: 1000, height: 135),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RichText(
            text: TextSpan(
              text: 'Jogo da  ',
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30),
              children: const [
                TextSpan(
                  text: 'Memória',
                  style: TextStyle(color: NarutoTheme.color),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
