import 'package:flutter/material.dart';

/// {@template lazy_indexed_stack}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class LazyIndexedStack extends StatefulWidget {
  /// {@macro lazy_indexed_stack}
  const LazyIndexedStack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const <Widget>[],
  });

  final int? index;
  final List<Widget> children;
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<bool> _activatedList = List<bool>.generate(
    widget.children.length,
    (i) => i == widget.index,
  );

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) _activateIndex(widget.index);
  }

  void _activateIndex(int? index) {
    if (index == null) return;

    if (!_activatedList[index]) {
      setState(() => _activatedList[index] = true);
    }
  }

  List<Widget> get children {
    return List<Widget>.generate(
      widget.children.length,
      (i) => _activatedList[i] ? widget.children[i] : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      index: widget.index,
      children: children,
    );
  }
}
