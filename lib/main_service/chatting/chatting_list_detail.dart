import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../riverpod_provider/user_info_provider.dart';

class ChattingListDetail extends ConsumerStatefulWidget {
  final int chatRoomId;

  const ChattingListDetail({required this.chatRoomId, super.key});

  @override
  ConsumerState<ChattingListDetail> createState() => _ChattingListDetailState();
}

class _ChattingListDetailState extends ConsumerState<ChattingListDetail> {
  late final TextEditingController _textEditingController;

  // WebSocket 웹소켓 채널을 선언
  late final WebSocketChannel channel;

  String baseUrl = 'http://kkym.duckdns.org:8080';
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    //2. 방 번호를 이용하여 채팅방의 내용 상세 조회
    _getChatRoomDetail();

    //3. 채팅방 상세 조회를 통해 채팅방 정보를 받아옴
    //4. 채팅방 정보를 이용하여 채팅방 상세 화면을 구성
    // 텍스트 입력 컨트롤러를 초기화
    _textEditingController = TextEditingController();
    //WebSocket 웹소켓 서버 연결
    channel = IOWebSocketChannel.connect(
        Uri.parse('ws://kkym.duckdns.org:8080/send/chat/${widget.chatRoomId}'));
  }

  Future<Map<String,dynamic>> _getChatRoomDetail() async {
    final dio = Dio();

    final resp = await dio.get(
      '$baseUrl/api/chat/rooms/${widget.chatRoomId}',

      options: Options(
        headers: {
          'Authorization' : 'Bearer $MY_TOKEN',
        }
      )
    );

    final data= resp.data;
    final result = {
      'item' : Map<String, dynamic>.from(data['item']),
      'messages': List<Map<String, dynamic>>.from(data['messages']),
    };
    print("result: $result");
    return result;
  }

  void _onPressed() {
    // WebSocket 채널을 통해 메시지를 보내기
    channel.sink.add(_textEditingController.text);
    // 텍스트 필드를 초기화
    _textEditingController.text = '';
  }

  @override
  void dispose() {
    // 텍스트 입력 컨트롤러 해제
    _textEditingController.dispose();
    // WebSocket 채널 통신 닫기
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getChatRoomDetail(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('오류가 발생했습니다.'));
        } else {
          final data = snapshot.data;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              // 그림처럼 앱바의 그림자 제거
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // 뒤로가기 버튼
                },
              ),
              title: Text(
                data!['item']['title'],
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              // 타이틀 가운데 정렬
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
                          DateTime.now().toString().substring(0, 10),
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
                    children: List<Widget>.from(data['messages'].map((message) {
                      if (message['isMe']) {
                        return _buildSentMessage(message!['content'], message['createdAt']);
                      } else {
                        return _buildReceivedMessage(message!['content'], message['createdAt']);
                      }
                    }).toList()),
                  ),
                ),
                _buildInputArea(), // 입력창 영역
              ],
            ),
          );
        }
      },

    );
  }

  // 판매자가 보낸 메시지
  Widget _buildReceivedMessage( String message, String time) {
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
            onPressed: () {
              _onPressed();
            },
          ),
        ],
      ),
    );
  }
}
