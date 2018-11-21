import 'dart:ui';

import 'package:autoaqua/Model/ControllerItems.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';




class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {

  final TextEditingController _textEditingControler =
  new TextEditingController();
  final TextEditingController _textEditingControlerNumber =
  new TextEditingController();
  var db = new DataBaseHelper();
  final List<ControllerItem> _itemList = <ControllerItem>[];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _readTodoList();
  }


  void _handleSubmitted(String text, String number) async {
    _textEditingControler.clear();
    _textEditingControlerNumber.clear();

    ControllerItem doItems = new ControllerItem(text,number, dateFormatted());
    int saveItemId = await db.saveItem(doItems);

    ControllerItem addedItems = await db.getItem(saveItemId);

    setState(() {
      _itemList.add(addedItems);
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        backgroundColor: Colors.grey.shade200.withOpacity(0.8),
        body: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("Images/dashboardbackgroung.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                new Flexible(
                    child: new ListView.builder(
                        reverse: false,
                        itemCount: _itemList.length,
                        itemBuilder: (_, int index) {
                          return new Card(
                            color: Colors.white,
                            child: InkWell(
                              onDoubleTap:  (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialog(
                                      title: new Text("Delete Controller"),
                                      content: new Text("Are you sure you want to delete this controller?"),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("Close"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          child: new Text("Ok"),
                                          onPressed: () {
                                            _deleteToDo(_itemList[index].id, index);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                //_showDialog();
                                //_deleteToDo(_itemList[index].id, index);
                              },
                              child: new ListTile(
                                  title: _itemList[index],
                                  onLongPress: () =>
                                      _updateItem(context, _itemList[index], index),
                                  /*trailing: new Listener(
                                  //key: new Key(_itemList[index].itemName),
                                  child: new Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPointerDown: (pointerEvent) => {}
                                     // _deleteToDo(_itemList[index].id, index),
                                ),*/
                          onTap: () => Navigator.of(context).push(
                          ControllerDetails.route(_itemList[index].id)
                              ),
                            ),
                            ));
                        })),
                new Divider(
                  height: 1.0,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: CustomFloatingButton(
          onPressed: _showFormDialog,
        )
      /*FloatingActionButton(
        tooltip: "Add new item",
          backgroundColor: Colors.green,
          child: new ListTile(
            title: Icon(Icons.add,color: Colors.black,),
          ),
          onPressed: _showFormDialog),*/
    );
  }

  void _showFormDialog() {
    var alert = new AlertDialog(
      title: Text("Add new Controller"),
      content: Row(
        children: <Widget>[
          new Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new TextFormField(
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Controller Name";
                      }
                    },
                    controller: _textEditingControler,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: "Controller Name",
                      ),
                  ),
                  SizedBox.fromSize(
                    size: Size(0.0, 10.0),
                  ),
                  new TextFormField(
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Controller Number";
                      }
                    },
                    controller: _textEditingControlerNumber,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: "Controller Number",
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new OutlineButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _handleSubmitted(_textEditingControler.text, _textEditingControlerNumber.text);
                _textEditingControler.clear();
                Navigator.pop(context);
              }
            },
            borderSide: BorderSide(color: Colors.green),
            child: Text("Save")),
        new OutlineButton(
            onPressed: () => Navigator.pop(context),
            borderSide: BorderSide(color: Colors.red),
            child: Text("Cancel"))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _updateItem(_, ControllerItem itemList, int index) {
    _textEditingControler.text = itemList.itemName;
    _textEditingControlerNumber.text = itemList.itemNumber;
    var alertUpdate = new AlertDialog(
      title: new Text("Update Controller"),
      content: new Row(
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new TextFormField(
                    autovalidate: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter updated name";
                      }
                    },
                    controller: _textEditingControler,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: "Update Item",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            const Radius.circular(0.0),
                          )),),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new TextFormField(
                    autovalidate: true,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter updated number";
                      }
                    },
                    controller: _textEditingControlerNumber,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: "Update Item",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            const Radius.circular(0.0),
                          )),),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new OutlineButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                ControllerItem newItemUpdated = ControllerItem.fromMap({
                  "itemName": _textEditingControler.text,
                  "itemNumber": _textEditingControlerNumber.text,
                  "dateCreated": dateFormatted(),
                  "id": itemList.id
                });

                //Redrawing the Screen
                _handelSubmittedUpdate(index, newItemUpdated);
                await db.updateItems(newItemUpdated); // Updating the Item*/
                setState(() {
                  _readTodoList(); // Redrawing the screen with all item saved in db
                });
                _textEditingControler.clear();
                _textEditingControlerNumber.clear();
                Navigator.pop(context);

              }
            },
            borderSide: BorderSide(color: Colors.green),
            child: new Text(
              "Update",
            )),
        new OutlineButton(
            onPressed: () {
              Navigator.pop(context);
              _textEditingControler.clear();
              _textEditingControlerNumber.clear();
            },
            borderSide: BorderSide(color: Colors.redAccent),

            child: new Text("Cancel"))
      ],
    );
    showDialog(
        context: (context),
        builder: (_) {
          return alertUpdate;
        });
  }

  _readTodoList() async {
    List items = await db.getItems();
    items.forEach((addedItems) {
      ControllerItem todoitems = ControllerItem.fromMap(addedItems);

      setState(() {
        _itemList.add(todoitems);
      });

      print("DB items: ${todoitems.itemName}");
      print("DB items: ${todoitems.itemNumber}");
    });
  }

  _deleteToDo(int id, int index) async {
    await db.deleteItems(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  void _handelSubmittedUpdate(int index, ControllerItem todoItemList) async {
    setState(() {
      _itemList.removeWhere((element) {
        _itemList[index].itemName == todoItemList.itemName;
        _itemList[index].itemNumber == todoItemList.itemNumber;
      });
      //_readTodoList();
    });
  }

// Delete Controller
/*void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Controller"),
          content: new Text("Are you sure you want to delete this controller?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                _deleteToDo(_itemList[index].id, index),
              },
            ),
          ],
        );
      },
    );
  }*/
}


//Custom Floating Button
class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.cyan,
      splashColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 13.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(Icons.add),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "ADD CONTROLLER",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
