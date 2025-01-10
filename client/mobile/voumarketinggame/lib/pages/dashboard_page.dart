import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/pages/event_detail_page.dart';
import 'package:voumarketinggame/pages/event_viewall_page.dart';
import 'package:voumarketinggame/pages/voucherlist_page.dart';
import 'package:voumarketinggame/pages/wishlist_page.dart';
import 'package:voumarketinggame/providers/bottom_navigation_provider.dart';
import 'package:voumarketinggame/providers/event_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              const SizedBox(height: 20),
              const CarouselSliderWidget(),
              const SizedBox(height: 10),
              
              EventSection(
                
                time: typeEvent1,
                items: eventProvider.getOngoingEvents(),
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventViewallScreen(
                        events: eventProvider.getOngoingEvents(),
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
                items: eventProvider.getUpcomingEvents(),
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventViewallScreen(
                        events: eventProvider.getUpcomingEvents(),
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
                items: eventProvider.getEndedEvents(),
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventViewallScreen(
                        events: eventProvider.getEndedEvents(),
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
    const Center(child: Text('Menu Page')), 
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
