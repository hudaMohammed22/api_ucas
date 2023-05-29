import '../pojo/api_image.dart';
import '../pojo/api_response.dart';

mixin api_mixin {
  ApiRrespose faildResponse = ApiRrespose(status: false,message: "someThing Wrong");
  ApiRresposeImage faildResponseiMAGE = ApiRresposeImage(status: false,message: "someThing Wrong");
}