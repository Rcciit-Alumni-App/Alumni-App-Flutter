import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/EventsModel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class EventDetails extends StatefulWidget {
  final Eventsmodel? event;
  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isShowingAll = false;
  void isShowingAllFunc() {
    setState(() {
      isShowingAll = !isShowingAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [        
            _buildEventDetailsUI(isShowingAllFunc)
          ],
        ),
      ),
      bottomNavigationBar: const Bottomnavbar(),
    );
  }

  Widget _buildEventDetailsUI(void Function() isShowingAllFunc) {
    List<Widget> imageGrids = _buildImageGrids(['https://cdn.britannica.com/13/77413-050-95217C0B/Golden-Gate-Bridge-San-Francisco.jpg?w=300', 'https://media.cntraveler.com/photos/648397a56702ed16faad7a3b/3:2/w_1600%2Cc_limit/San%2520Francisco%2520Things%2520to%2520Do%2520UPDATE_GettyImages-1406939930.jpg', 'https://media.cntraveler.com/photos/5a99b5c520dfb6552425ecc8/16:9/w_1280,c_limit/san-francisco_GettyImages-600366840.jpg', 'https://media.cntraveler.com/photos/6072054bac52332b71f172b3/1:1/w_1600,c_limit/DDCK8A.jpg', 'https://media.cntraveler.com/photos/6072054bac52332b71f172b3/1:1/w_1600,c_limit/DDCK8A.jpg']);
    // List<Widget> imageGrids = _buildImageGrids(widget.event!.images);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.event!.eventName,
              style: kEventNewsHeading,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),

          Expanded(
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    // widget.event!.bannerImage,
                    'https://media.cntraveler.com/photos/6072054bac52332b71f172b3/1:1/w_1600,c_limit/DDCK8A.jpg',
                    fit: BoxFit.cover,
                    height: 200.0,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                
                Text(
                  'Date: ' + widget.event!.createdAt.toLocal().toIso8601String().split('T')[0],
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                
                Text(
                  'Venue: ' + widget.event!.venue,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 25,),

                Text(
                  widget.event!.announcements.description + ' ' + '✨',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 25,),

                Text(
                  'Schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                
                SizedBox(
                  height: 10,
                ),
                
                Text(
                  widget.event!.schedule,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 25),

                Text(
                  'Event Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 10),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.event!.description.asMap().entries.map((entry) {
                    int index = entry.key;
                    String description = entry.value;

                    return Text(
                      '${index + 1}. $description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),

                imageGrids.isNotEmpty ? const SizedBox(height: 25) : const SizedBox(),

                StaggeredGrid.count(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: !isShowingAll ? imageGrids.length > 4 ? imageGrids.sublist(0, 4) : imageGrids : imageGrids
                ),

                imageGrids.length > 4 ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CustomButton2(label: isShowingAll ? 'See Less' : 'See More', onPressed: isShowingAllFunc),
                ) : const SizedBox(),

                const SizedBox(height: 25),

                Text(
                  widget.event!.attractions.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  widget.event!.attractions.value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),                

                SizedBox(height: 25),

                Text(
                  'Rules',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.event!.rules.asMap().entries.map((entry) {
                    int index = entry.key;
                    String rule = entry.value;

                    return Text(
                      '${index + 1}. $rule',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),

          SizedBox(height: 10.0),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton2(
                label: "Show Interest",
                width: 140,
                height: 55,
                onPressed: () {},
              ),
              SizedBox(width: 10.0),
              CustomButton3(
                label: "Register",
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildImageGrids(List<String> images) {
    int items = images.length;
    List<Widget> grids = [];
    int imageIndex = 0;

    for (int i = 0; i < items ~/ 2; i++) {
      grids.addAll([
        StaggeredGridTile.count(
          crossAxisCellCount: i % 2 == 0 ? 2 : 3,
          mainAxisCellCount: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              images[imageIndex++],
              fit: BoxFit.cover,
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: i % 2 == 0 ? 3 : 2,
          mainAxisCellCount: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              images[imageIndex++],
              fit: BoxFit.cover,
            ),
          ),
        )
      ]);
    }
    
    if (items % 2 != 0) {
      grids.add(
        StaggeredGridTile.count(
          crossAxisCellCount: 5,
          mainAxisCellCount: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              images[imageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return grids;
  }
}
