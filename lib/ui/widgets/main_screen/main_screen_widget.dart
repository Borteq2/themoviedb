import 'package:flutter/material.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MainScreenWidget extends StatefulWidget {
  final ScreenFactory screenFactory;

  const MainScreenWidget({
    Key? key,
    required this.screenFactory,
  }) : super(key: key);


  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TMDB'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          widget.screenFactory.makeNewsList(),
          widget.screenFactory.makeMovieList(),
          widget.screenFactory.makeTvShowList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Новости'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Фильмы'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Сериалы'),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
