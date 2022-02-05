import 'package:fluent_ui/fluent_ui.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';

class RadioButtonItem<T> {
  const RadioButtonItem({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is RadioButtonItem<T> && other.value == value && other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}

class AdaptiveRadioButtonGroup extends StatefulWidget {
  const AdaptiveRadioButtonGroup({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final List<RadioButtonItem> items;
  final dynamic selectedValue;
  final void Function(dynamic) onChanged;

  @override
  State<AdaptiveRadioButtonGroup> createState() => _AdaptiveRadioButtonGroupState();
}

class _AdaptiveRadioButtonGroupState extends State<AdaptiveRadioButtonGroup> {
  late dynamic _selectedValue;

  @override
  void initState() {
    super.initState();

    _selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in widget.items)
          AdaptiveRadioButton(
            value: item.value,
            label: item.label,
            onChanged: () {
              setState(() => _selectedValue = item.value);
              widget.onChanged(item.value);
            },
            isChecked: item.value == _selectedValue,
          ),
      ],
    );
  }
}

class AdaptiveRadioButton<T> extends StatelessWidget {
  const AdaptiveRadioButton({
    required this.value,
    required this.label,
    required this.onChanged,
    required this.isChecked,
    Key? key,
  }) : super(key: key);

  final T value;
  final String label;
  final void Function() onChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final adaptivePlatform = AdaptivePlatform.of(context);
    if (adaptivePlatform.isMacOS) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MacosRadioButton<T>(
            groupValue: isChecked ? value : null,
            onChanged: (_) => onChanged(),
            value: value,
          ),
          const SizedBox(width: 8),
          Text(
            label,
          ),
        ],
      );
    } else if (adaptivePlatform.isLinux) {
      return const SizedBox.shrink();
    } else {
      return RadioButton(
        checked: isChecked,
        content: Text(label),
        onChanged: (_) => onChanged(),
      );
    }
  }
}
