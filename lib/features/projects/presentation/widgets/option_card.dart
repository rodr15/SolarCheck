import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final bool isSelected;
  final bool? selectedIcon;
  final String value;
  final Function()? onClick;
  const OptionCard({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    this.selectedIcon,
    this.color,
    required this.value,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    Color? selectedColor = isSelected
        ? color ?? Theme.of(context).primaryColor
        : Theme.of(context).hoverColor;

    Color? textColor =
        isSelected ? Theme.of(context).colorScheme.onPrimary : color;

    return InkWell(
      onTap: onClick,
      child: Card(
        color: isSelected ? color : null,
        shape: color == null
            ? null
            : RoundedRectangleBorder(
                side: BorderSide(color: color!),
                borderRadius: BorderRadiusGeometry.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: selectedColor,
                        border: textColor == null
                            ? null
                            : BoxBorder.all(color: textColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      icon,
                      color: textColor,
                    ),
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              if (selectedIcon != null && selectedIcon!) ...[
                Icon(
                  Icons.check_circle_outline_outlined,
                  color: selectedColor,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
