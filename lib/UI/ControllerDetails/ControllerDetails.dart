import 'dart:async';

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
import 'package:flutter/material.dart';

class ControllerDetails extends StatefulWidget {

  static Route<dynamic> route(int controllerId) {
    return MaterialPageRoute(
      builder: (context) => ControllerDetails(
        controllerId: controllerId,
      ),
    );
  }

  const ControllerDetails({
    Key key,
    @required this.controllerId,
  }) : super(key: key);

  final int controllerId;

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
    if(pageId != null) {
      nav.push(pageId.builder(widget.controllerId));
    }
  }

  void setCurrentPageId(ControllerDetailsPageId pageId) {

    scheduleMicrotask(() => _setAppBarState(() {
      _title = pageId?.name ?? 'Controller Details';

      final nextPageId = pageId?.nextPageId;
      if(nextPageId != null){
        _actions = <Widget>[
          IconButton(
            onPressed: () => navigateToPage(nextPageId),
            icon: Icon(nextPageId != null ? nextPageId.icon : Icons.arrow_forward_ios),
          )
        ];
      }else{
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
                  if(!poped){
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
          observers: [ _ControllerDetailsNavObserver(this) ],
          onGenerateRoute: (RouteSettings settings) => (settings.isInitialRoute
            ? ControllerDetailsMainRoute()
            : null),
        ),
      ),
      bottomNavigationBar: Hero(
        tag: 'controller-details-bottom-nav',
        child: Container(
          //color: Color.fromRGBO(0, 84, 179, 1.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 84, 179, 1.0),
              boxShadow: [
                BoxShadow(offset: Offset(0.0, 8.0), blurRadius: 16.0, spreadRadius: 0.0),
              ]
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white,),
                    onPressed: showPopupDrawer,
                  ),
                  IconButton(
                      icon: Icon(Icons.home, color: Colors.white,),
                      onPressed: () {
                        _navigatorKey.currentState.popUntil((route) => route is ControllerDetailsMainRoute);
                      }
                  ),
                  IconButton(
                    icon: Icon(Icons.dashboard, color: Colors.white,),
                    onPressed: () => Navigator.of(context).pop(),
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
              return ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  navigateToPage(pageId);
                },
                leading: Icon(pageId.icon),
                title: Text(pageId.name),
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
    if(route is ControllerDetailsPageRoute){
      state.setCurrentPageId(route.pageId);
    }
    else if(route is ControllerDetailsMainRoute){
      state.setCurrentPageId(null);
    }
  }
}

class _ControllerDetailsMainPage extends StatefulWidget {
  @override
  _ControllerDetailsMainPageState createState() => _ControllerDetailsMainPageState();
}

class _ControllerDetailsMainPageState extends State<_ControllerDetailsMainPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
              children: ControllerDetailsPageId.ids
                  .map((pageId){
                return _ControllerDetailsButton(
                  icon: pageId.icon,
                  text: pageId.name,
                  onPressed: () => ControllerDetails.navigateToPage(context, pageId),
                );
              })
                  .toList(growable: false),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(56.0, 0.0, 56.0, 65.0),
          child: MaterialButton(
            onPressed: () {
              //Navigator.of(context).pop();
            },
            child: Text("Submit"),
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}


class _ControllerDetailsButton extends StatelessWidget {
  const _ControllerDetailsButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: CircleBorder(),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(this.icon, size: 28.0),
          SizedBox(height: 8.0),
          Text(
            this.text,
            textAlign: TextAlign.center,
            textScaleFactor: 0.85,
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
    this.hasBackground = true,
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
      child: widget.child,
    );
  }
}

class ControllerDetailsMainRoute extends MaterialPageRoute {
  ControllerDetailsMainRoute() : super(
    builder: (context) => _ControllerDetailsMainPage(),
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
    if(route is ControllerDetailsPageRoute){
      return route;
    }
    return null;
  }
}

typedef ControllerDetailsRouteBuilder = Route<dynamic> Function(int controllerId);

class ControllerDetailsPageId {
  static const CONFIGURATION = const ControllerDetailsPageId(
    Icons.settings,
    'CONFIGURATION',
    ConfigurationPage.route,
  );

  static const PROGRAM = const ControllerDetailsPageId(
    Icons.apps,
    'PROGRAM',
    ProgramPage.route,
  );

  static const VALVES = const ControllerDetailsPageId(
    Icons.pages,
    'VALVES',
    ValvesPage.route,
  );

  static const TIMER = const ControllerDetailsPageId(
    Icons.av_timer,
    'TIMER',
    TimerPage.route,
  );

  static const FOGGER = const ControllerDetailsPageId(
    Icons.shuffle,
    'FOGGER',
    FoggerPage.route,
  );

  static const STATUS = const ControllerDetailsPageId(
    Icons.opacity,
    'STATUS',
    StatusPage.route,
  );

  static const IRR_STOP = const ControllerDetailsPageId(
    Icons.stop,
    'IRR STOP',
    IRRPage.route,
  );

  static const SET_TIME = const ControllerDetailsPageId(
    Icons.access_time,
    'SET CLOCK TIME',
    SetClockTimePage.route,
  );

  static const EDIT_NUMBER = const ControllerDetailsPageId(
    Icons.edit,
    'EDIT NUMBER',
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

  final IconData icon;
  final String name;
  final ControllerDetailsRouteBuilder builder;
}
