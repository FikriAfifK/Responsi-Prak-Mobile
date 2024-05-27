class ModelTeams {
  List<Data>? data;

  ModelTeams({this.data});

  ModelTeams.fromJson(Map<String, dynamic> json) {
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
  int? idClub;
  String? nameClub;
  String? logoClubUrl;
  String? stadiumName;
  String? captainName;
  String? headCoach;

  Data(
      {this.idClub,
        this.nameClub,
        this.logoClubUrl,
        this.stadiumName,
        this.captainName,
        this.headCoach});

  Data.fromJson(Map<String, dynamic> json) {
    idClub = json['IdClub'];
    nameClub = json['NameClub'];
    logoClubUrl = json['LogoClubUrl'];
    stadiumName = json['StadiumName'];
    captainName = json['CaptainName'];
    headCoach = json['HeadCoach'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdClub'] = this.idClub;
    data['NameClub'] = this.nameClub;
    data['LogoClubUrl'] = this.logoClubUrl;
    data['StadiumName'] = this.stadiumName;
    data['CaptainName'] = this.captainName;
    data['HeadCoach'] = this.headCoach;
    return data;
  }
}
