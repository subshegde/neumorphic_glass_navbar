import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:neumorphic_glass_navbar/neumorphic_glass_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeumorphicGlassNavbar Demo',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        color: Colors.black,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 25, 16, 8),
                child: Text(
                  "Discover",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 260,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: kIsWeb
                                    ? 'https://placehold.co/300x200?text=Image+${index + 1}'
                                    : 'https://picsum.photos/seed/${index + 1}/300/200',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                right: 8,
                                child: Text(
                                  "Featured ${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  "Explore More",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    color: isDark ? Colors.black.withOpacity(0.8) : Colors.white.withOpacity(0.95),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      leading: CircleAvatar(
                        radius: 20,
                        child: CachedNetworkImage(
                          imageUrl: kIsWeb
                              ? 'https://placehold.co/100x100?text=Avatar+${index + 6}'
                              : 'https://picsum.photos/seed/${index + 6}/100',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: isDark ? Colors.grey[800] : Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        "Item ${index + 1}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        "Translucent UI",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      onTap: () {},
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: kBottomNavigationBarHeight + 20),
            ),
          ],
        ),
      ),
            
      bottomNavigationBar: NeumorphicGlassNavbar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Fav',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        settings: const NeumorphicGlassNavbarSettings(
          maxBlurIntensity: 16.0,
          borderRadius: 16.0,
          opacity: 0.1,
          vibrancyIntensity: 0.21,
        ),
      ),
    );
  }
}