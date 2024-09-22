import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../../a_server_info/server_url.dart';
import '../../riverpod_provider/user_info_provider.dart';

class ChattingListDetail extends ConsumerStatefulWidget {
  final int chatRoomId;
  final List<Map<String, dynamic>> messages = [];

  ChattingListDetail({required this.chatRoomId, super.key});

  @override
  ConsumerState<ChattingListDetail> createState() => _ChattingListDetailState();
}

class _ChattingListDetailState extends ConsumerState<ChattingListDetail> {
  final TextEditingController _textEditingController = TextEditingController();

  // StompClient -> WebSocket을 통해 서버와 통신할 수 있도록 해주는 객체
  StompClient? stompClient;
  final dio = Dio();

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
        destination: '/receive/chat/${widget.chatRoomId}',
        callback: (StompFrame frame) {
          print(frame.body);
        });
  }

  @override
  void initState() {
    super.initState();
    //2. 방 번호를 이용하여 채팅방의 내용 상세 조회
    if (stompClient == null) {
      print("stompClient is null");
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: "$baseUrl/ws",
          onConnect: onConnect,
          onWebSocketError: (dynamic error) => print(error.toString()),
          webSocketConnectHeaders: {
            'Authorization': 'Bearer $MY_TOKEN',
          },
          stompConnectHeaders: {
            'Authorization': 'Bearer $MY_TOKEN',
          }
        ),
      );
      stompClient!.activate();
    }
  }

  //3. 채팅방 상세 조회를 통해 채팅방 정보를 받아옴
  //4. 채팅방 정보를 이용하여 채팅방 상세 화면을 구성
  // 텍스트 입력 컨트롤러를 초기화
  //WebSocket 웹소켓 서버 연결

  Future<Map<String, dynamic>> _getChatRoomDetail() async {
    final dio = Dio();

    final resp = await dio.get('$baseUrl/api/chat/rooms/${widget.chatRoomId}',
        options: Options(headers: {
          'Authorization': 'Bearer $MY_TOKEN',
        }));

    final data = resp.data;
    final result = {
      'item': Map<String, dynamic>.from(data['item']),
      // 'messages': List<Map<String, dynamic>>.from(data['messages']),
      'messages': data['messages'].map((message) => {
        'isMe': message['isMe'],
        'content': message['content'],
        'createdAt': List<int>.from(message['createdAt']).join('-').substring(0, 18),
      })
    };
    print("result: $result");
    return result;
  }

  void _onPressed() {
    final message = _textEditingController.text;
    if (message.isNotEmpty) {
      stompClient!.send(
        destination: '/send/chat/${widget.chatRoomId}',
        body: jsonEncode({
          'content': message,
        }),
      );
      _textEditingController.clear();
    }

    _getChatRoomDetail();
    setState(() {

    });
  }

  @override
  void dispose() {
    // 텍스트 입력 컨트롤러 해제
    _textEditingController.dispose();
    stompClient!.deactivate();
    // WebSocket 채널 통신 닫기
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getChatRoomDetail(),
      builder: (context, snapshot) {
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
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                        return _buildSentMessage(
                            message!['content'], message['createdAt']);
                      } else {
                        return _buildReceivedMessage(
                            message!['content'], message['createdAt']);
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
  Widget _buildReceivedMessage(String message, String time) {
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
              controller: _textEditingController,
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
