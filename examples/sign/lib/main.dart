import 'package:flutter/material.dart';
import 'package:sign/utils/dart_defines.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Web3ModalTheme(
      backgroundColor: const Color.fromARGB(255, 0, 115, 255),
      accentColor: const Color.fromARGB(255, 144, 144, 144),
      fontFamily: 'roboto',
      borderRadius: 5.0,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late IWeb3ModalService _service;
  String? _address;
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future<void> initialize() async {
    final Web3App app = await Web3App.createInstance(
      projectId: DartDefines.projectId,
      metadata: const PairingMetadata(
        name: 'Flutter WalletConnect',
        description: 'Flutter Web3Modal Sign Example',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );
    _service = Web3ModalService(web3App: app);
    _address = _service.address;

    _service.addListener(() {
      setState(() {
        _address = _service.address;
      });
    });

    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Web3Modal(service: _service),
            Web3ModalConnect(
              web3ModalService: _service,
            ),
            Text(
              'Address: $_address',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
