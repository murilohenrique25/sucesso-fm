import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sucesso_jm/ad_helper.dart';
import 'package:sucesso_jm/model/weather.dart';
import 'package:sucesso_jm/programacao.dart';
import 'package:sucesso_jm/repository/weather_repository.dart';
import 'package:sucesso_jm/sobre.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

final streamUrl = 'http://srv.radioproarte.com.br:7094/';
// final streamUrl = 'http://sd.dnip.com.br:10408/;';
final AssetsAudioPlayer _player = AssetsAudioPlayer.newPlayer();
final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rádio Sucesso. Aqui é bem melhor !',
      theme: ThemeData(
        primaryColor: Colors.indigo[800],
      ),
      home: MyHomePage(
        title: 'Rádio Sucesso de Caldas Novas 99,9 FM',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BannerAd _bannerAd;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      listener: AdListener(onAdLoaded: (_) {
        setState(() {
          isLoading = true;
        });
      }, onAdFailedToLoad: (_, error) {
        print('Falha ao carregar: $error');
      }),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
                key: fabKey,
                // Cannot be `Alignment.center`
                alignment: Alignment.bottomRight,
                ringColor: Colors.white.withAlpha(25),
                ringDiameter: 500.0,
                ringWidth: 150.0,
                fabSize: 52.0,
                fabElevation: 8.0,
                fabIconBorder: CircleBorder(),
                fabColor: Colors.white,
                fabOpenIcon: Icon(Icons.menu, color: primaryColor),
                fabCloseIcon: Icon(Icons.close, color: primaryColor),
                fabMargin: const EdgeInsets.all(16.0),
                animationDuration: const Duration(milliseconds: 800),
                animationCurve: Curves.easeInOutCirc,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () {
                      abrirWhatsapp();
                      fabKey.currentState!.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('assets/images/whatsapp.png'),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      abrirFacebook();
                      fabKey.currentState!.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('assets/images/facebook.png'),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      abrirYoutube();
                      fabKey.currentState!.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('assets/images/youtube.png'),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      compartilharApp();
                      fabKey.currentState!.close();
                    },
                    shape: CircleBorder(),
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('assets/images/share.png'),
                  )
                ],
              )),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Rádio Sucesso de Caldas Novas 99,9 FM',
          style: TextStyle(fontSize: 14.5),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Rádio Sucesso de Caldas Novas 99,9 FM"),
              accountEmail: Text("wanderleicn@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://radiosucesso.net.br/adm/zHD/logo/0730134001616788667.jpg'),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
                leading: Icon(Icons.radio),
                title: Text("Programação"),
                subtitle: Text("Hórarios e programas"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Programacao()),
                  );
                }),
            ListTile(
                leading: Icon(Icons.info),
                title: Text("Sobre"),
                subtitle: Text("Conheça nossa rádio"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sobre()),
                  );
                })
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/fundoSucessoFM.png'),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0)),
                previsaoTempo(),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * 0.10, 0, 0)),
                Player(streamUrl),
                if (isLoading)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.width.toDouble(),
                      child: AdWidget(
                        ad: _bannerAd,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  abrirWhatsapp() async {
    const url =
        'https://api.whatsapp.com/send?phone=556434542012&text=Ol%C3%A1!%20estou%20entrando%20em%20contato%20para%20falar,%20pedir%20musica,%20ou%20falar%20no%20programa';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  abrirFacebook() async {
    const url = 'https://www.facebook.com/sucesso99.9/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  abrirYoutube() async {
    const url = 'https://www.youtube.com/channel/UCDCF8O1tFYFez557U1i6YNQ';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  compartilharApp() async {
    const url = 'https://play.google.com/store?hl=pt_BR&gl=US';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget previsaoTempo() {
    return FutureBuilder<Weather>(
        future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: Text(
                          snapshot.data!.city,
                          style: TextStyle(fontSize: 22.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Temp: ${snapshot.data!.temp}º',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black))
                            ],
                          ),
                          Row(
                            children: [
                              Text('Umd. do ar: ${snapshot.data!.humidity}%',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        child: Image.asset(
                          icone(snapshot.data!.conditionSlug),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Máx: ${snapshot.data!.maxTemp}º',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Mín: ${snapshot.data!.minTemp}º',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                        child: Text(
                          snapshot.data!.description,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Nascer do Sol: ${snapshot.data!.sunrise}',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Pôr do Sol: ${snapshot.data!.sunset}',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  String icone(String condition) {
    var icone;
    switch (condition) {
      case 'storm':
        icone = 'assets/images/tempestades.png';
        break;
      case 'rain':
        icone = 'assets/images/chuva.png';
        break;
      case 'clear_day':
        icone = 'assets/images/sunny-day.png';
        break;
      case 'clear_night':
        icone = 'assets/images/clear_night.png';
        break;
      case 'cloud':
        icone = 'assets/images/cloud.png';
        break;
      case 'cloudly_day':
        icone = 'assets/images/cloudy-day.png';
        break;
      case 'cloudly_night':
        icone = 'assets/images/cloudly_night.png';
        break;
      default:
        return icone = 'assets/images/warning.png';
    }
    return icone;
  }
}

class Player extends StatefulWidget {
  final String streamPath;
  Player(this.streamPath);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() async {
    try {
      _player.onErrorDo = (error) {
        error.player.stop();
      };
      await _player.open(
        Audio.liveStream(
          widget.streamPath,
          metas: Metas(
            title: 'Rádio Sucesso 99,9 FM',
            artist: 'Rádio Sucesso. Aqui é bem melhor !',
            image: MetasImage.network(
                'https://radiosucesso.net.br/adm/zHD/1/galerias/segundoplanoSucesso%20(0935891001620155155).jpg'),
          ),
        ),
        autoStart: true,
        showNotification: true,
        notificationSettings: NotificationSettings(
            nextEnabled: false, prevEnabled: false, stopEnabled: false),
      );
    } catch (t) {
      print(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayerBuilder.isBuffering(
          player: _player,
          builder: (context, isBuffering) {
            if (isBuffering) {
              return Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 8,
                  ),
                  Text('Carregando...'),
                ],
              );
            } else {
              return SizedBox(); //empty
            }
          },
        ),
        PlayerBuilder.isPlaying(
          player: _player,
          builder: (context, isPlaying) {
            return Container(
              width: 85.0,
              height: 85.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.indigo[800]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent),
                onPressed: () async {
                  try {
                    isPlaying ? await _player.stop() : _player.play();
                  } catch (t) {
                    print(t);
                  }
                },
                child: isPlaying
                    ? Icon(
                        Icons.stop,
                        size: 45.0,
                      )
                    : Icon(
                        Icons.play_arrow,
                        size: 45.0,
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
