import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 1. Define the ThemeProvider for theme management
class ThemeProvider with ChangeNotifier {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.grey[100],
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.grey[900],
    brightness: Brightness.dark,
  );

  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData = _themeData == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}

// 2. Define the AuthenticationProvider for login/logout management
class AuthenticationProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void logIn(String username, String password) {
    if (username == 'user' && password == 'password') {
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}


// 3. Main app widget that uses providers for theme and auth state
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Pop Hub',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashScreen(),);
        }
  }

// 4. Splash Screen - Displayed when app launches
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, child) {
        // Splash screen duration
        Future.delayed(const Duration(seconds: 3), () {
          if (authProvider.isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        });

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.music_note, size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    "K-Pop Hub",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome to the World of K-Pop",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// 4. Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = "";

  void _login() {
    final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    authProvider.logIn(_usernameController.text, _passwordController.text);

    if (authProvider.isLoggedIn) {
      // Navigate to MainScreen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      setState(() {
        _errorMessage = "Invalid credentials!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'app-logo',
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("https://via.placeholder.com/120"),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text("Sign In"),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              TextButton(
                onPressed: () {
                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  themeProvider.toggleTheme();
                },
                child: const Text("Toggle Theme"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// 5. Main Screen (Tab View)
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("K-Pop Hub"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.pink,
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Home", icon: Icon(Icons.home)),
              Tab(text: "Artists", icon: Icon(Icons.person)),
              Tab(text: "Albums", icon: Icon(Icons.album)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            ArtistsTab(),
            AlbumsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Music note clicked!")),
            );
          },
          child: const Icon(Icons.music_note),
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}

// 6. Home Tab
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.music_note, size: 100, color: Colors.pink),
          const SizedBox(height: 20),
          const Text("Welcome to K-Pop Hub", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text(
            "Discover the world of K-Pop music and artists.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(msg: "Enjoy the music!");
            },
            child: const Text("Show Toast"),
          ),
        ],
      ),
    );
  }
}

// 7. Artists Tab
class ArtistsTab extends StatelessWidget {
  const ArtistsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          leading: const CircleAvatar(backgroundImage: NetworkImage("https://via.placeholder.com/50")),
          title: const Text("BTS"),
          subtitle: const Text("Global Superstars"),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(backgroundImage: NetworkImage("https://via.placeholder.com/50")),
          title: const Text("Blackpink"),
          subtitle: const Text("Queen of K-Pop"),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        ),
      ],
    );
  }
}

// 8. Albums Tab
class AlbumsTab extends StatelessWidget {
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(4, (index) {
        return Container(
          decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text("Album ${index + 1}", style: const TextStyle(color: Colors.white, fontSize: 18)),
          ),
        );
      }),
    );
  }
}

// 9. Custom Drawer (Logout functionality)
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("K-Pop Fan"),
            accountEmail: Text("kpopfan@gmail.com"),
            currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://via.placeholder.com/100")),
          ),
          const ListTile(
            leading: Icon(Icons.piano),
            title: Text("Music"),
            trailing: Icon(Icons.arrow_forward),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.category),
            title: Text("Genres"),
            trailing: Icon(Icons.arrow_forward),
            onTap: null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
              authProvider.logOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
