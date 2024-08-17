
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/loader_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/services/news_service.dart';
import 'package:get_it/get_it.dart';

Future<void> registerService() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<AlertService>(
    AlertService(),
  );
  getIt.registerSingleton<LoaderService>(
    LoaderService(),
  );
  getIt.registerSingleton<NewsService>(
    NewsService(),
  );
  getIt.registerSingleton<EventService>(
    EventService(),
  );
}
