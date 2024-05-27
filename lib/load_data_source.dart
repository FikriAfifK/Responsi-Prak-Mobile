import 'base_network.dart';
class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadLeagues() {
    return BaseNetwork.get("");
  }

  Future<Map<String, dynamic>> loadTeams(int idLeague){
    String idLeagues = idLeague.toString();
    return BaseNetwork.get("$idLeagues");
  }

  Future<Map<String, dynamic>> loadDetail(int idLeague, int idClub){
    String idClubs = idClub.toString();
    String idLeagues = idLeague.toString();
    return BaseNetwork.get("$idLeagues/$idClubs");
  }
}
