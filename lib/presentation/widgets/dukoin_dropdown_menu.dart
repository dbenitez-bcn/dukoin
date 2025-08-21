import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DukoinDropdownMenu extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final void Function(String) onSelected;

  const DukoinDropdownMenu({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onSelected,
  });

  @override
  State<DukoinDropdownMenu> createState() => _DukoinDropdownMenuState();
}

class _DukoinDropdownMenuState extends State<DukoinDropdownMenu>
    with SingleTickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  late String selectedValue;
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;

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

  bool isSelected(String item) {
    return item == selectedValue;
  }

  void _updateSelectedValue(String value) {
    setState(() {
      selectedValue = value;
    });
    widget.onSelected(value);
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

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
              height: 195,
              child: Material(
                color: Colors.transparent,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    alignment: Alignment.topLeft,
                    child: Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: widget.items.map((item) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary
                                    .withAlpha(isSelected(item) ? 51 : 0),
                                borderRadius: BorderRadius.circular(
                                  appBorderRadius,
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  appBorderRadius,
                                ),
                                onTap: () => _updateSelectedValue(item),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item,
                                        style: TextTheme.of(context).titleSmall,
                                      ),
                                    ),
                                    if (isSelected(item))
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
                          }).toList(),
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
      child: InkWell(
        key: _key,
        borderRadius: BorderRadius.circular(8),
        onTap: () => _toggleDropdown(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Icon(LucideIcons.calendar, size: 16, color: Colors.grey),
              ),
              Expanded(
                child: Text(
                  selectedValue,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(width: 6),
              Icon(LucideIcons.chevronDown, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
