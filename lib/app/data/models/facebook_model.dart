class FacebookModel {
  final String? name;
  final String? email;
  final String? id;
  final FacebookPhotoModel? facebookPhotoModel;

  FacebookModel({
    this.name,
    this.email,
    this.id,
    this.facebookPhotoModel,
  });

  factory FacebookModel.fromJson(Map<String, dynamic> json) => FacebookModel(
        email: json['email'],
        name: json['name'],
        id: json['id'],
        facebookPhotoModel: FacebookPhotoModel.fromJson(
          json['picture']['data'],
        ),
      );
}

class FacebookPhotoModel {
  final String? url;
  final int? height;
  final int? widht;

  FacebookPhotoModel({this.url, this.height, this.widht});

  factory FacebookPhotoModel.fromJson(Map<String, dynamic> json) =>
      FacebookPhotoModel(
        url: json['url'],
        height: json['height'],
        widht: json['widht'],
      );
}
