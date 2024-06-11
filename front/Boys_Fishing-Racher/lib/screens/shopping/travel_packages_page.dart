import 'package:flutter/material.dart';

class TravelPackagesPage extends StatelessWidget {
  final List<Map<String, String>> packages = [
    {
      "title": "제주도 자연투어",
      "description": "제주 현지 여행사 킴스제주에서 제공하는 우도 여행 패키지와 동쪽 시즌별 명소 투어.",
      "price": "50,000원~",
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "title": "강원도 자연투어",
      "description": "강원관광도로 6번 코스를 따라 평창, 강릉, 동해를 여행하는 1박 2일 패키지.",
      "price": "150,000원~",
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "title": "경주 시내투어",
      "description": "송샘과 함께하는 경주 교과서 여행. 천년고도의 역사 유적을 탐방하는 1박 2일 일정.",
      "price": "80,000원~",
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "title": "서울 시내투어",
      "description": "안지영 가이드와 함께하는 서울 고궁 투어. 경복궁과 서울의 역사적인 명소 탐방.",
      "price": "30,000원~",
      "imageUrl": "https://via.placeholder.com/150",
    },
    {
      "title": "전남 여수 엑스포카트 투어",
      "description": "여수 엑스포카트 단품 & 패키지로 여수를 100% 즐기는 방법.",
      "price": "70,000원~",
      "imageUrl": "https://via.placeholder.com/150",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: packages.map((pkg) => _buildTravelCard(pkg)).toList(),
      ),
    );
  }

  Widget _buildTravelCard(Map<String, String> pkg) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(pkg["imageUrl"]!),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pkg["title"]!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  pkg["description"]!,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  pkg["price"]!,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}