import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.listenableValue,
    // required this.value,
    this.items,
    this.onChanged,
    this.label,
    this.hint,
  });

  // final T? value;
  final ValueNotifier<T?> listenableValue;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String? label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          5.verticalSpace,
        ],
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.5,
              color: context.theme.colorScheme.outline,
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: listenableValue,
            builder: (context, value, _) {
              return DropdownButton<T?>(
                value: value,
                hint: Text(
                  hint ?? 'اختر',
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontFamily: 'Cairo'),
                ),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Cairo',
                ),
                borderRadius: BorderRadius.circular(8),
                // focusColor: AppColors.surfaceContainerLow(context),
                underline: const SizedBox.shrink(),
                items: items,
                onChanged: (value) {
                  listenableValue.value = value;
                  onChanged?.call(value);
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                padding: const EdgeInsets.all(5),
                isDense: true,
                // dropdownColor: AppColors.surfaceContainerLow(context),
              );
            },
          ),
        ),
      ],
    );
  }
}
