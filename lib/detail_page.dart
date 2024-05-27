import 'package:flutter/material.dart';
import 'package:responsi_praktikum/load_data_source.dart';
import 'package:responsi_praktikum/model_detail.dart' as ModelDetail;
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.idClub, required this.idLeagues})
      : super(key: key);
  final int idClub;
  final int idLeagues;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ModelDetail.Data? currentDetail;
  bool _isFav = false;
  var icon = Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Club", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: icon,
            onPressed: _saveFavorite,
            color: Colors.white,
          ),
        ],
      ),
      body: _buildListDetailPageBody(),
    );
  }

  Widget _buildListDetailPageBody() {
    return Container(
      child: FutureBuilder(
        future:
            ApiDataSource.instance.loadDetail(widget.idLeagues, widget.idClub),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            ModelDetail.ModelDetail detailModel =
                ModelDetail.ModelDetail.fromJson(snapshot.data);
            currentDetail = detailModel.data; // Inisialisasi currentKomik
            return _buildSuccessSection(detailModel);
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

  Widget _buildSuccessSection(ModelDetail.ModelDetail detail) {
    ModelDetail.Data club = detail.data!;
    return ListView(
      shrinkWrap: true,
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.network(club.logoClubUrl!),
              ),
              SizedBox(height: 20),
              Text(
                club.nameClub!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text("Head Coach", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 5),
              Text(
                club.headCoach!,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text("Captain", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 5),
              Text(
                club.captainName!,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text("Stadium Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 5),
              Text(
                club.stadiumName!,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text("Logo Url", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 5,),
              ElevatedButton.icon(
                onPressed: () {
                  launchURL(club.logoClubUrl!);
                },
                icon: Icon(Icons.launch_outlined),
                label: Text("Show Club Logo"),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _saveFavorite() {
    if (_isFav == false) {
      setState(() {
        icon = Icon(Icons.favorite);
        _isFav = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Favorite team added!'),
        backgroundColor: Colors.green,
      ));
    } else {
      setState(() {
        icon = Icon(Icons.favorite_border);
        _isFav = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Favorite team removed!'),
        backgroundColor: Colors.red,
      ));
    }
  }
}

Future<void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw "Couldn't launch $_url";
  }
}
