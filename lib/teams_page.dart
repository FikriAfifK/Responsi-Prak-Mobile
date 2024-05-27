import 'package:flutter/material.dart';
import 'package:responsi_praktikum/load_data_source.dart';
import 'package:responsi_praktikum/detail_page.dart';
import 'package:responsi_praktikum/model_teams.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key, required this.idLeagues}) : super(key: key);
  final int idLeagues;

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teams",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: _buildListTeamsBody(),
    );
  }

  Widget _buildListTeamsBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadTeams(widget.idLeagues),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            ModelTeams modelTeams = ModelTeams.fromJson(snapshot.data);
            return _buildSuccessSection(modelTeams);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(ModelTeams teams) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: teams.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemTeams(teams.data![index]);
      },
    );
  }

  Widget _buildItemTeams(Data teamsData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    idClub: teamsData.idClub!,
                    idLeagues: widget.idLeagues!,
                  ))),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          color: Colors.lightBlue,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.network(teamsData.logoClubUrl!),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        teamsData.nameClub!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        teamsData.headCoach!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
