import 'package:FoGraph/core/extensions/padding_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profile/controller/profile_controller.dart';
import 'package:FoGraph/routes/app_route.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildInfoBox('John Doe', '123-456-7890', 'john.doe@example.com', context),
            SizedBox(height: 16.0),
            _buildActionButtons(context),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/img/profile_bg.jpeg'), // Replace with your image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.26 - 30.0,
          left: MediaQuery.of(context).size.width * 0.15,
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('asset/img/fograph_logo.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(String name, String number, String email, BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.person, name, screenheight),
          _buildInfoRow(Icons.phone, number, screenheight),
          _buildInfoRow(Icons.email, email, screenheight),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value, double screenheight) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, size: screenheight * 0.025, color: Colors.black),
          SizedBox(width: 8.0),
          Text(value, style: TextStyle(fontSize: 18.0)),
        ],
      ),
    ).addPaddingTop(padding: screenheight * 0.015);
  }

  Widget _buildActionButtons(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.27),
      child: GestureDetector(
        onTap: () {
          // Show the bottom sheet to edit the profile
          _showEditProfileBottomSheet(context);
        },
        child: Container(
          height: screenheight * 0.045,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit, color: Colors.black, size: screenheight * 0.025)
                  .addPaddingRight(padding: screenwidth * 0.02),
              Text(
                'EDIT PROFILE',
                style: TextStyle(color: Colors.black, fontSize: screenheight * 0.02),
              ),
            ],
          ),
        ),
      ),
    ).addPaddingTop(padding: screenheight * 0.03);
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        controller.changeTabIndex(index);
        _navigateToPage(index);
      },
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoute.homePage);
        break;
      case 1:
        Get.offAllNamed(AppRoute.bookingsPage);
        break;
      case 2:
        Get.offAllNamed(AppRoute.profilePage);
        break;
    }
  }

  // Function to show the bottom sheet
  void _showEditProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildEditProfileBottomSheet(context);
      },
    );
  }

  // Function to build the bottom sheet content
  Widget _buildEditProfileBottomSheet(BuildContext context) {
    // Set initial values for name and email
    nameController.text = 'John Doe';
    emailController.text = 'john.doe@example.com';

    return Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Update Profile',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle the update logic here
                // Access the updated name and email using nameController.text and emailController.text
                // For simplicity, you can print them for now
                print('Updated Name: ${nameController.text}');
                print('Updated Email: ${emailController.text}');
                // Close the bottom sheet
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              child: Text('UPDATE'),
            ),
          ],
        ),
      ),
    );
  }
}
