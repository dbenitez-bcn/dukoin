import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DukoinDropdownMenu extends StatefulWidget {
  final List<String> items;
  final int initialValue;
  final void Function(int) onSelected;
  final double padding;
  final IconData? heading;
  final DukoinDropdownMenuThemeData decoration;

  const DukoinDropdownMenu({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onSelected,
    this.padding = 0,
    this.heading,
    this.decoration = const DukoinDropdownMenuThemeData(),
  });

  @override
  State<DukoinDropdownMenu> createState() => _DukoinDropdownMenuState();
}

class _DukoinDropdownMenuState extends State<DukoinDropdownMenu>
    with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  late int selectedValue;
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    _itemKeys.addAll(widget.items.map((_) => GlobalKey()));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
      _animationController.forward();
    } else {
      _animationController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }
  }

  bool isSelected(int item) {
    return item == selectedValue;
  }

  void _updateSelectedValue(int index) {
    setState(() {
      selectedValue = index;
    });
    _animationController.reverse().then((_) {
      widget.onSelected(index);
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_itemKeys[selectedValue].currentContext != null) {
        Scrollable.ensureVisible(
          _itemKeys[selectedValue].currentContext!,
          alignment: 0.5,
        );
      }
    });

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _animationController.reverse().then((_) {
            _overlayEntry?.remove();
            _overlayEntry = null;
          });
        },
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: Material(
                color: Colors.transparent,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    alignment: Alignment.topLeft,
                    child: Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 195),
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            children: [
                              const SizedBox(height: 8),
                              ...widget.items.asMap().entries.map((entry) {
                                var selected = isSelected(entry.key);
                                return Container(
                                  key: _itemKeys[entry.key],
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary
                                        .withAlpha(selected ? 51 : 0),
                                    borderRadius: BorderRadius.circular(
                                      appBorderRadius,
                                    ),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                      appBorderRadius,
                                    ),
                                    onTap: () =>
                                        _updateSelectedValue(entry.key),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            entry.value,
                                            style: TextTheme.of(
                                              context,
                                            ).titleSmall,
                                          ),
                                        ),
                                        if (selected)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                            ),
                                            child: Icon(
                                              LucideIcons.check,
                                              size: 16,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: widget.decoration.color,
      shape: widget.decoration.shape,
      child: InkWell(
        key: _key,
        borderRadius: BorderRadius.circular(appBorderRadius),
        onTap: () => _toggleDropdown(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.heading == null
                  ? SizedBox(width: 6)
                  : Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Icon(
                        LucideIcons.calendar,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: widget.padding),
                  child: Text(
                    widget.items[selectedValue],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                LucideIcons.chevronDown,
                size: 16,
                color: widget.decoration.color == null
                    ? Colors.grey
                    : Theme.of(context).colorScheme.onSecondary.withAlpha(200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DukoinDropdownMenuThemeData {
  final Color? color;
  final ShapeBorder? shape;

  const DukoinDropdownMenuThemeData({this.color, this.shape});

  factory DukoinDropdownMenuThemeData.filled({required Color color}) {
    return DukoinDropdownMenuThemeData(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(appBorderRadius),
      ),
    );
  }
}
