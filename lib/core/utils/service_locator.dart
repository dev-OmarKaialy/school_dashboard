import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await appDependencies();
}

Future<void> appDependencies() async {}
