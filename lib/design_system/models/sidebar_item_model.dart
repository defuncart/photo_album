import 'package:flutter/widgets.dart';

class SidebarItemModel {
  const SidebarItemModel({
    this.icon,
    required this.label,
  });

  final IconData? icon;
  final String label;

  SidebarItemModel copyWith({
    IconData? icon,
    String? label,
  }) {
    return SidebarItemModel(
      icon: icon ?? this.icon,
      label: label ?? this.label,
    );
  }

  @override
  String toString() => 'SidebarItemModel(icon: $icon, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is SidebarItemModel && other.icon == icon && other.label == label;
  }

  @override
  int get hashCode => icon.hashCode ^ label.hashCode;
}
