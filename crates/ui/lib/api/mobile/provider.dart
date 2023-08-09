import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:mizer/api/contracts/fixtures.dart';

import 'fixtures.dart';

class MobileApiProvider extends StatelessWidget {
  final Widget child;

  MobileApiProvider({ required this.child });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: child,
      providers: [
        RepositoryProvider<FixturesApi>(create: (context) => FixturesMobileApi(ClientChannel('192.168.2.205')))
      ]
    );
  }

}
