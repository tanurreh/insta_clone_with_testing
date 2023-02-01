import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intagram_clone/app/data/constants.dart';
import 'package:intagram_clone/app/responsive/dimensions.dart';


class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: CustomColor.mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              
              Icons.home,
              key: Key('home_button'),
              color: (_page == 0) ? CustomColor.primaryColor : CustomColor.secondaryColor,
            ),
            label: '',
            backgroundColor: CustomColor.primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(

                Icons.search,
                key: Key('search_button'),
                color: (_page == 1) ? CustomColor.primaryColor : CustomColor.secondaryColor,
              ),
              label: '',
              backgroundColor: CustomColor.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                
                Icons.add_circle,
                key: Key('add_post_button'),
                color: (_page == 2) ? CustomColor.primaryColor : CustomColor.secondaryColor,
              ),
              label: '',
              backgroundColor: CustomColor.primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              key: Key('notification_button'),
              color: (_page == 3) ? CustomColor.primaryColor : CustomColor.secondaryColor,
            ),
            label: '',
            backgroundColor: CustomColor.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              key: Key('profile_button'),
              color: (_page == 4) ? CustomColor.primaryColor : CustomColor.secondaryColor,
            ),
            label: '',
            backgroundColor: CustomColor.primaryColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}