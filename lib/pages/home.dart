import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String bgImage = "assets/day.png";
  Color bgColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    print(data);

    // set bg image
    bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/$bgImage"), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 30),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime']
                      };
                    });
                  },
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.grey[300]),
                  icon: const Icon(Icons.edit_location),
                  label: const Text("Location"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/${data['flag']}"),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      data['location'],
                      style: const TextStyle(
                          fontSize: 29.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  data['time'],
                  style: const TextStyle(fontSize: 66.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
