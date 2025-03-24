import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Material App',
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  final String campusText = '''
Студенческий городок или так называемый кампус Кубанского ГАУ состоит
из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся.
Студенты первого курса обеспечены местами в общежитии полностью.
В соответствии с Положением о студенческих общежитиях университета,
при поселении между администрацией и студентами заключается
договор найма жилого помещения.

Воспитательная работа в общежитиях направлена на улучшение быта,
соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде.
Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям:
наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов,
комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации.

С целью улучшения условий быта студентов активно работает система студенческого самоуправления -
студенческие советы организуют всю работу по самообслуживанию.''';

  int likesCount = 27;
  bool isLiked = false;

  Widget buildTile(String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
                likesCount += isLiked ? 1 : -1;
              });
            },
            icon: Icon(
              Icons.favorite,
              size: 25,
              color: isLiked ? Colors.redAccent : Colors.grey,
            ),
          ),
          Text(
            '$likesCount',
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget buildIconBtn(String title, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            if (title == 'ПОЗВОНИТЬ') {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const FullScreenCallGif(),
              );
            } else if (title == 'МАРШРУТ') {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const FullScreenRouteGif(),
              );
            }
          },
          icon: Icon(
            icon,
            size: 25,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(color: Colors.green, fontSize: 18))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Общежитие КубГАУ',
          style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/media/hOkTz5syFDY.jpg',
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey,
                  child: const Center(child: Text('Ошибка загрузки изображения')),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTile('Общежитие №20', 'Краснодар ул.Калинина 13'),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildIconBtn('ПОЗВОНИТЬ', Icons.phone),
                      buildIconBtn('МАРШРУТ', Icons.near_me),
                      buildIconBtn('ПОДЕЛИТЬСЯ', Icons.share),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    campusText,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FullScreenCallGif extends StatelessWidget {
  const FullScreenCallGif({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.9),
        body: Center(
          child: Image.asset(
            'assets/media/call-get-in-call.gif',
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (frame == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
              }
              return child;
            },
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.white, size: 50),
                  const SizedBox(height: 20),
                  const Text(
                    'Ошибка загрузки звонка',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Закрыть'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FullScreenRouteGif extends StatelessWidget {
  const FullScreenRouteGif({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.9),
        body: Center(
          child: Image.asset(
            'assets/media/dis-is-da-wae-this-is-da-wae.gif',
            fit: BoxFit.contain,
            repeat: ImageRepeat.repeat,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (frame == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
              }
              return child;
            },
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.white, size: 50),
                  const SizedBox(height: 20),
                  const Text(
                    'Ошибка загрузки маршрута',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Закрыть'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}