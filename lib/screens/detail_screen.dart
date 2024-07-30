import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled5/services/api_service.dart';
import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';

class DetailScreen extends StatefulWidget {

  final String title, thumb, id;


  const DetailScreen({super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  @override

  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestepisodesById(widget.id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2,
        centerTitle: true,
        title: Text(widget.title,
          style:TextStyle(fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 210,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: Offset(10,10),
                            color: Colors.black.withOpacity(0.5),
                          )
                        ],
                      ),
                      child: Image.network(widget.thumb,
                        headers: const {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,
              ),
              FutureBuilder(future:webtoon,
                builder:(context,snapshot)
                {
                  if(snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder(future: episodes,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        for(var episode in snapshot.data!.length>10?snapshot.data!.sublist(0,10):snapshot.data!)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.shade400
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16,),
                              child: Row(
                                children: [
                                  Text(episode.title,style: TextStyle(fontSize: 16,color: Colors.white,),),
                                  Icon(Icons.chevron_right_rounded,size: 16,color: Colors.white,),
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            margin: EdgeInsets.only(bottom: 10),
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
