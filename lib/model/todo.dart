import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item{
  String? id;
  String items;
  bool isDone = false;

  Item({
    required this.id,
    required this.items,
    this.isDone=false,
  });
  static List<Item> dynamicTodo(){
    return[
      Item(id: '1', items:'Be Creative'  ),
      Item(id: '2', items:'Enjoy The Little Things',isDone: true ),
      Item(id: '4', items:'Use me for complete your daily work' ),
      Item(id: '5', items:'I hope i find you well'  ),
      Item(id: '5', items:"Hii it's me To Do" , isDone: true),
      Item(id: '6',items:'Implement whatever organizational system works best '
          'for you, but then be sure to review '
          'your to-do list at least once a week.' ),
    ];
  }
}