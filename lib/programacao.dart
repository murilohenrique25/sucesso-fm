import 'package:flutter/material.dart';

class Programacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Programação',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 25.0)),
              Card(
                color: Colors.blue[50],
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 3.0,
                      bottom: 3.0,
                    ),
                    child: Column(
                      children: [
                        Text('De Segunda a Sexta',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            )),
                        Divider(),
                        Text('03:00 as 05:00 - 2% Sertanejo'),
                        Divider(),
                        Text('05:00 as 08:00 - A Hora da Viola'),
                        Divider(),
                        Text('08:00 as 10:00 - Sintonia Total'),
                        Divider(),
                        Text('08:00 as 9:00 - Notícia em Foco'),
                        Divider(),
                        Text('10:00 as 10:30 - Jornal Virou Notícia'),
                        Divider(),
                        Text('09:00 as 11:00 - Show da Sucesso'),
                        Divider(),
                        Text('11:00 as 13:00 - Interligados'),
                        Divider(),
                        Text('20:00 as 23:00 - De Coração Para Coração'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
