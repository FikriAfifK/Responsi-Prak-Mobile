import 'package:flutter/material.dart';
import 'package:responsi_praktikum/load_data_source.dart';
import 'package:responsi_praktikum/teams_page.dart';
import 'package:responsi_praktikum/model_leagues.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({Key? key}) : super(key: key);
  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leagues",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: _buildListLeaguesBody(),
    );
  }

  Widget _buildListLeaguesBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadLeagues(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            ModelLeagues modelLeagues = ModelLeagues.fromJson(snapshot.data);
            return _buildSuccessSection(modelLeagues);
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

  Widget _buildSuccessSection(ModelLeagues leagues) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: leagues.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemLeagues(leagues.data![index]);
      },
    );
  }

  Widget _buildItemLeagues(Data leaguesData) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeamsPage(
            idLeagues: leaguesData.idLeague!,
          ),
        ),
      ),
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
                      child: Image.network(leaguesData.logoLeagueUrl!),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        leaguesData.leagueName!,
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
                        leaguesData.country!,
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
