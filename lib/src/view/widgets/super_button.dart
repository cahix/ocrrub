
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';

import '../common.dart';
import 'loading_indicator.dart';

enum ButtonType {
  rectangular,
  rounded,
}

class SuperButton extends StatefulWidget {
  final ButtonType buttonType;
  final String? label;
  final Color color;
  final AsyncCallback? onPressedAsync;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double maxWidth;
  final bool outlined;
  final EdgeInsetsGeometry? padding;
  final Widget? leading;
  final Widget? trailing;
  final BorderSide? borderSide;

  const SuperButton({
    this.buttonType = ButtonType.rectangular,
    this.label,
    this.color = Colors.blueAccent,
    this.onPressedAsync,
    this.width,
    this.height,
    this.maxWidth = 500.0,
    this.outlined = false,
    this.onPressed,
    this.padding,
    this.leading,
    this.trailing,
    this.borderSide,
  });

  @override
  _SuperButtonState createState() => _SuperButtonState();
}

class _SuperButtonState extends State<SuperButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    height: widget.height,
    width: widget.width,
    constraints: BoxConstraints(maxWidth: widget.maxWidth),
    padding: widget.padding,
    duration: const Duration(milliseconds: 150),
    curve: Curves.fastOutSlowIn,
    child: ElevatedButton(
      style: buttonStyle(),
      onPressed: widget.onPressed ?? _onPressedAsync,
      child: isLoading ? _loadingIndicator() : _buttonChild(),
    ),
  );

  Widget _loadingIndicator() {
    return LoadingIndicator.small(
      color: widget.outlined ? widget.color: Colors.white,
    );
  }

  Widget _buttonChild() {
    return Row(
      children: [
        Expanded(child: widget.leading ?? const SizedBox(),),
        Expanded(flex: 3, child: _title()),
        Expanded(child: widget.trailing ?? const SizedBox(),),
      ],
    );
  }

  Widget _title() {
    return AutoSizeText(
        widget.label ?? '',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14.0,
            color: widget.outlined ? widget.color : Colors.white,
            fontWeight: FontWeight.normal,
        ),
    );
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
        primary: widget.outlined ? Colors.white : widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              widget.buttonType == ButtonType.rounded ? 25.0 : 5.0),
          side: widget.outlined ?
          widget.borderSide ?? BorderSide(color: widget.color)
              : BorderSide.none,
        ));
  }

  void _onPressedAsync() {
    if(widget.onPressedAsync == null) return;
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      widget.onPressedAsync!().then((_) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }
}
