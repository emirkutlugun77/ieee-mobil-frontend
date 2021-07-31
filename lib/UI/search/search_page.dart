import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:line_icons/line_icon.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:my_app/Functions/search.dart';

enum searchState { FOUND, LOOKING, NO_RESULTS, INIT }

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

ListBox? result;

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
                    return Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28.0, vertical: 8),
                              child: Text(
                                result!.committees.length > 0
                                    ? 'Komiteler'
                                    : '',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ],
                        ),
                        Builder(builder: (context) {
                          if (result!.committees.length > 0) {
                            return Flexible(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: result!.committees.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 28),
                                      child: Container(
                                        color: Colors.white,
                                        child: GFListTile(
                                            avatar: CachedNetworkImage(
                                              imageUrl: result!
                                                  .committees[index].photo,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            title: Text(
                                                result!.committees[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        color: Colors.black)),
                                            icon: LineIcon.chevronRight(
                                              color: Colors.black,
                                            )),
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28.0, vertical: 8),
                              child: Text(
                                result!.events.length > 0 ? 'Etkinlikler' : '',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ],
                        ),
                        Builder(builder: (context) {
                          if (result!.events.length > 0) {
                            return Flexible(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: result!.events.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 28),
                                      child: Container(
                                        color: Colors.white,
                                        child: GFListTile(
                                            avatar: CachedNetworkImage(
                                              imageUrl:
                                                  result!.events[index].photo,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            title: Text(
                                                result!.events[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        color: Colors.black)),
                                            icon: LineIcon.chevronRight(
                                              color: Colors.black,
                                            )),
                                      ),
                                    );
                                  }),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                      ],
                    );
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
          if (query == '') {
            status = searchState.INIT;
          } else {
            searchAll(query).then((value) => setState(() {
                  result = value;
                  status = searchState.FOUND;
                }));
          }
        });
      },
      builder: (context, transition) {
        return SizedBox();
      },
    );
  }
}
