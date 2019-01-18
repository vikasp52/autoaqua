import 'package:autoaqua/Model/HeadUnitModel.dart';
import 'package:autoaqua/UI/Controller.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:flutter/material.dart';

class HeadUnit extends StatefulWidget {
  @override
  _HeadUnitState createState() => _HeadUnitState();
}

class _HeadUnitState extends State<HeadUnit> {

  final TextEditingController _textEditingControler = new TextEditingController();
  final TextEditingController _textEditingControlerNumber = new TextEditingController();
  var db = new DataBaseHelper();
  final List<HUModel> _itemHUList = <HUModel>[];
  int saveItemId;

  Future _loading;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loading = _readTodoList();
  }

  void _handleSubmitted(String text, String number) async {
//    _textEditingControler.clear();
//    _textEditingControlerNumber.clear();

    HUModel doItems = new HUModel(text, dateFormatted());
    saveItemId = await db.saveHUItem(doItems);
    HUModel addedItems = await db.getHubUnitItem(saveItemId);

    setState(() {
      _itemHUList.add(addedItems);
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
                _deleteToDo(_itemHUList[index].HUId, index);
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

    //return buildHUContent(context);
    return FutureBuilder(
      future: _loading,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return buildHUContent(context);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildHUContent(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade200.withOpacity(0.8),
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("Images/dashboardbackgroung.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _itemHUList.length == 0?Column(
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
              Text("Add new HeadUnit to get started.",style: TextStyle(
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
                        "ADD NEW HEAD UNIT",
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
                            itemCount: _itemHUList.length,
                            itemBuilder: (_, int index) {
                              return new Card(
                                  color: Colors.white,
                                  child: InkWell(
                                    child: new ListTile(
                                        title: _itemHUList[index],
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
                                                  _updateItem(context, _itemHUList[index], index);
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
                                        onTap: () async{
                                          await print("Saved item id of HU: ${_itemHUList[index].HUId}");
                                          await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Controller(HUId: _itemHUList[index].HUId)));
                                        }
                                    ),
                                  ));
                            }),
                      ),
                      Divider(
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
          Text("Add new Head Unit"),
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
                      "HeadUnit Name",
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
                _handleSubmitted(_textEditingControler.text, _textEditingControlerNumber.text);
                //await print("LoginToken ${SharedPref().getToken()}");
                print("Saved item id of HU: $saveItemId");
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

  _updateItem(_, HUModel itemList, int index) {
    _textEditingControler.text = itemList.HUName;
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
                HUModel newItemUpdated = HUModel.fromMap({
                  "HUName": _textEditingControler.text,
                  "HUCreatedDate": dateFormatted(),
                  "HUId": itemList.HUId
                });

                //Redrawing the Screen
                //apiMethods.updateControllerOnServer(_textEditingControler.text, _textEditingControlerNumber.text,itemList.id);
                _handelSubmittedUpdate(index, newItemUpdated);
                await db.updateHUItems(newItemUpdated); // Updating the Item*/
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
    List items = await db.getHeadUnitItems();
    items.forEach((addedItems) {
      HUModel todoitems = HUModel.fromMap(addedItems);

      setState(() {
        _itemHUList.add(todoitems);
      });
      print("DB items: ${todoitems.HUName}");
      print("DB items: ${todoitems.HUCreatedDate}");
    });
  }

  _deleteToDo(int id, int index) async {
    await db.deleteHUItems(id);
    await db.deleteControllerItems(id);
    print("Deleted is $id");
    setState(() {
      _itemHUList.removeAt(index);
    });
  }

  void _handelSubmittedUpdate(int index, HUModel todoItemList) async {
    setState(() {
      _itemHUList.removeWhere((element) {
        _itemHUList[index].HUName == todoItemList.HUName;
        _itemHUList[index].HUCreatedDate == todoItemList.HUCreatedDate;
      });
      //_readTodoList();
    });
  }
}
