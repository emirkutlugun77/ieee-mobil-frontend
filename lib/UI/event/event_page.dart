import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_app/Functions/events.dart';
import 'package:my_app/UI/event/single_event.dart';
import 'package:my_app/UI/models/event.dart';
import 'package:my_app/UI/models/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Events extends StatefulWidget {
  final List<Event> events;
  final User user;
  Events({required this.events, required this.user});
  @override
  _EventsState createState() => _EventsState();
}

bool loading = true;

class _EventsState extends State<Events> {
  int page = 0;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 58.0 * height / 1000,
                left: 58.0 * height / 1000,
                right: 58.0 * height / 1000,
                bottom: 18.0 * height / 1000),
            child: Row(
              children: [
                Text(
                  'Etkinlikler',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmartRefresher(
                enablePullUp: true,
                enablePullDown: false,
                onLoading: _onLoading,
                controller: _refreshController,
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  itemCount: widget.events.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleEvent(
                                  event: widget.events[index],
                                  user: widget.user)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Hero(
                        tag: widget.events[index].photo,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: widget.events[index].photo,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index.isEven ? 3 : 2),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onLoading() async {
    page++;
    // monitor network fetch
    await getAllEvents(page).then((value) => value.forEach((e) {
          if (!widget.events.contains(e)) {
            widget.events.add(e);
          }
        }));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}
