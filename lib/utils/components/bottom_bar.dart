import 'package:flutter/material.dart';
import 'package:simanja/utils/theme/colors.dart';



class UserBottomBar extends StatefulWidget {
  const UserBottomBar({super.key});

  @override
  State<UserBottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<UserBottomBar> {
  int indexColor = 0;
  List<Widget> screens = [

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[indexColor],
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: kPrimaryColor,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.blue.withOpacity(0.8),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBottomNavigationItem(Icons.home, 0,'HOME'),
                      _buildBottomNavigationItem(Icons.how_to_vote_outlined, 1,'VOTE'),
                      _buildBottomNavigationItem(Icons.restore, 2,'RESULT'),
                      _buildBottomNavigationItem(Icons.person_sharp, 3,'PROFILE'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, int index,String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexColor = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: indexColor == index ? Colors.red : kWhiteColor,
          ),
          if (indexColor == index)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(title,style: TextStyle(color: kWhiteColor,fontSize: 12,fontWeight: FontWeight.bold),),
            ),
        ],
      ),
    );
  }
}

