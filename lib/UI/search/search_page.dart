import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:line_icons/line_icon.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

enum searchState { FOUND, LOOKING, NO_RESULTS, INIT }

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool queryOn = false;
  var status = searchState.INIT;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6EAF1).withOpacity(0.1),
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding:
                EdgeInsets.all(38.0 * MediaQuery.of(context).size.height / 700),
            child: buildFloatingSearchBar(context),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 118.0 * MediaQuery.of(context).size.height / 700),
            child: Center(
              child: Builder(builder: (context) {
                if (status == searchState.LOOKING) {
                  return LoadingFlipping.square(
                    borderColor: Theme.of(context).primaryColor,
                    size: 30.0,
                  );
                } else {
                  if (status == searchState.INIT) {
                    return Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/search.png',
                              width: MediaQuery.of(context).size.width / 1.7,
                              height: MediaQuery.of(context).size.width / 1.7),
                          Text(
                            'Arama Yaparak İstediğinize Anında Ulaşın!',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontSize: 30 *
                                          MediaQuery.of(context).size.height /
                                          1000,
                                    ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  } else if (status == searchState.FOUND) {
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.accents[index],
                                child: GFListTile(
                                    title: Text('Title',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(color: Colors.white)),
                                    subTitle: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    icon: LineIcon.chevronRight(
                                      color: Colors.white,
                                    )),
                              ),
                            ));
                  } else {
                    return SizedBox();
                  }
                }
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      backgroundColor: Colors.white,
      automaticallyImplyBackButton: false,
      backdropColor: Colors.transparent,
      hint: 'Ara',
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        setState(() {
          status = searchState.LOOKING;

          Future.delayed(Duration(milliseconds: 1000))
              .then((value) => setState(() {
                    status = searchState.FOUND;
                    if (query == '') {
                      status = searchState.INIT;
                    }
                  }));
        });
      },
      builder: (context, transition) {
        return SizedBox();
      },
    );
  }
}
