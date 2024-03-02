import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/constraints/colors.dart';
import 'package:todo/model/todo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constraints/widget/todoitem.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
class myHomePage extends StatefulWidget{
  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  final Todo = Item.dynamicTodo();
  final TodoController = TextEditingController();
  List<Item> todoFound=[];
  File? demofile;
  final pic = ImagePicker();

  Future getimage() async{
    final picked = await pic.pickImage(source: ImageSource.gallery);


        if(picked!=null){
          setState(() {
            demofile = File(picked.path);
          });
        }

  }




  @override
  void initState() {
    // TODO: implement initState
    todoFound = Todo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 40,
                  width: 60,
                  child: Icon(FontAwesomeIcons.clipboardList,size: 30,color: Colors.indigo,)
              ),



                Container(
                  height: 70,
                  width: 70,
                  margin:EdgeInsets.all(10),

                  child: ClipOval(


                      child: IconButton(onPressed: ()
                      {        getimage();   },
                        icon:Center( child: demofile==null?Icon(Icons.account_circle_outlined,color: Colors.indigo,)
                            :Image.file(demofile!))),
                  
                  
                  ),
                )]),
      ),
      body:  Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                search(),
                Expanded(
                  child:
                  ListView(
                    children:
                    [
                      Container(
                        margin: EdgeInsets.only(top: 20,
                            bottom: 25),
                        child: Text(
                          "All ToDos",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500
                          ),),
                      ),
                      for(Item todo in todoFound.reversed)
                        todoItem(
                          todod: todo,
                          todochange: handleTodo,
                          tododelete: deletetodo,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child:
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20,
                      top: 20,
                      left: 20
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:[ BoxShadow(
                      color: Colors.black12,
                      offset: Offset(10.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),],
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: TextField(
                    controller: TodoController,
                    decoration: InputDecoration(
                      hintText: "Add a new ToDo item",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ),
                Container(
                    margin: EdgeInsets.only(

                      right: 0,
                    ),
                    child: ElevatedButton(
                      child: Icon(FontAwesomeIcons.solidPaperPlane,color: Colors.blueAccent,size: 25,),
                      onPressed: () {
                        addTodo(TodoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: Colors.tealAccent,
                        minimumSize: Size(55,55),
                        elevation: 0,
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),

    );
  }
  void handleTodo(Item Tdo){
    setState(() {
      Tdo.isDone = !Tdo.isDone;
    });
  }
  void deletetodo(String id){
    setState(() {
      Todo.removeWhere((item) => item.id==id);
    });
  }
  void addTodo(String tdo){
    setState(() {
      Todo.add(Item(id: DateTime.now().millisecondsSinceEpoch.toString(), items: tdo));
    });
    TodoController.clear();
  }
  void foundTodo(String search){
    List<Item> result=[];
    if(search.isEmpty)
    {
      result=Todo;
    }
    else
    {
      result=Todo.where((item) =>
          item.items!
              .toLowerCase()
              .contains(search
              .toLowerCase()))
          .toList();
    }
    setState(() {
      todoFound=result;
    });
  }

  Widget search()
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value)=> foundTodo(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white)
        ),
      ),
    );
  }
}