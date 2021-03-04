import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/navigation.dart';
import 'package:mizer/state/provider.dart';

void main() async {
  final channel = ClientChannel(
    '192.168.1.13',
    port: 50051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  runApp(MyApp(channel));
}

class MyApp extends StatelessWidget {
  final ClientChannel channel;

  MyApp(this.channel);

  @override
  Widget build(BuildContext context) {
    return StateProvider(channel,
        child: MaterialApp(
          title: 'Mizer',
          darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.blueGrey, accentColor: Colors.deepOrangeAccent),
          home: Home(),
          themeMode: ThemeMode.dark,
        ));
  }
}
