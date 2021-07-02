import 'package:flutter/material.dart';

String _name = 'Colby Garland';

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {required this.text,
      required this.datetime,
      required this.animationController});
  final String text;
  final String datetime;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    child: Text(datetime),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
