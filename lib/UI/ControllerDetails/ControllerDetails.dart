import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:autoaqua/UI/TopLevel/HomePage.dart';
import 'package:sms/sms.dart';
import 'package:autoaqua/UI/Controller.dart';
import 'package:autoaqua/UI/ControllerDetails/ConfigurationPage.dart';
import 'package:autoaqua/UI/ControllerDetails/EditNumberPage.dart';
import 'package:autoaqua/UI/Widgets/HeroAppBar.dart';
import 'package:autoaqua/UI/ControllerDetails/ValvesPage.dart';
import 'package:autoaqua/UI/ControllerDetails/FoggerPage.dart';
import 'package:autoaqua/UI/ControllerDetails/IRRPage.dart';
import 'package:autoaqua/UI/ControllerDetails/ProgramPage.dart';
import 'package:autoaqua/UI/ControllerDetails/SetClockTimePage.dart';
import 'package:autoaqua/UI/ControllerDetails/StatusPage.dart';
import 'package:autoaqua/UI/ControllerDetails/TimerPage.dart';
import 'package:autoaqua/Utils/APICallMethods.dart';
import 'package:autoaqua/Utils/CommonlyUserMethod.dart';
import 'package:autoaqua/Utils/Database_Client.dart';
import 'package:autoaqua/Utils/TestMsg.dart';
import 'package:flutter/material.dart';

class ControllerDetails extends StatefulWidget {
  static Route<dynamic> route(int controllerId, String controllerName) {
    return MaterialPageRoute(
      builder: (context) => ControllerDetails(controllerId: controllerId, controllerName: controllerName),
    );
  }

  const ControllerDetails({
    Key key,
    @required this.controllerId,
    @required this.controllerName,
  }) : super(key: key);

  final int controllerId;
  final String controllerName;

  @override
  ControllerDetailsState createState() => ControllerDetailsState();

  static void navigateToNext(BuildContext context) {
    navigateToPage(context, ControllerDetailsPageRoute.of(context)?.pageId?.nextPageId);
  }

  static void navigateToPage(BuildContext context, ControllerDetailsPageId pageId) {
    _currentState(context)?.navigateToPage(pageId);
  }

  static ControllerDetailsState _currentState(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<ControllerDetailsState>());
  }
}

class ControllerDetailsState extends State<ControllerDetails> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  StateSetter _setAppBarState;
  String _title;
  List<Widget> _actions;

  void navigateToPage(ControllerDetailsPageId pageId) {
    final nav = _navigatorKey.currentState;
    nav.popUntil((route) => route is ControllerDetailsMainRoute);
    if (pageId != null) {
      nav.push(pageId.builder(widget.controllerId, widget.controllerName));
    }
  }

  void setCurrentPageId(ControllerDetailsPageId pageId) {
    scheduleMicrotask(() => _setAppBarState(() {
          //_title = pageId?.name + '-${widget.controllerName}'?? '${widget.controllerName} - DETAILS';
          _title = pageId?.name ?? '${widget.controllerName.toUpperCase()} - DETAILS';

          final nextPageId = pageId?.nextPageId;
          if (nextPageId != null) {
            _actions = <Widget>[
              IconButton(
                onPressed:() => navigateToPage(nextPageId),
                icon: Icon(Icons.arrow_forward_ios),
                //icon: Icon(nextPageId != null ? nextPageId.icon : Icons.arrow_forward_ios),
              )
            ];
          } else {
            _actions = null;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            _setAppBarState = setState;
            return HeroAppBar(
              leading: IconButton(
                icon: const BackButtonIcon(),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: () async {
                  final poped = await _navigatorKey.currentState.maybePop();
                  if (!poped) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              title: _title,
              actions: _actions,
              padding: EdgeInsets.only(top: mediaQuery.padding.top),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Images/dashboardbackgroung.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Navigator(
          key: _navigatorKey,
          observers: [_ControllerDetailsNavObserver(this)],
          onGenerateRoute: (RouteSettings settings) =>
          (settings.isInitialRoute ? ControllerDetailsMainRoute(widget.controllerId) : null),
        ),
      ),
      bottomNavigationBar: Hero(
        tag: 'controller-details-bottom-nav',
        child: Container(
          //color: Color.fromRGBO(0, 84, 179, 1.0),
          decoration: BoxDecoration(color: Color.fromRGBO(0, 84, 179, 1.0), boxShadow: [
            BoxShadow(offset: Offset(0.0, 8.0), blurRadius: 16.0, spreadRadius: 0.0),
          ]),
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: showPopupDrawer,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _navigatorKey.currentState.popUntil((route) => route is ControllerDetailsMainRoute);
                      }),
                  IconButton(
                    icon: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pushReplacement(HomePage.route()),//Navigator.of(context).pop(),
                  ),
                  //IconButton(icon: Icon(Icons.search), onPressed: () {},),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showPopupDrawer() {
    showModalBottomSheet<Null>(
      context: context,
      builder: (BuildContext context) {
        return Drawer(
          child: ListView.builder(
            itemCount: ControllerDetailsPageId.ids.length,
            itemBuilder: (BuildContext context, int index) {
              final pageId = ControllerDetailsPageId.ids[index];
              return Container(
                color: Colors.lightBlueAccent,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    navigateToPage(pageId);
                  },
                  leading: pageId.icon,
                  title: Text(pageId.name),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ControllerDetailsNavObserver extends NavigatorObserver {
  final ControllerDetailsState state;

  _ControllerDetailsNavObserver(this.state);

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    _updateByRoute(route);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    _updateByRoute(previousRoute);
  }

  void _updateByRoute(Route route) {
    if (route is ControllerDetailsPageRoute) {
      state.setCurrentPageId(route.pageId);
    } else if (route is ControllerDetailsMainRoute) {
      state.setCurrentPageId(null);
    }
  }
}

class SubmitPage extends StatefulWidget {

  final int controllerID;
  SubmitPage(this.controllerID);

  @override
  _SubmitPageState createState() => new _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  bool submitting = false;
  double progress = 0.0;

  void toggleSubmitState() {
    setState(() {
      submitting = !submitting;
    });
  }

  onChange(double val){
    setState(() {
      progress = val;
      print("Val is : $val");
    });
  }

  Future<void> _onSMSButtonPress() {
    double _progress = 50.0;
    var db = new DataBaseHelper();
    return db.getStringData(widget.controllerID).then((stringData) {
      if (stringData != null) {
        for (int i = 0; i < stringData.length; i++) {
          onChange(_progress + i);
          print("Val is : $progress");
          final model = stringData[i];
          sleep(const Duration(seconds: 5));
          print("String is ${model.controllerString}");
          sendSmsForAndroid(model.controllerString, widget.controllerID);
          showPositiveToast("SMS sent for ${model.stringType}");
        }
      } else {
        showPositiveToast("No data avaliable to send sms.") ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "SEND STRING",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            onPressed: (){
              toggleSubmitState();
              sleep(const Duration(seconds: 1));
              _onSMSButtonPress();
              Navigator.of(context).pop();
            },
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.textsms,
                    color: Colors.white,
                  ),
                  Text(
                    "Mobile SMS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    "NOTE: This will send all values one by on via sms.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          //Image(image: new AssetImage("Images/loading.gif"),height: 40.0,width: 90.0,),
          !submitting
              ? RaisedButton(
                  onPressed: () {},
                  color: Colors.indigo,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.cloud_done,
                          color: Colors.white,
                        ),
                        Text(
                          "Cloud",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        Text(
                          "NOTE: This will send all values together via Internet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
            mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Please wait while we are sending the SMS...",textAlign: TextAlign.center,style: TextStyle(
                      //color: Colors.indigo
                    ),),
                    Icon(Icons.textsms,color: Colors.indigo,),
                    //Image(image: new AssetImage("Images/loading.gif"),height: 40.0,width: 90.0,)
                  ],
                )
        ],
      ),
    );
  }
}

class _ControllerDetailsMainPage extends StatefulWidget {
  final int controllerID;
  _ControllerDetailsMainPage(this.controllerID);

  @override
  _ControllerDetailsMainPageState createState() => _ControllerDetailsMainPageState();
}

class _ControllerDetailsMainPageState extends State<_ControllerDetailsMainPage> {
  APIMethods apiMethods = new APIMethods();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
            child: Scrollbar(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 5.0,
                padding: const EdgeInsets.all(4.0),
                children: ControllerDetailsPageId.ids.map((pageId) {
                  return _ControllerDetailsButton(
                    icon: pageId.icon,
                    text: pageId.name,
                    onPressed: () => ControllerDetails.navigateToPage(context, pageId),
                  );
                }).toList(growable: false),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 20.0),
          child: RawMaterialButton(
            onPressed: () {
              _showDialog();
              /*//Navigator.of(context).pop();
              //msgString.getDataforConfiguration(1);
              //getFoggerData();
              //Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MyAppSMS()));
              apiMethods.onOffPouseController(
                widget.controllerID,
                "1"
              );
              print("Controller Id is ${widget.controllerID}");*/
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "SEND",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            fillColor: Color.fromRGBO(0, 84, 179, 1.0),
            shape: StadiumBorder(),
          ),
        ),
      ],
    );
  }

  var _configuration;
  var fmax;
  DataBaseHelper dataBaseHelper = new DataBaseHelper();
  void getFoggerData() {
    dataBaseHelper.getFoggerDetailsforConfig(1).then((data) {
      fmax = data.fogger_maxRTU;
      _configuration = data.fogger_foggerDelay;

      print("MaxFogger: $fmax \n FDelay: $_configuration");
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SubmitPage(widget.controllerID);
        });
  }
}

class _ControllerDetailsButton extends StatelessWidget {
  const _ControllerDetailsButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final ImageIcon icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      //color: Colors.lightBlueAccent,
      //shape: CircleBorder(),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(0, 84, 179, 1.0), width: 2.0, style: BorderStyle.solid),
                    shape: BoxShape.circle,
                    color: Colors.transparent //Color.fromRGBO(0, 84, 179, 1.0),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: this.icon,
                )),
          ),
          SizedBox(height: 8.0),
          Expanded(
            flex: 2,
            child: Text(
              this.text,
              style: TextStyle(fontSize: 15.0),
              textAlign: TextAlign.center,
              textScaleFactor: 0.85,
            ),
          )
        ],
      ),
      onPressed: this.onPressed,
    );
  }
}

class ControllerDetailsPageFrame extends StatefulWidget {
  const ControllerDetailsPageFrame({
    Key key,
    this.title,
    @required this.child,
    this.hasBackground = false,
  }) : super(key: key);

  final String title;
  final Widget child;
  final bool hasBackground;

  @override
  _ControllerDetailsPageFrameState createState() => _ControllerDetailsPageFrameState();
}

class _ControllerDetailsPageFrameState extends State<ControllerDetailsPageFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Images/dashboardbackgroung.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: widget.child
    );
  }
}

class ControllerDetailsMainRoute extends MaterialPageRoute {
  final int controllerID;
  ControllerDetailsMainRoute(this.controllerID)
      : super(
          builder: (context) => _ControllerDetailsMainPage(controllerID),
        );
}

class ControllerDetailsPageRoute extends MaterialPageRoute {
  ControllerDetailsPageRoute({
    @required this.pageId,
    @required WidgetBuilder builder,
  }) : super(builder: builder);

  final ControllerDetailsPageId pageId;

  static ControllerDetailsPageRoute of(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route is ControllerDetailsPageRoute) {
      return route;
    }
    return null;
  }
}

typedef ControllerDetailsRouteBuilder = Route<dynamic> Function(int controllerId, String controllerName);

class ControllerDetailsPageId {
  static const CONFIGURATION = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/settings.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'CONFIGURATION',
    ConfigurationPage.route,
  );

  static const PROGRAM = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/menu.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'PROGRAM',
    ProgramPage.route,
  );

  static const VALVES = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/valve_1.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'VALVES',
    ValvesPage.route,
  );

  static const TIMER = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/recycle.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'SCHEDULES',
    TimerPage.route,
  );

  static const FOGGER = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/sprinkler.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'FOGGER',
    FoggerPage.route,
  );

  static const STATUS = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/flag.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'STATUS',
    StatusPage.route,
  );

  static const IRR_STOP = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/irrstop.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'IRR STOP',
    IRRPage.route,
  );

  static const SET_TIME = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/setclock.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'SET CLOCK TIME',
    SetClockTimePage.route,
  );

  static const EDIT_NUMBER = const ControllerDetailsPageId(
    ImageIcon(
      AssetImage('Images/changenumber_icon.png'),
      color: Color.fromRGBO(0, 84, 179, 1.0),
      size: 40.0,
    ),
    'SET NUMBER',
    EditNumberPage.route,
  );

  ControllerDetailsPageId get nextPageId {
    final nextIndex = ids.indexOf(this) + 1;
    return (nextIndex < ids.length) ? ids[nextIndex] : null;
  }

  static const ids = const <ControllerDetailsPageId>[
    CONFIGURATION,
    PROGRAM,
    VALVES,
    TIMER,
    FOGGER,
    STATUS,
    IRR_STOP,
    SET_TIME,
    EDIT_NUMBER,
  ];

  const ControllerDetailsPageId(this.icon, this.name, this.builder);

  final ImageIcon icon;
  final String name;
  final ControllerDetailsRouteBuilder builder;
}
