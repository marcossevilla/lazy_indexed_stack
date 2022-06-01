import 'package:flutter/material.dart';
import 'package:lazy_indexed_stack/lazy_indexed_stack.dart';

/// {@template example_app}
/// A simple example app that shows how to use [LazyIndexedStack].
/// {@endtemplate}
class ExampleApp extends StatelessWidget {
  /// {@macro example_app}
  const ExampleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'LazyIndexedStack',
      home: ExampleHomePage(title: 'LazyIndexedStack'),
    );
  }
}

/// {@template example_home_page}
/// This widget is the home page of your application. It is stateful, meaning
/// that it has a State object (defined below) that contains fields that affect
/// how it looks.
/// {@endtemplate}
class ExampleHomePage extends StatefulWidget {
  /// {@macro example_home_page}
  const ExampleHomePage({super.key, required this.title});

  /// This class is the configuration for the state.
  /// It holds the values (in this case the title)
  /// provided by the parent (in this case the App widget)
  /// and used by the build method of the State.
  ///
  /// Fields in a Widget subclass are always marked "final".
  final String title;

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int index = 0;

  void changeIndex(int newIndex) => setState(() => index = newIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: LazyIndexedStack(
              index: index,
              children: List.generate(3, (i) => ExamplePage(index: i)),
            ),
          ),
          BottomNavigationBar(
            currentIndex: index,
            onTap: changeIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_1),
                label: '1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_2),
                label: '2',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_3),
                label: '3',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// {@template example_page}
/// A simple example page.
/// {@endtemplate}
class ExamplePage extends StatefulWidget {
  /// {@macro example_page}
  const ExamplePage({super.key, required this.index});

  /// The index of the page.
  /// Used to determine which page is being displayed.
  final int index;

  /// Duration of the delay applied to the page.
  static const displayTimeDelay = Duration(milliseconds: 300);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  DateTime? _displayTime;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(
      ExamplePage.displayTimeDelay,
      () {
        if (mounted) {
          setState(() {
            _displayTime = DateTime.now().subtract(
              ExamplePage.displayTimeDelay,
            );
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const Spacer(),
        Text(
          'This is page ${widget.index}',
          style: textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        if (_displayTime == null)
          const Spacer()
        else
          Expanded(child: Text('initState() ran at $_displayTime')),
      ],
    );
  }
}
