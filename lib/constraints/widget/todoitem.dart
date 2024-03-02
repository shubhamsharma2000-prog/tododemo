import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/constraints/colors.dart';
import 'package:todo/model/todo.dart';

class todoItem extends StatelessWidget{
  final Item todod;
  final todochange;
  final tododelete;

  const todoItem({Key?key,required this.todod, this.todochange, this.tododelete}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          todochange(todod);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        tileColor: Colors.tealAccent,
        leading: Icon(todod.isDone? FontAwesomeIcons.clipboardCheck:FontAwesomeIcons.circleCheck,color: tdBlue,),
        title: Text(todod.items,
          style: TextStyle(fontSize: 16,color: tdBlack,
            decoration: todod.isDone? TextDecoration.lineThrough: null,
          ),
        ),
        trailing: Container(
          margin: EdgeInsets.only(left: 50),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            color: CupertinoColors.white,
            iconSize: 18,
            icon: Icon(FontAwesomeIcons.solidTrashCan,color: Colors.indigo,),
            onPressed: () {
              tododelete(todod.id);
            },
          ),
        ),

      ),
    );
  }

}