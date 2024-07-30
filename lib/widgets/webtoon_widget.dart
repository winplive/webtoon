import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/screens/detail_screen.dart';

//이름과 포스터의 위치

class Webtoon extends StatelessWidget {

  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailScreen(title: title, thumb: thumb, id: id
        ),
          fullscreenDialog: true,
        ),
        );
      },
      child: Column(
        children: [
          Hero(//Hero로 포스터 부분만 감싸 이미지 반복 사용을 줄임
            tag: id,
            child: Container(
              width: 250,
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
              child: Image.network(thumb,
                headers: const {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",},
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text(title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );;
  }
}