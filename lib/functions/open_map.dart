import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(String link) async {
  await launch(link);
}
