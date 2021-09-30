import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sobre',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 95)),
            Center(
              child: Image.network(
                'https://radiosucesso.net.br/adm/zHD/logo/0730134001616788667.jpg',
                width: 150,
              ),
            ),
            Divider(),
            Text("ENCONTRE-NOS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0)),
            Text("Endereço:\nAvenida Orcalino Santos\nCaldas Novas-GO",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0)),
            Padding(padding: EdgeInsets.only(bottom: 45)),
            Text("Nosso e-mail: wanderleicn@gmail.com",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0)),
            Text("Nosso telefone: (64) 3454-2012",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
