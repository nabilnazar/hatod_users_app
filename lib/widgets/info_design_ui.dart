import 'package:flutter/material.dart';


class InfoDesignUIWidget extends StatefulWidget
{
  String? textInfo;
  IconData? iconData;


  InfoDesignUIWidget({this.textInfo, this.iconData});

  @override
  State<InfoDesignUIWidget> createState() => _InfoDesignUIWidgetState();
}




class _InfoDesignUIWidgetState extends State<InfoDesignUIWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: ListTile(
        leading: Icon(
          widget.iconData,
          color: const Color(0xFF053BB3),
        ),
        title: Text(
          widget.textInfo!,
          style: const TextStyle(
            color: Color(0xFF1A237E),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
