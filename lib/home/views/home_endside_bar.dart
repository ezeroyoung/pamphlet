import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class HomeEndSideBar extends Sidebar {
  HomeEndSideBar()
      : super(
            startWidth: 200,
            minWidth: 200,
            maxWidth: 300,
            shownByDefault: false,
            builder: (context, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: const Image(
                      image: AssetImage('resources/images/logo.png'),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(15.0)),
                  const Text('Hello everyone!')
                ],
              );
            });
}
