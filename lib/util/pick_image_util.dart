import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

typedef ImageCallback = void Function(File image);

class PickImageUtil{

  static void pickImage(BuildContext context,ImageCallback callback){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new Text("添加照片"),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.camera_alt),
                    new Text("  拍照  "),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context); /*关闭弹窗*/
                  takePhoto(callback);
                },
              ),
              new SimpleDialogOption(
                child: new Row(
                  children: <Widget>[
                    new Icon(Icons.photo_library),
                    new Text("  相册  "),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context); /*关闭弹窗*/
                  openGallery(callback);
                },
              )
            ],
          );
        });
  }

  /**拍照*/
  static takePhoto(ImageCallback callback) async {
    callback(await ImagePicker.pickImage(source: ImageSource.camera));
  }

  /**相册*/
  static openGallery(ImageCallback callback) async {
    callback(await ImagePicker.pickImage(source: ImageSource.gallery));
  }

}