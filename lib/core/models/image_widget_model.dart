import 'package:devity_sdk/core/models/style_model.dart';
import 'package:devity_sdk/core/models/widget_model.dart';

/// Model representing an Image widget.
class ImageWidgetModel extends WidgetModel {
  ImageWidgetModel({
    required super.id,
    this.url,
    this.fit,
    this.width,
    this.height,
    super.style,
    super.onClickActionIds,
  }) : super(
          widgetType: 'Image',
          attributes: {
            if (url != null) 'url': url,
            if (fit != null) 'fit': fit,
            if (width != null) 'width': width,
            if (height != null) 'height': height,
          },
        );

  final String? url;
  final String? fit;
  final double? width;
  final double? height;

  // This factory is for when ComponentModel.fromJson dispatcher calls it.
  // It assumes 'id', 'type', 'widgetType', 'style', 'onClickActionIds' might be parsed by the dispatcher
  // or passed in. For simplicity, let's assume it gets the full JSON for the widget.
  factory ImageWidgetModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    final styleJson = json['style'] as Map<String, dynamic>?;

    return ImageWidgetModel(
      id: json['id'] as String,
      url: attributes['url'] as String?,
      fit: attributes['fit'] as String?,
      width: (attributes['width'] as num?)?.toDouble(),
      height: (attributes['height'] as num?)?.toDouble(),
      style: styleJson != null ? StyleModel.fromJson(styleJson) : null,
      onClickActionIds: (json['onClickActionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson(); // Calls WidgetModel.toJson()
    // WidgetModel.toJson() already includes 'id', 'type', 'widgetType', 'attributes', 'style', 'onClickActionIds'
    // The attributes in super.toJson() are based on the constructor map.
    // Ensure specific fields of ImageWidgetModel are correctly in that attributes map.
    // The current super constructor for ImageWidgetModel already populates attributes.
    // If we want them at the top level of JSON, add them here explicitly:
    /*
    if (url != null) json['url'] = url;
    if (fit != null) json['fit'] = fit;
    if (width != null) json['width'] = width;
    if (height != null) json['height'] = height;
    */
    // However, it's more consistent if they are within the 'attributes' field,
    // which the constructor and super.toJson() should handle if attributes are passed correctly.
    // We just need to ensure `widgetType` is correct if super.toJson() doesn't set it from constructor.
    // `WidgetModel.toJson()` sets `widgetType`. `ComponentModel.toJson()` sets `type`.
    return json;
  }
}
