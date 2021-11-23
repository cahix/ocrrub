import '../common.dart';

class LoadingIndicator extends StatelessWidget {
  final double height;
  final double width;
  final double strokeWidth;
  final Color? color;

  const LoadingIndicator.large({
    this.height = 25,
    this.width = 25 ,
    this.strokeWidth = 2,
    this.color,
  });

  const LoadingIndicator.medium({
    this.height = 20,
    this.width = 20 ,
    this.strokeWidth = 2,
    this.color,
  });

  const LoadingIndicator.small({
    this.height = 15,
    this.width = 15 ,
    this.strokeWidth = 2,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
      ),
    );
  }
}
