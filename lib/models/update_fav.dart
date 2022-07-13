class UpdateFavorites{
  bool? status;
  String? message;

  UpdateFavorites.fromJson(Map<String,dynamic> json)
  {
    status =json["status"];
    message =json["message"];
  }

}