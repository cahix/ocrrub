import 'package:ocrrub/src/view/common.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String name;

  const LegendItem({
    Key? key,
    required this.color,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          name,
          style: TextStyle(
              height: 1.3,
              color: Colors.white.withOpacity(0.8),
              fontSize: 14
          ),
        ),
      ],
    );
  }
}
