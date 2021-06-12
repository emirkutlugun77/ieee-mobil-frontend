import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_app/UI/event/single_event.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE6EAF1).withOpacity(0.1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 58.0, left: 58, right: 58),
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
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleEvent(index: index)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Hero(
                      tag: 'event${index + 1}',
                      child: Image.asset(
                        'images/ev${index + 1}.jpg',
                        fit: BoxFit.fill,
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
          )
        ],
      ),
    );
  }
}
