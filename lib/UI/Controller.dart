import 'dart:ui';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/sharedPref.dart';
import 'package:http/http.dart' as http;
import 'package:autoaqua/Model/ControllerItems.dart';
import 'package:autoaqua/UI/ControllerDetails/ControllerDetails.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';

class Controller extends StatefulWidget {

  const Controller({
    Key key,
    @required this.HUId,
  }) : super(key: key);

  final int HUId;

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  final TextEditingController _textEditingControler = new TextEditingController();
  final TextEditingController _textEditingControlerNumber = new TextEditingController();
  var db = new DataBaseHelper();
  final List<ControllerItem> _itemList = <ControllerItem>[];

  APIMethods apiMethods = APIMethods();
  Future _loading;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loading = _readTodoList();
  }

  void _handleSubmitted(int HUId,String text, String number) async {
//    _textEditingControler.clear();
//    _textEditingControlerNumber.clear();

    ControllerItem doItems = new ControllerItem(HUId, text, number, dateFormatted());
    int saveItemId = await db.saveItem(doItems);

    ControllerItem addedItems = await db.getItem(saveItemId);

    setState(() {
      _itemList.add(addedItems);
    });
  }

  //Method to delete the controller
  deleteController(index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            children: <Widget>[Icon(Icons.delete), Text("Delete Controller")],
          ),
          content: new Text("Are you sure you want to delete this controller?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.redAccent,
              onPressed: () {
                _deleteToDo(_itemList[index].id, index);
                Navigator.of(context).pop();
                showPositiveToast("Deleted Succesfully");
              },
            ),
            FlatButton(
              child: new Text(
                "CLOSE",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loading,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return BuildControllerContent(context);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }

   Widget BuildControllerContent(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("New Controller"),
        backgroundColor: Color.fromRGBO(0, 84, 179, 1.0),
      ),
      backgroundColor: Colors.grey.shade200.withOpacity(0.8),
      body: Container(
        decoration: BoxDecoration(
          image:  DecorationImage(
            image: AssetImage("Images/dashboardbackgroung.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _itemList.length == 0?Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Nothing Here",style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),),
              Container(
                margin: EdgeInsets.all(10.0),
                decoration: ShapeDecoration(shape: CircleBorder(),color: Color.fromRGBO(0, 84, 179, 1.0),),
                //color: Colors.blueAccent,
                child: IconButton(icon: Icon(Icons.add,size: 30.0,color: Colors.white,), onPressed: ()=>_showFormDialog()),
              ),
              Text("Add new Controller to get started.",style: TextStyle(
                  color: Colors.black
              ),)
            ],
          ):Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                flex: 1,
                child: RaisedButton.icon(
                    onPressed: () {
                      _showFormDialog();
                      print("Test Controller");
                    },
                    shape: StadiumBorder(),
                    color: Color.fromRGBO(0, 84, 179, 1.0),
                    //disabledColor: Color.fromRGBO(0, 84, 179, 1.0),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    //textColor: Colors.white,
                    label: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "ADD NEW CONTROLLER",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    )),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child:ListView.builder(
                            reverse: false,
                            itemCount: _itemList.length,
                            itemBuilder: (_, int index) {
                              return new Card(
                                  color: Colors.white,
                                  child: InkWell(
                                    child: new ListTile(
                                      title: _itemList[index],
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Color.fromRGBO(0, 84, 179, 1.0),
                                              ),
                                              onPressed: () {
                                                print("Edit Click");
                                                _updateItem(context, _itemList[index], index);
                                              }),
                                          //SizedBox(width: 20.0,),
                                          IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Color.fromRGBO(0, 84, 179, 1.0),
                                              ),
                                              onPressed: () {
                                                print("Delete Click");
                                                deleteController(index);
                                              })
                                        ],
                                      ),
                                      onTap: () => Navigator.of(context).push(
                                          ControllerDetails.route(_itemList[index].id, _itemList[index].itemName)),
                                    ),
                                  ));
                            }),
                      ),
                      new Divider(
                        height: 1.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      /*floatingActionButton: CustomFloatingButton(
          onPressed: _showFormDialog,
        )*/
    );
  }

  void _showFormDialog() {
    var alert = new AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.add),
          Text("Add new Controller"),
        ],
      ),
      content: Row(
        children: <Widget>[
          new Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Controller Name",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter Controller Name";
                        }
                      },
                      controller: _textEditingControler,
                      autofocus: true,
                      decoration: new InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Controller Mob No.",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter Controller Number";
                        }
                      },
                      controller: _textEditingControlerNumber,
                      autofocus: true,
                      decoration: new InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        RawMaterialButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _handleSubmitted(widget.HUId,_textEditingControler.text, _textEditingControlerNumber.text);
                await print("LoginToken ${SharedPref().getToken()}");
                //apiMethods.saveDataToServer(_textEditingControler.text, _textEditingControlerNumber.text);
                _textEditingControler.clear();
                _textEditingControlerNumber.clear();
                Navigator.pop(context);
              }
            },
            fillColor: Colors.green,
            child: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            )),
        RawMaterialButton(
            onPressed: () => Navigator.pop(context),
            fillColor: Colors.red,
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white),
            ))
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
      title: Row(
        children: <Widget>[
          Icon(Icons.edit),
          Text("Update Controller"),
        ],
      ),
      content: Row(
        children: <Widget>[
          new Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Controller Name",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter Controller Name";
                        }
                      },
                      controller: _textEditingControler,
                      autofocus: true,
                      decoration: new InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Controller Mob No.",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter Controller Number";
                        }
                      },
                      controller: _textEditingControlerNumber,
                      autofocus: true,
                      decoration: new InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        RawMaterialButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                ControllerItem newItemUpdated = ControllerItem.fromMap({
                  "columnHUId":widget.HUId,
                  "itemName": _textEditingControler.text,
                  "itemNumber": _textEditingControlerNumber.text,
                  "dateCreated": dateFormatted(),
                  "id": itemList.id
                });

                //Redrawing the Screen
                //apiMethods.updateControllerOnServer(_textEditingControler.text, _textEditingControlerNumber.text,itemList.id);
                _handelSubmittedUpdate(index, newItemUpdated);
                await db.updateItems(newItemUpdated); // Updating the Item*/
                setState(() {
                  _readTodoList(); // Redrawing the screen with all item saved in db
                });
                _textEditingControler.clear();
                _textEditingControlerNumber.clear();
                Navigator.pop(context);
                showPositiveToast("Updated Succesfully");
              }
            },
            fillColor: Colors.green,
            child: Text(
              "UPDATE",
              style: TextStyle(color: Colors.white),
            )),
        RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
              _textEditingControler.clear();
              _textEditingControlerNumber.clear();
            },
            fillColor: Colors.red,
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
    showDialog(
        context: (context),
        builder: (_) {
          return alertUpdate;
        });
  }

  _readTodoList() async {
    List items = await db.getItems(widget.HUId);
    await db.getALLItems();
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
/*class CustomFloatingButton extends StatelessWidget {
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
}*/
