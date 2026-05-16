import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() {

runApp(MyApp());

}

class MyApp extends StatelessWidget {

@override
Widget build(BuildContext context) {

return MaterialApp(

debugShowCheckedModeBanner:false,

home:HomePage(),

);

}

}

class HomePage extends StatefulWidget {

@override
_HomePageState createState() =>
_HomePageState();

}

class _HomePageState
extends State<HomePage> {

List<Application> apps = [];

bool drawerOpen = false;

bool dark = false;

@override
void initState() {

super.initState();

loadApps();

}

void loadApps() async {

List<Application> installedApps =

await DeviceApps.getInstalledApplications(

includeAppIcons:true,

);

setState(() {

apps = installedApps;

});

}

@override
Widget build(BuildContext context) {

return Scaffold(

body:Stack(

children:[

/* ROOM IMAGE */

Container(

decoration:BoxDecoration(

image:DecorationImage(

image:AssetImage(
"assets/room.jpg"
),

fit:BoxFit.cover,

),

),

),

/* DARK EFFECT */

AnimatedContainer(

duration:
Duration(milliseconds:400),

color:

dark

?

Colors.black.withOpacity(0.6)

:

Colors.transparent,

),

/* TV */

Positioned(

top:300,
right:40,

child:GestureDetector(

onTap:(){

DeviceApps.openApp(
"com.google.android.youtube"
);

},

child:Container(

width:180,
height:120,

decoration:BoxDecoration(

color:
Colors.black.withOpacity(0.4),

borderRadius:
BorderRadius.circular(20),

),

),

),

),

/* BULB */

Positioned(

top:70,
left:150,

child:GestureDetector(

onTap:(){

setState(() {

dark = !dark;

});

},

child:Container(

width:100,
height:100,

decoration:BoxDecoration(

shape:BoxShape.circle,

color:
Colors.yellow.withOpacity(0.5),

boxShadow:[

BoxShadow(

color:Colors.yellow,

blurRadius:40,

),

],

),

),

),

),

/* ALMARI */

Positioned(

top:120,
left:0,

child:GestureDetector(

onTap:(){

setState(() {

drawerOpen =
!drawerOpen;

});

},

child:Container(

width:140,
height:350,

decoration:BoxDecoration(

color:
Colors.brown.withOpacity(0.4),

borderRadius:
BorderRadius.circular(20),

),

),

),

),

/* DRAWER */

AnimatedPositioned(

duration:
Duration(milliseconds:400),

bottom:
drawerOpen ? 0 : -600,

left:0,
right:0,

child:Container(

height:600,

padding:
EdgeInsets.all(20),

decoration:BoxDecoration(

color:
Colors.black.withOpacity(0.9),

borderRadius:
BorderRadius.vertical(

top:
Radius.circular(30),

),

),

child:GridView.builder(

itemCount:apps.length,

gridDelegate:

SliverGridDelegateWithFixedCrossAxisCount(

crossAxisCount:4,

),

itemBuilder:(context,index){

Application app =
apps[index];

return GestureDetector(

onTap:(){

DeviceApps.openApp(
app.packageName
);

},

child:Column(

children:[

app is ApplicationWithIcon

?

Image.memory(

app.icon,

width:50,
height:50,

)

:

Icon(
Icons.android,
color:Colors.white
),

SizedBox(height:5),

Text(

app.appName,

style:TextStyle(

color:Colors.white,
fontSize:10,

),

overflow:
TextOverflow.ellipsis,

),

],

),

);

},

),

),

),

],

),

);

}

}