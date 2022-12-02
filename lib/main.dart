import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//Halaman Splash Screen
class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return ChoicePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 167, 13),
      body: Center(
        child: Image.asset(
          "images/imud.png",
          width: 400.0,
          height: 250.0,
        ),
      ),
    );
  }
}

//Halaman pilihan scan dengan alat atau dengan qrcode
class ChoicePage extends StatefulWidget {
  ChoicePage({Key? key}) : super(key: key);

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 7, 141, 25),
          title: Text("SMKN Ihya' Ulumudin"),
          centerTitle: true),
      body: Center(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ToolPage()),
                                  );
                                },
                                child: Container(
                                  child: Image.asset('images/alat.png'),
                                  height: 200,
                                  width: 400,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 45,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 7, 141, 25),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ToolPage()),
                                          );
                                        },
                                        child: Text(
                                          "Scan Dengan Alat",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 25, top: 10),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InAppWebViewPage()),
                                          );
                                        },
                                        child: Container(
                                          child:
                                              Image.asset('images/qrcode.jpg'),
                                          width: 300,
                                          height: 200,
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5, top: 10, bottom: 20),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 45,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 7, 141, 25),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            InAppWebViewPage()),
                                                  );
                                                },
                                                child: Text(
                                                  "Scan Dengan Kamera",
                                                  style: TextStyle(
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Halaman scan dengan alat
class ToolPage extends StatefulWidget {
  ToolPage({Key? key}) : super(key: key);

  @override
  State<ToolPage> createState() => _ToolPageState();
}

class _ToolPageState extends State<ToolPage> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Presensi Siswa"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => _webViewController.reload(),
                icon: Icon(Icons.refresh))
          ],
        ),
        body: InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse("https://presensipkl.smkniu.sch.id/scan2/")),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                mediaPlaybackRequiresUserGesture: false,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              _webViewController = controller;
            },
            androidOnPermissionRequest: (InAppWebViewController controller,
                String origin, List<String> resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            }));
  }
}

//Halaman scan dengan qrcode
class InAppWebViewPage extends StatefulWidget {
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  late InAppWebViewController _webViewController;

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Presensi Siswa"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => _webViewController.reload(),
                icon: Icon(Icons.refresh))
          ],
        ),
        body: RefreshIndicator(
            onRefresh: _refresh,
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: InAppWebView(
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(
                              "https://presensipkl.smkniu.sch.id/mGvwLJfkc4zOJ7As9eEvA==")),
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          mediaPlaybackRequiresUserGesture: false,
                        ),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      androidOnPermissionRequest:
                          (InAppWebViewController controller, String origin,
                              List<String> resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      }),
                ),
              ),
            ])));
  }
}

Future<void> _refresh() {
  return Future.delayed(const Duration(seconds: 2));
}
