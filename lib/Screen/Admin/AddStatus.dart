import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/StatusModel.dart';
import 'package:sporthall_booking_system/providers/AuthServiceProvider.dart';
import 'package:sporthall_booking_system/providers/StatusServiceProvider.dart';

class AddStatus extends StatefulWidget {
  final List<String> statusPhoto;
  const AddStatus({Key key, this.statusPhoto}) : super(key: key);

  @override
  State<AddStatus> createState() => _AddStatusState();
}

class _AddStatusState extends State<AddStatus> {
  TextEditingController captionController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Status',
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(20),
                widget.statusPhoto.isEmpty
                    ? Text('No Image Attached')
                    : CarouselSlider(
                        items: widget.statusPhoto.map((e) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: e,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorWidget: (context, uri, error) {
                                return Center(child: Icon(Icons.error));
                              },
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                        ),
                      ),
                Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    controller: captionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a caption',
                    ),
                    maxLines: 3,
                    maxLength: 200,
                    validator: (val) =>
                        val == '' ? 'Please enter a caption' : null,
                  ),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      StatusModel statusModel = StatusModel(
                        uploaderID:
                            context.read<AuthServiceProvider>().getUserID,
                        caption: captionController.text.trim(),
                        picture: widget.statusPhoto,
                        comments: [],
                      );

                      context
                          .read<StatusServiceProvider>()
                          .uploadStatus(statusModel)
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Status Uploaded')));
                          return Navigator.of(context).pop();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Status upload failed')));
                        return Navigator.of(context).pop();
                      });
                    }
                  },
                  child: Text('Upload'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
