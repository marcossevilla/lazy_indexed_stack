# Lazy Indexed Stack 😴🥞

[![ci][ci_badge]][ci_link]
[![License: MIT][license_badge]][license_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

A Flutter package that exposes a `IndexedStack` that can be lazily loaded.

`IndexedStack` is a widget that shows its children one at a time, preserving the state of all the children. But it renders all the children at once.

With `LazyIndexedStack`, you can load the children lazily, and only when they are needed. This comes in handy if you have a lot of children, and you don't want to load them all at once or if you have a child that loads content asynchronously.

## Usage

The `LazyIndexedStack` API is the same as `IndexedStack`. A basic implementation requires two parameters:

- A `List<Widget>` of children that are going to be lazy loaded under the hood.
- An `int` index that indicates which child is going to be shown.

## Example

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              children: List.generate(3, (i) => Text('$i')),
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
```

<a href="https://github.com/marcossevilla/lazy_indexed_stack/blob/main/example/lib/app.dart"><img src="https://raw.githubusercontent.com/marcossevilla/lazy_indexed_stack/main/art/infinite_list.gif" height="400"/></a>

Refer to the [example][example_link] to see the usage of `LazyIndexedStack`.

[ci_badge]: https://github.com/marcossevilla/lazy_indexed_stack/workflows/lazy_indexed_stack/badge.svg
[ci_link]: https://github.com/marcossevilla/lazy_indexed_stack/actions
[example_link]: https://github.com/marcossevilla/lazy_indexed_stack/blob/main/example/lib/app.dart
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
