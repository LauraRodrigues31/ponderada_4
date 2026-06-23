import 'package:image_picker/image_picker.dart';

class CameraService {
  final _picker = ImagePicker();

  Future<String?> tirarFoto() async {
    final foto = await _picker.pickImage(source: ImageSource.camera);
    return foto?.path;
  }
}
