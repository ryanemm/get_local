class GalleryImage {
  final String companyId;
  final String companyName;
  final String imageName;

  GalleryImage({
    required this.companyId,
    required this.companyName,
    required this.imageName,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> jsonData) {
    return GalleryImage(
      companyId: jsonData['companyId'],
      companyName: jsonData['companyName'],
      imageName: jsonData['imageName'],
    );
  }
}
