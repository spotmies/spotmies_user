import 'package:firebase_storage/firebase_storage.dart';

uploadFilesToCloud(inputFile,
    {cloudLocation = "legalDoc", fileType = ".jpg"}) async {
  if (inputFile == null || inputFile.runtimeType == String) return inputFile;
  var postImageRef = FirebaseStorage.instance.ref().child(cloudLocation);
  UploadTask uploadTask = postImageRef
      .child(DateTime.now().toString() + fileType)
      .putFile(inputFile);
  print(uploadTask);
  String imageUrl = await (await uploadTask).ref.getDownloadURL();
  return imageUrl.toString();
}
