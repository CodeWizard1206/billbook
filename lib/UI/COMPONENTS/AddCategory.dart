import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:billbook/Constants.dart';
import 'package:billbook/DatabaseHandler.dart';
import 'package:billbook/UI/COMPONENTS/CustomButton.dart';

class AddCategory extends StatefulWidget {
  AddCategory({Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _controller = new TextEditingController();
  bool progressing = false;
  Map<String, dynamic> _deleteData = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            enabled: !this.progressing,
            controller: this._controller,
            decoration: InputDecoration(
              hintText: 'add a new product category...',
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                  width: 2,
                ),
              ),
            ),
            maxLines: 1,
            onChanged: (value) {
              if (this._controller.text !=
                      this._deleteData['name'].toString() &&
                  this._deleteData.isNotEmpty) {
                this._deleteData = {};
              }
            },
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Visibility(
                visible: progressing,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              MaterialMenuButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                buttonText: 'ADD',
                leadingIconData: Icon(
                  FlutterIcons.plus_faw5s,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (this._controller.text != '') {
                    setState(() {
                      this.progressing = true;
                    });
                    try {
                      Firestore.instance.collection('Categories').add({
                        'name': this._controller.text,
                        'timestamp': DateTime.now(),
                      }).then((value) {
                        setState(() {
                          this.progressing = false;
                          this._controller.text = '';
                        });
                        showFlushBar(
                          context: context,
                          title: 'Great!',
                          message: 'Data Added Successfully...',
                        );
                      });
                    } catch (e) {
                      setState(() {
                        this.progressing = false;
                      });
                      showFlushBar(
                        context: context,
                        title: 'Error!',
                        message: 'Data Addition Failed...',
                        alertStyle: true,
                      );
                    }
                  }
                },
              ),
              SizedBox(
                width: 8.0,
              ),
              MaterialMenuButton(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                buttonText: 'DELETE',
                filledColor: Colors.red[400],
                leadingIconData: Icon(
                  FlutterIcons.trash_faw5s,
                  color: Colors.white,
                ),
                onPressed: () async {
                  setState(() {
                    this.progressing = true;
                  });
                  if (this._deleteData.isEmpty) {
                    List<Map<String, dynamic>> _data = await getCategoryList();
                    setState(() {
                      this.progressing = false;
                    });
                    showDialog(
                      context: context,
                      builder: (_) => SimpleDialog(
                        title: Text(
                          'Select a Category',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: _data
                            .map(
                              (category) => SimpleDialogOption(
                                onPressed: () {
                                  this._deleteData = category;
                                  this._controller.text = category['name'];
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  category['name'].toString(),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else {
                    bool _result =
                        deleteCategory(this._deleteData['id'].toString());
                    if (_result) {
                      showFlushBar(
                        context: context,
                        title: 'Done!',
                        message: 'Data Deleted...',
                        alertStyle: true,
                      );
                    } else {
                      showFlushBar(
                        context: context,
                        title: 'Error!',
                        message: 'Data Deletion Failed...',
                        alertStyle: true,
                      );
                    }
                    setState(() {
                      this.progressing = false;
                      this._deleteData = {};
                      this._controller.text = '';
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
