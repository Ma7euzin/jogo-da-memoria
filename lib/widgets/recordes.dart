import 'package:flutter/material.dart';

import '../constants.dart';
import '../pages/recordes_page.dart';
import '../theme.dart';

class Recordes extends StatefulWidget {
  const Recordes({Key? key}) : super(key: key);

  @override
  State<Recordes> createState() => _RecordesState();
}

class _RecordesState extends State<Recordes> {
  showRecordes(Modo modo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RecordesPage(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'RECORDES',
                style: TextStyle(
                  color: NarutoTheme.color,
                  fontSize: 22,
                ),
              ),
            ),
            ListTile(
              title: const Text('Normal'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.normal),
            ),
            ListTile(
              title: const Text(
                'Desafiante',
                style: TextStyle(
                  color: NarutoTheme.color,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.naruto),
            )
          ],
        ),
      ),
    );
  }
}
