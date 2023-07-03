import 'package:flutter/material.dart';
import 'package:healing_apps/screens/user/home/view/home_page_view.dart';
import 'package:healing_apps/screens/user/login/view/login_view.dart';
import 'package:healing_apps/screens/user/profile/view/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/login/login_bloc.dart';

class NavigatorView extends StatefulWidget {
  const NavigatorView({Key? key}) : super(key: key);

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: [
            const HomePageView(),
            Container(
              color: Colors.red[100],
            ),
            BlocListener<LoginBloc, LoginState>(
              bloc: context.read<LoginBloc>(),
              listener: (context, state) {
                if (state is LoginInitial) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                }
              },
              child: const ProfileView(),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: Colors.grey[700],
          unselectedItemColor: Colors.grey[500],
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Order",
              icon: Icon(
                Icons.list,
              ),
            ),
            BottomNavigationBarItem(
              label: "Me",
              icon: Icon(
                Icons.person,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
