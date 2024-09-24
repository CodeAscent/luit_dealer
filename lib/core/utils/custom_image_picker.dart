import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luit_dealer/core/utils/custom_snackbar.dart';

customImagePicker(ImageSource source) async {
  try {
    XFile? image = await ImagePicker().pickImage(source: source);
    return image;
  } catch (e) {
    customSnackbar(e.toString(), ContentType.failure);
  }
}
