import 'package:get_it/get_it.dart';
import 'package:servicio/services/urlService.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}