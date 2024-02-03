// ignore_for_file: prefer_const_declarations, non_constant_identifier_names, file_names

final String tableimages = 'IMAGES';

class ImagesFields {
  static final List<String> values = [
    /// Add all fields
    service_id, path
  ];

 
  static final String service_id = 'service_id';
  static final String path = 'path';
}

class Imageparameters {
  final int? service_id;
  final String ? path;

  const Imageparameters({
    this.service_id,
    required this.path,
  });

  Imageparameters copy({
    final int? service_id,
    final String? path,
  }) =>
      Imageparameters(
        service_id: service_id ?? service_id,
        path: path ?? this.path,
      );

  static Imageparameters fromJson(Map<String, Object?> json) => Imageparameters(
      service_id: json[ImagesFields.service_id] as int?,
      path: json[ImagesFields.path] as String);

  Map<String, Object?> toJson() => {
        ImagesFields.path: path,
        ImagesFields.service_id: service_id,
      };
}
