
import 'package:flutter/material.dart';


class HeroAppBar extends StatelessWidget implements PreferredSizeWidget {

  const HeroAppBar({
    Key key,
    this.leading,
    this.title,
    this.actions,
    this.padding = EdgeInsets.zero,
    this.duration = const Duration(milliseconds: 450),
  }) : super(key: key);

  final Widget leading;
  final String title;
  final List<Widget> actions;
  final EdgeInsets padding;
  final Duration duration;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'app-bar',
      child: Material(
        elevation: 4.0,
        color: Color.fromRGBO(0, 84, 179, 1.0),
        child: Padding(
          padding: padding,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: _buildAppBar(context),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: kToolbarHeight,
      child: IconTheme(
        data: theme.primaryIconTheme,
        child: DefaultTextStyle(
          style: theme.primaryTextTheme.title,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedSwitcher(
                duration: duration,
                child: title != null ? Text(title,
                  key: ValueKey<String>(title),
                ) : SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  leading != null ? leading : SizedBox(),
                  AnimatedSwitcher(
                    duration: duration,
                    child: actions != null ? Row(
                      key: ObjectKey(actions),
                      mainAxisSize: MainAxisSize.min,
                      children: actions,
                    ) : SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}