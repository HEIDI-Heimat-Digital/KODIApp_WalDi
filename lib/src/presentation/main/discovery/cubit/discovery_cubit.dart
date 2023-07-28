import 'package:bloc/bloc.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

import 'discovery_state.dart';

class DiscoveryCubit extends Cubit<DiscoveryState> {
  DiscoveryCubit() : super(const DiscoveryState.loading());

  Future<String?> getCityLink() async {
    final prefs = await Preferences.openBox();
    int cityId = await prefs.getKeyValue(Preferences.cityId, int);
    Map<int, String> cityWebsites = {
      0: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger",
      1: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94572&behoerde=71996696712&gemeinde=898745703691",
      2: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94548&behoerde=64441660600&gemeinde=663856825691",
      3: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94536&behoerde=11664135546&gemeinde=529634609691",
      4: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94513&behoerde=06218912714&gemeinde=361856839691",
      5: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94481&behoerde=12775705447&gemeinde=210856846691",
      6: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94160&behoerde=45218989697&gemeinde=935745794689",
      7: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94157&behoerde=30552425675&gemeinde=902190240689",
      8: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94133&behoerde=80107867699&gemeinde=667301362689",
      9: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94116&behoerde=46330559598&gemeinde=566634700689",
      10: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94142&behoerde=04219626560&gemeinde=751190247689",
      11: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94163&behoerde=17663393706&gemeinde=969301348689",
      12: "https://www.bayernportal.de/suche/lebenslage/hierarchisch/buerger?plz=94169&behoerde=22885462739&gemeinde=036412456690"
    };

    return cityWebsites[cityId];
  }
}
