import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import '../../const/MyColor.dart';
import '../../project_common/customDivider.dart';
import 'chatting_list_detail.dart';

class ChattingList extends ConsumerStatefulWidget {
  const ChattingList({super.key});

  @override
  ConsumerState<ChattingList> createState() => _HouseRegState();
}

class _HouseRegState extends ConsumerState<ChattingList> {
  @override
  Widget build(BuildContext context) {
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
          children: [
            chatSummarizeBox(context: context),
            TextButton(
              child: Text('채팅방으로 이동'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChattingListDetail(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget chatSummarizeBox({
  required BuildContext context,
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
                          Text(
                            '기랸치 - 첨성기숙사',
                            style: TextStyle(
                              fontSize: myFWidth(context, 0.05),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '지금 거래하시면 네고해드립니다.',
                            style: TextStyle(
                              fontSize: myFWidth(context, 0.035),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: myFWidth(context, 0.05),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: MY_ORANGE,
                          shape: BoxShape.circle,
                        ),
                        width: myFWidth(context, 0.09),
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: myFWidth(context, 0.035),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
