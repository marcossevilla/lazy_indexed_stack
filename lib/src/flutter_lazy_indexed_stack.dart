import 'package:flutter/material.dart';

/// {@template lazy_indexed_stack}
/// A widget that displays a [IndexedStack] with lazy loaded children.
/// {@endtemplate}
class LazyIndexedStack extends StatefulWidget {
  /// {@macro lazy_indexed_stack}
  const LazyIndexedStack({
    super.key,
    this.index = 0,
    this.children = const [],
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
  });

  /// The index of the child to display.
  final int index;

  /// The list of children that can be displayed.
  final List<Widget> children;

  /// How to align the children in the stack.
  final AlignmentGeometry alignment;

  /// The direction to use for resolving [alignment].
  final TextDirection? textDirection;

  /// How to size the non-positioned children in the stack.
  final StackFit sizing;

  /// How the content will be clipped when they extend beyond the boundaries.
  final Clip clipBehavior;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final Set<int> activatedChildren = {widget.index};

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) activateChild(widget.index);
  }

  void activateChild(int index) {
    if (!activatedChildren.contains(index)) activatedChildren.add(index);
  }

  List<Widget> get children {
    return List.generate(
      widget.children.length,
      (i) => activatedChildren.contains(i)
          ? widget.children[i]
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      sizing: widget.sizing,
      alignment: widget.alignment,
      clipBehavior: widget.clipBehavior,
      textDirection: widget.textDirection,
      children: children,
    );
  }
}
