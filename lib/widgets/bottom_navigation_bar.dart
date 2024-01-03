
import 'package:flutter/material.dart';
import 'package:movie_book_app/ui/auth/login_screen.dart';

import '../view/home/movie_list.dart';
import '../view/search/search_screen.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;



  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // Implement navigation logic based on the selected index.
        onItemTapped(context,index);
      ///  router.go( JobHomeView.path);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0), // Adjust vertical spacing here
            child:Icon(Icons.home,size: 24,color: Colors.white,)
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0), // Adjust vertical spacing here
            child: Icon(Icons.search_outlined,size: 24,color: Colors.white,)
          ),
          label: "",
        ),
            
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0), // Adjust vertical spacing here
            child: Icon(Icons.logout_outlined,size: 24,color: Colors.white,)
          ),
          label: "",
        ),
       
      
      ],
    );
  }

  static onItemTapped(BuildContext context,int index) {
    switch (index) {
    case 0:
      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MoviesList()));
    break;
    case 1:
          Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenScreen()));
    break;
    case 2:
      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
    break;
    
    }
  }


}

