class mycourseModel {
  String? name;
  String? email;
  String? img;
  String? fullname;

  mycourseModel({this.name, this.email, this.img, this.fullname});
}

class ModelcourseVDO {
  String? vdoname;
  String? Vdo_id;

  String? url;
  String? course_name;
  String? course_description;
  String? course_img;
  String? TypeID;

  ModelcourseVDO(
      {this.vdoname,
      this.url,
      this.course_name,
      this.course_description,
      this.course_img,
      this.TypeID,
      this.Vdo_id});
}
