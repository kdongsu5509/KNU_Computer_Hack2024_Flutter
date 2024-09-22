import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import '../../a_server_info/server_url.dart';
import '../../const/MyColor.dart';
import '../../riverpod_provider/user_info_provider.dart';
import 'chatting_list_detail.dart';

class ChattingList extends ConsumerStatefulWidget {
  const ChattingList({super.key});

  @override
  ConsumerState<ChattingList> createState() => _HouseRegState();
}

class _HouseRegState extends ConsumerState<ChattingList> {

  //토큰 넣어서 방 조회.
  Future<List<Map<String, dynamic>>> _getChatRoomList() async {
    try {
      final dio = Dio();

      final resp = await dio.get('$baseUrl/api/chat/rooms',
          options: Options(headers: {
            'Authorization': 'Bearer $MY_TOKEN',
          }));

      final data = resp.data['chatRooms'];
      // print("data: ${resp.data}");
      // print("data type: ${data.runtimeType}");
      final result = List<Map<String, dynamic>>.from(data.map((chatRoom) {
        // print("chatRoom: ${chatRoom.runtimeType}");
        return {
          'chatRoomId': chatRoom['chatRoomId'],
          'title': chatRoom['title'],
          'name': chatRoom['name'],
          'preview': chatRoom['preview'],
          'unreadCount': chatRoom['unreadCount'],
          'nickname': chatRoom['nickname'],
          'imageUrl': chatRoom['imageUrl'],
        };
      }).toList());
      print("result: ${result}");
      return result;
    } on DioException catch (e) {
      print("error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getChatRoomList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          final data = snapshot.data;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Chat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: data!.map<Widget>((chatRoomListTile) {
                  print(chatRoomListTile);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChattingListDetail(
                            chatRoomId: chatRoomListTile!['chatRoomId'],
                          ),
                        ),
                      );
                    },
                    child: chatSummarizeBox(
                      context: context,
                      chatRoomListTile: chatRoomListTile,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}

Widget chatSummarizeBox({
  required BuildContext context,
  required Map<String, dynamic> chatRoomListTile,
  // required String title, // 차후 추가.
  // required String content,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(
          myFWidth(context, 0.04),
          myFWidth(context, 0.01),
          myFWidth(context, 0.04),
          myFWidth(context, 0.01),
        ),
        child: Container(
          height: myFHeight(context, 0.12),
          child: Row(
            children: [
              Container(
                height: myFHeight(context, 0.1),
                width: myFHeight(context, 0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(myFWidth(context, 0.01)),
                  border: Border.all(color: Colors.black),
                ),
                child: Icon(Icons.person),
              ),
              Padding(
                  padding: EdgeInsets.all(
                    myFWidth(context, 0.02),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              (chatRoomListTile['unreadCount'] != 0)
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: MY_ORANGE,
                                        shape: BoxShape.circle,
                                      ),
                                      width: myFWidth(context, 0.09),
                                      child: Center(
                                        child: Text(
                                          chatRoomListTile['unreadCount']
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: myFWidth(context, 0.035),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Text(
                                (chatRoomListTile['nickname'].length > 5)
                                    ? chatRoomListTile['nickname']
                                        .substring(0, 5)
                                    : chatRoomListTile['nickname'],
                                style: TextStyle(
                                  fontSize: myFWidth(context, 0.05),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'ㆍ',
                                style: TextStyle(
                                  fontSize: myFWidth(context, 0.05),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                (chatRoomListTile['name'].length > 6)
                                    ? chatRoomListTile['name'].substring(0, 6)
                                    : chatRoomListTile['name'],
                                style: TextStyle(
                                  fontSize: myFWidth(context, 0.05),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            chatRoomListTile['preview'],
                            style: TextStyle(
                              fontSize: myFWidth(context, 0.035),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )
    ],
  );
}
