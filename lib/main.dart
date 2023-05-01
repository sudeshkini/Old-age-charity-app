

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:summer_home/provider/auth.dart';
import 'package:summer_home/provider/donator.dart';
import 'package:summer_home/provider/user_provider.dart';
import 'package:summer_home/responsive/mobile_screen_layout.dart';
import 'package:summer_home/responsive/responsive_layout_screen.dart';
import 'package:summer_home/responsive/web_screen_layout.dart';
import 'package:summer_home/screens/Add_donar_screen.dart';
import 'package:summer_home/screens/Donate_Screen.dart';
import 'package:summer_home/screens/Map_Screen.dart';
import 'package:summer_home/screens/donar_details_screen.dart';
import 'package:summer_home/screens/login_screen.dart';
import 'package:summer_home/screens/signup_screen.dart';
import 'package:summer_home/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String? nid;
  MyApp({this.nid});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
        ChangeNotifierProxyProvider<UserProvider, Donator>(
          create: (_) => Donator("", [], ""),
          update: (context, userProvider, previousDonator) => Donator(
            userProvider.getUser?.getIdToken ?? "",
            previousDonator?.dlist ?? [],
            userProvider.getUser?.email??'',
          ),
        ),
        /*ChangeNotifierProxyProvider<Auth, Donator>(
          create: (_) => Donator("", [], ""),
          update: (ctx, auth, prevprods) {
            return Donator(auth.token??'', prevprods == null ? [] : prevprods.dlist,
                auth.usermail);
          },
        )*/

      ],
      child: Consumer<UserProvider>(
        builder: (ctx, userProvider, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Age Well',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home:userProvider.getUser!= null ? MapScreen() : SignupScreen(),
          routes: {
            MapScreen.routname: (ctx) => MapScreen(),
            //NGOListScreen.routname: (ctx) => NGOListScreen(auth.usermail),
            //Register.routname: (ctx) => Register(),
            //HomedetailScreen.routname: (ctx) => HomedetailScreen(),
            //HomeMapScreen.routname: (ctx) => HomeMapScreen(),
            //VolunteerScreen.routname: (ctx) => VolunteerScreen(auth.usermail),
            //VolunteerDetailScreen.routname: (ctx) => VolunteerDetailScreen(),
            //AddVolunteerScreen.routname: (ctx) => AddVolunteerScreen(),
            //JobScreen.routname: (ctx) => JobScreen(auth.usermail),
            //AddJob.routname: (ctx) => AddJob(),
            DonateScreen.routname: (ctx) => DonateScreen(userProvider.getUser?.email??''),
            DonateDetailScreen.routname: (ctx) => DonateDetailScreen(),
            AddDonater.routname: (ctx) => AddDonater(),
            //OrganiserAuthScreen.routname: (ctx) => OrganiserAuthScreen(),
            // AuthScreen.routname: (ctx) => AuthScreen(),
          }),
    ),
    );
        /*StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasn't been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },*/



  }
}*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_home/provider/donator.dart';
import 'package:summer_home/provider/user_provider.dart';
import 'package:summer_home/provider/volunteers.dart';
import 'package:summer_home/responsive/mobile_screen_layout.dart';
import 'package:summer_home/responsive/responsive_layout_screen.dart';
import 'package:summer_home/responsive/web_screen_layout.dart';
import 'package:summer_home/screens/login_screen.dart';
import 'package:summer_home/utils/colors.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
        ChangeNotifierProxyProvider<UserProvider, Donator>(
          create: (_) => Donator("", [], ""),
          update: (context, userProvider, previousDonator) => Donator(
            userProvider.getUser?.getIdToken ?? "",
            previousDonator?.dlist ?? [],
            userProvider.getUser?.email??'',
          ),
        ),
        ChangeNotifierProxyProvider<UserProvider, Volunteers>(
          create: (_) => Volunteers("", [], ""),
          update: (ctx, userProvider, prevprods) {
            return Volunteers(userProvider.getUser?.getIdToken ?? "",
                prevprods == null ? [] : prevprods.vitems, userProvider.getUser?.email??'');
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Age Well',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,

        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                print(snapshot);
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasn't been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ChangeNotifierProvider(
              create: (_) => Donator("", [], ""),
              child: const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';

import 'package:summer_home/provider/auth.dart';
// import 'package:summer_home/provider/cities.dart';
import 'package:summer_home/provider/donator.dart';
//import 'package:summer_home/providerr/jobs.dart';
//import 'package:summer_home/providerr/ngos.dart';
//import 'package:summer_home/providerr/volunteers.dart';
import 'package:summer_home/screens/Add_donar_screen.dart';
import 'package:summer_home/screens/donar_details_screen.dart';
//import 'package:summer_home/screens/AddJobs.dart';
//import 'package:summer_home/screens/AddNgo.dart';
//import 'package:summer_home/screens/AddVolunteer.dart';
//import 'package:summer_home/screens/AuthScreen.dart';
//import 'package:summer_home/screens/DonateDetailScreen.dart';
import 'package:summer_home/screens/donate_screen.dart';
import 'package:summer_home/screens/map_screen.dart';
import 'package:summer_home/screens/map_screen.dart';
//import 'package:summer_home/screens/JobScreen.dart';
//import 'package:summer_home/screens/MainScreen.dart';

//import 'package:summer_home/screens/NGOListScreen.dart';

//import 'package:summer_home/screens/OrganiserAuthScreen.dart';
//import 'package:summer_home/screens/VolunteerDetailScreen.dart';
//import 'package:summer_home/screens/VolunteerScreen.dart';
import 'package:provider/provider.dart';
import 'package:summer_home/screens/signup_screen.dart';

//    backgroundColor: Color.fromRGBO(54, 169, 186, 1.0),
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final mail = ModalRoute.of(context).settings.arguments as String;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),

       /* ChangeNotifierProxyProvider<Auth, NGOs>(
          create: (_) => NGOs("", [], ""),
          update: (ctx, auth, prevprods) {
            return NGOs(auth.token, prevprods == null ? [] : prevprods.items,
                auth.usermail);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Volunteers>(
          create: (_) => Volunteers("", [], ""),
          update: (ctx, auth, prevprods) {
            return Volunteers(auth.token,
                prevprods == null ? [] : prevprods.vitems, auth.usermail);
          },
        ),
        ChangeNotifierProxyProvider<Auth, Jobs>(
          create: (_) => Jobs("", [], ""),
          update: (ctx, auth, prevprods) {
            return Jobs(auth.token, prevprods == null ? [] : prevprods.jitem,
                auth.usermail);
          },
        ),*/
        ChangeNotifierProxyProvider<Auth, Donator>(
          create: (_) => Donator("", [], ""),
          update: (ctx, auth, prevprods) {
            return Donator(auth.token??'', prevprods == null ? [] : prevprods.dlist,
                auth.usermail);
          },
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: auth.isAuth ? MapScreen() : SignupScreen(),
            routes: {
              MapScreen.routname: (ctx) => MapScreen(),
              //NGOListScreen.routname: (ctx) => NGOListScreen(auth.usermail),
              //Register.routname: (ctx) => Register(),
              //HomedetailScreen.routname: (ctx) => HomedetailScreen(),
              //HomeMapScreen.routname: (ctx) => HomeMapScreen(),
              //VolunteerScreen.routname: (ctx) => VolunteerScreen(auth.usermail),
              //VolunteerDetailScreen.routname: (ctx) => VolunteerDetailScreen(),
              //AddVolunteerScreen.routname: (ctx) => AddVolunteerScreen(),
              //JobScreen.routname: (ctx) => JobScreen(auth.usermail),
              //AddJob.routname: (ctx) => AddJob(),
              DonateScreen.routname: (ctx) => DonateScreen(auth.usermail),
              DonateDetailScreen.routname: (ctx) => DonateDetailScreen(),
              AddDonater.routname: (ctx) => AddDonater(),
              //OrganiserAuthScreen.routname: (ctx) => OrganiserAuthScreen(),
              // AuthScreen.routname: (ctx) => AuthScreen(),
            }),
      ),
    );
  }
}*/

