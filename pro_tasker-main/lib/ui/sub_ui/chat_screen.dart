import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_tasker/ui/theme.dart';


class ChatScrren extends StatefulWidget {
  const ChatScrren({Key? key}) : super(key: key);

  @override
  State<ChatScrren> createState() => _ChatScrrenState();
}

class _ChatScrrenState extends State<ChatScrren> {

final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("AI Chat Bort"),
      ),
      body: Column(
        children: [
          Flexible(child:
          Container(
           height: 12,
          ),
          ),
          Container(
            decoration: BoxDecoration(
              color: PrimaryClr,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    ),
    );
  }
  Widget _buildTextComposer(){
    return Row(
      children: [
        Expanded(child:
         TextField(
           controller: _controller,
           decoration: InputDecoration.collapsed(hintText: "Send a message"),
         ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.send)),
      ],
    ).paddingAll(8);
  }
}
