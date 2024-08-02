
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

Future<void> registerService() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
}
