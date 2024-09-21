import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChattingListDetail extends ConsumerStatefulWidget {
  const ChattingListDetail({super.key});

  @override
  ConsumerState<ChattingListDetail> createState() => _ChattingListDetailState();
}

class _ChattingListDetailState extends ConsumerState<ChattingListDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // 그림처럼 앱바의 그림자 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 버튼
          },
        ),
        title: Text(
          '매물이름',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // 타이틀 가운데 정렬
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 날짜 표시 영역
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider(color: Colors.black12)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '2024년 13월 32일',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.black12)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // 왼쪽에 표시되는 메시지
                _buildReceivedMessage("판매자 닉네임", "판매자가 보낸 메시지입니다.", "AM 12:34"),
                _buildSentMessage("내가 보낸 메시지입니다.", "AM 12:34"),
                _buildSentMessage("또 다른 메시지입니다.", "AM 12:35"),
                _buildReceivedMessage("판매자 닉네임", "다시 판매자가 보낸 메시지입니다.", "AM 12:35"),
              ],
            ),
          ),
          _buildInputArea(), // 입력창 영역
        ],
      ),
    );
  }

  // 판매자가 보낸 메시지
  Widget _buildReceivedMessage(String sender, String message, String time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sender, style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(message),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(time, style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 내가 보낸 메시지
  Widget _buildSentMessage(String message, String time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(message),
          ),
          SizedBox(height: 5),
          Text(time, style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  // 입력창 영역
  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요...',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
