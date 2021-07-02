import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:friendly_chat/helpers/platform.dart';
import 'package:friendly_chat/widgets/ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode();

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: text,
      datetime:
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 275)),
    );
    setState(() {
      _messages.insert(0, message);
    });
    _textController.clear();
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: isIOS()
                  ? CupertinoButton(
                      child: Text('Send'),
                      onPressed: () => _handleSubmitted(_textController.text))
                  : IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => _handleSubmitted(_textController.text),
                    ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendly Chat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        decoration: isIOS()
            ? BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[200]!)))
            : null,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
