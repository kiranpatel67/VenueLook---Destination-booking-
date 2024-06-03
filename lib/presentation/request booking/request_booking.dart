import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class RequestBookings extends StatefulWidget {
  const RequestBookings({super.key});

  @override
  _RequestBookingsState createState() {
    return _RequestBookingsState();
  }
}

class _RequestBookingsState extends State<RequestBookings> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutomaticPageChange();
  }

  void _startAutomaticPageChange() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (_currentPage < _pageController.page! + 1) {
          // Move to the next page
          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        } else {
          // Go back to the first page
          _pageController.jumpToPage(0);
        }
        _startAutomaticPageChange();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Check if args are not null and contain the required information
    if (args != null && args.containsKey('index') && args.containsKey('property_images') && args.containsKey('property_name')) {
      final int index = args['index'] as int;
      final List<List<String>> propertyImagesList = args['property_images'] as List<List<String>>;
      final String property = args['property_name'] as String;
      final String cityName = args['city'] as String;

      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            PageView.builder(
              controller: _pageController,
              itemCount: propertyImagesList[index].length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index % propertyImagesList[index].length;
                });
                if (index == propertyImagesList[index].length - 1) {
                  // Last page is reached, jump back to the first page
                  _pageController.jumpToPage(0);
                }
              },
              itemBuilder: (context, imageIndex) {
                String imageUrl = propertyImagesList[index][imageIndex];
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                );
              },
            ),
            // Light overlay
            Container(
              color: Colors.black.withOpacity(0.3), // Adjust the opacity as needed
            ),
            // Dots indicator
            Positioned(
              top: screenheight * 0.06,
              right: screenwidth * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  propertyImagesList[index].length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: screenwidth*0.03,
                    height: screenheight*0.015,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: screenheight*0.25),
                child: Column(
                  children: [
                    Text(
                      property,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 40.0,
                      ),
                      overflow: TextOverflow.clip, // Allow text to overflow and wrap to the next line
                    ),
                    SizedBox(height:  screenheight*0.015),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        cityName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ), // Allow text to overflow and wrap to the next line
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: screenwidth * 0.02),

            SlidingUpPanel(
              minHeight: screenheight * 0.08,
              maxHeight: screenheight * 0.8,
              panel: const Center(
                child: Text('Panel Content'),
              ),
              collapsed: Container(
                decoration: const BoxDecoration(
                    color: Colors.green,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                              ' ',
                              style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          '',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "REQUEST BOOKING",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenheight * 0.02
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            ),
          ],
        ),
      );
    } else {
      // Handle the case where args are null or don't contain the required information
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Invalid arguments'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
