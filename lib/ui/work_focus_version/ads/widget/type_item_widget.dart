import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wadeema/data/models/properties/entity/properties_entity.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/divider_item.dart';

import '../../../../core/constants/app_colors.dart';

class TypeItemWidget extends StatefulWidget {
  final String title;
  final List<ItemsSubPropertiesEntity> subProperties;
  final Function(ItemsSubPropertiesEntity?) onSelected;
  final String? selectedProperties;
  final Color? selectedColor;
  final Color? disabledColor;
  final Color? borderColor;

  const TypeItemWidget(
      {required this.title,
      required this.subProperties,
      required this.selectedProperties,
      required this.onSelected,
      this.selectedColor,
      this.disabledColor,
      this.borderColor});

  @override
  State<TypeItemWidget> createState() => _TypeItemWidgetState();
}

class _TypeItemWidgetState extends State<TypeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                      widget.subProperties.length,
                      (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(widget.subProperties[index].title ?? '',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: widget.subProperties[index].title == widget.selectedProperties
                                          ? AppColorsController().black
                                          : AppColorsController().greyTextColor)),
                              side: BorderSide(color: widget.borderColor ?? AppColorsController().grey),
                              selected: widget.subProperties[index] == widget.selectedProperties,
                              selectedColor: widget.selectedColor ?? AppColorsController().grey,
                              backgroundColor: AppColorsController().lightGrey,
                              disabledColor: widget.disabledColor ?? AppColorsController().red,
                              onSelected: (value) {
                                HapticFeedback.lightImpact();
                                widget.onSelected(widget.subProperties[index]);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: (widget.subProperties[index].title?.length == 1) ? 8 : 16, vertical: 4),
                            ),
                          )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          DividerItem()
        ],
      ),
    );
  }
}
