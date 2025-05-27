import 'package:activ/app/app.dart';
import 'package:activ/bootstrap.dart';
import 'package:activ/config/flavor_config.dart';

void main() {
  FlavorConfig(flavor: Flavor.development);
  bootstrap(() => const App());
}
