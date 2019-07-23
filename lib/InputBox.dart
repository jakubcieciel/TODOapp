import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final String text;
  final bool isTextbox;
  final bool isVisible;
  final bool isTextField;
  final Widget childIfNotTextBox;
  final Widget childIfNotTextField;
  final Function onClick;
  final Function(String) onChanged;

  InputBox(
      {@required this.text,
      this.isTextbox = true,
      this.isVisible = true,
      this.isTextField = true,
      this.childIfNotTextBox,
      this.childIfNotTextField,
      this.onClick,
      this.onChanged});

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  String textOutput;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onClick,
        child: widget.isVisible
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                child: widget.isTextbox
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 8.0, top: 15, bottom: 8),
                            child: Text(
                              '${widget.text}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: widget.isTextField
                                ? TextField(
                                    onChanged: (value) {
                                      textOutput = value;
                                      widget.onChanged(textOutput);
                                    },
                                    cursorColor: Colors.white,
                                    maxLines: 10,
                                    minLines: 1,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      counterStyle: TextStyle(fontSize: 0),
                                      border: InputBorder.none,
                                      hintText:
                                          'enter ${widget.text.toLowerCase()} of your task here',
                                      hintStyle:
                                          TextStyle(color: Colors.red[100]),
                                    ),
                                  )
                                : widget.childIfNotTextField,
                          )
                        ],
                      )
                    : widget.childIfNotTextBox,
              )
            : Container(),
      ),
    );
  }
}
