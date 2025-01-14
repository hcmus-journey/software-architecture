import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/models/events_model.dart';
import 'package:voumarketinggame/pages/event_detail_page.dart';
import 'package:voumarketinggame/pages/event_viewall_page.dart';
import 'package:voumarketinggame/pages/menu_page.dart';
import 'package:voumarketinggame/pages/voucherlist_page.dart';
import 'package:voumarketinggame/pages/wishlist_page.dart';
import 'package:voumarketinggame/providers/bottom_navigation_provider.dart';
import 'package:voumarketinggame/providers/events_provider.dart';
import 'package:voumarketinggame/widgets/appbar_widget.dart';
import 'package:voumarketinggame/widgets/bottom_navigation_widget.dart';
import 'package:voumarketinggame/widgets/carousel_slider_widget.dart';
import 'package:voumarketinggame/widgets/event_section_widget.dart';

class ContentDashboard extends StatefulWidget {
  const ContentDashboard({super.key});

  @override
  State<ContentDashboard> createState() => _ContentDashboard();
}

class _ContentDashboard extends State<ContentDashboard> {
  
  String typeEvent1 = 'Sự kiện đang diễn ra';
  String typeEvent2 = 'Sự kiện sắp diễn ra';
  String typeEvent4 = 'Sự kiện đã kết thúc';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    await eventProvider.fetchAllEvents(context);
    setState(() {
      _isLoading = false;
    });
  }

  List<EventModel> _filterEvents(List<EventModel> events, String type) {
    final now = DateTime.now();
    switch (type) {
      case 'ongoing':
        return events.where((e) =>
            DateTime.parse(e.startTime).isBefore(now) &&
            DateTime.parse(e.endTime).isAfter(now)).toList();
      case 'upcoming':
        return events.where((e) => DateTime.parse(e.startTime).isAfter(now)).toList();
      case 'ended':
        return events.where((e) => DateTime.parse(e.endTime).isBefore(now)).toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    //final eventProviderTest = Provider.of<EventProviderData>(context);
    final eventProvider = Provider.of<EventProvider>(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (eventProvider.errorMessage != null) {
      return Center(child: Text(eventProvider.errorMessage!));
    }

    if (eventProvider.events.isEmpty) {
      return const Center(child: Text("No events available."));
    }

    final ongoingEvents = _filterEvents(eventProvider.events, 'ongoing');
    final upcomingEvents = _filterEvents(eventProvider.events, 'upcoming');
    final endedEvents = _filterEvents(eventProvider.events, 'ended');

    return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              const SizedBox(height: 20),
              const CarouselSliderWidget(),
              const SizedBox(height: 10),
              
              EventSection(
                time: typeEvent1,
                items: ongoingEvents,
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventViewallScreen(
                        events: ongoingEvents,
                        eventType: typeEvent2,
                      ),
                    ),
                  );
                },
                onItemTap: (event) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: event, eventType: typeEvent1,),
                    ),
                  );
                },
              ),
              
              EventSection(
                time: typeEvent2,
                items: upcomingEvents,
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventViewallScreen(
                        events: upcomingEvents,
                        eventType: typeEvent2,
                      ),
                    ),
                  );
                },
                onItemTap: (event) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: event, eventType: typeEvent2,),
                    ),
                  );
                },
              ),
              
              EventSection(
                time: typeEvent4,
                items: endedEvents,
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventViewallScreen(
                        events: endedEvents,
                        eventType: typeEvent2,
                      ),
                    ),
                  );
                },
                onItemTap: (event) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: event, eventType: typeEvent4,),
                    ),
                  );
                },
              ),
            ],
          ),
        );
  }

}

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashboardScreen> {

  final List<Widget> _pagesContent = [
    const ContentDashboard(), 
    const WishlistScreen(), 
    const VoucherlistScreen(),
    const MenuScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavigationProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const CustomAppBar(),
        body: _pagesContent[bottomNavProvider.currentIndex],
        bottomNavigationBar: BottomNavBar(
          currentIndex: bottomNavProvider.currentIndex,
          onTap: (index) {
            bottomNavProvider.updateIndex(index); 
          },
        ),
    )
    );
  }
}
