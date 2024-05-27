class ModelDetail {
  Data? data;

  ModelDetail({this.data});

  ModelDetail.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
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
