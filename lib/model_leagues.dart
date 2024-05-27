class ModelLeagues {
  List<Data>? data;

  ModelLeagues({this.data});

  ModelLeagues.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? idLeague;
  String? leagueName;
  String? country;
  String? logoLeagueUrl;
  String? leaderStandings;

  Data(
      {this.idLeague,
        this.leagueName,
        this.country,
        this.logoLeagueUrl,
        this.leaderStandings});

  Data.fromJson(Map<String, dynamic> json) {
    idLeague = json['idLeague'];
    leagueName = json['leagueName'];
    country = json['country'];
    logoLeagueUrl = json['logoLeagueUrl'];
    leaderStandings = json['leaderStandings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idLeague'] = this.idLeague;
    data['leagueName'] = this.leagueName;
    data['country'] = this.country;
    data['logoLeagueUrl'] = this.logoLeagueUrl;
    data['leaderStandings'] = this.leaderStandings;
    return data;
  }
}
