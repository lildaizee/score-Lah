import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sporthall_booking_system/Model/StatusModel.dart';
import 'package:sporthall_booking_system/Screen/Admin/AddStatus.dart';
import 'package:sporthall_booking_system/providers/AuthServiceProvider.dart';
import 'package:sporthall_booking_system/providers/MediaServiceProvider.dart';
import 'package:sporthall_booking_system/providers/StatusServiceProvider.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

enum Menu { edit, delete }

class _StatusScreenState extends State<StatusScreen> {
  int _current = 0;
  TextEditingController _captionController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Status"),
          actions: [
            context.read<AuthServiceProvider>().getUserData.userType == 'Parent'
                ? SizedBox()
                : IconButton(
                    onPressed: () async {
                      List<String> statusPhoto = await MediaServiceProvider.selectStatusPhotos(context: context);
                      if (statusPhoto.isNotEmpty ?? false) {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AddStatus(
                                statusPhoto: statusPhoto,
                              );
                            });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected')));
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                    ),
                  )
          ],
        ),
        body: StreamBuilder<List<StatusModel>>(
          stream: context.watch<StatusServiceProvider>().getListStreamStatus(),
          builder: (context, AsyncSnapshot<List<StatusModel>> snapshot) {
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return Center(
                child: Text('No status at the moment'),
              );
            }
            List<StatusModel> stat = snapshot.data;
            return ListView.builder(
              itemCount: stat.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                StatusModel sm = stat[index];
                return Container(
                  margin: EdgeInsets.only(
                    top: index == 0 ? 20 : 0,
                    bottom: index == stat.length - 1 ? 30 : 20,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(3, 3),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: sm.picture.map((e) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: e,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorWidget: (context, uri, error) {
                                      return Icon(Icons.error);
                                    },
                                  ));
                            }).toList(),
                            options: CarouselOptions(
                                viewportFraction: 1.0,
                                enableInfiniteScroll: sm.picture.length == 1 ? false : true,
                                enlargeCenterPage: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                          context.read<AuthServiceProvider>().getUserData.userType == 'Parent'
                              ? SizedBox()
                              : Positioned(
                                  top: 0,
                                  right: 0,
                                  child: PopupMenuButton<Menu>(
                                    tooltip: 'Edit Status',
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(0),
                                    onSelected: (Menu val) {
                                      if (val == Menu.edit) {
                                        showDialog(
                                            context: context,
                                            builder: (newContext) {
                                              return Form(
                                                key: _key,
                                                child: AlertDialog(
                                                  title: Text('Edit caption'),
                                                  content: TextFormField(
                                                    autofocus: true,
                                                    controller: _captionController,
                                                    decoration: InputDecoration(hintText: 'Enter new caption'),
                                                    validator: (val) => val == '' ? 'Please enter new caption' : null,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        if (_key.currentState.validate()) {
                                                          context.read<StatusServiceProvider>().editStatus(sm.statusID, _captionController.text.trim()).then((value) {
                                                            _captionController.clear();
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status Updated')));
                                                            Navigator.of(context).pop();
                                                          });
                                                        }
                                                      },
                                                      child: Text('Save'),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      }
                                      if (val == Menu.delete) {
                                        showDialog(
                                            context: context,
                                            builder: (newContext) {
                                              return AlertDialog(
                                                title: Text('Delete confirmation'),
                                                content: Text('Are you sure to delete this status?'),
                                                actionsAlignment: MainAxisAlignment.center,
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(newContext).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.grey,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                    child: Text('Cancel'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      context.read<StatusServiceProvider>().deleteStatus(sm.statusID).then((value) => Navigator.of(newContext).pop());
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                    child: Text('Proceed'),
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                                      PopupMenuItem<Menu>(
                                        value: Menu.edit,
                                        child: Text('Edit'),
                                      ),
                                      PopupMenuItem<Menu>(
                                        value: Menu.delete,
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: sm.picture.asMap().entries.map((entry) {
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                );
                              }).toList(),
                            ),
                            Gap(10),
                            Text(
                              sm.caption,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Gap(20),
                            sm.comments.isEmpty
                                ? Center(
                                    child: Text(
                                      'No comment at the moment',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height * (sm.comments.length > 1 ? 0.2 : 0.1),
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: sm.comments.length,
                                      itemBuilder: (context, index) {
                                        Comment comment = sm.comments[index];
                                        return Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                            top: index == 0 ? 0 : 5,
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                child: Icon(
                                                  Icons.person,
                                                ),
                                              ),
                                              Gap(10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      comment.fullname,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Gap(3),
                                                    Text(
                                                      comment.comment,
                                                    ),
                                                    Gap(2),
                                                    Text(
                                                      comment.timeCreated,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            Gap(20),
                            CommentBox(
                              statusModel: sm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CommentBox extends StatefulWidget {
  final StatusModel statusModel;
  const CommentBox({
    Key key,
    this.statusModel,
  }) : super(key: key);

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  TextEditingController _commentController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _commentController,
                maxLines: 1,
                style: TextStyle(fontSize: 17),
                textAlignVertical: TextAlignVertical.center,
                validator: (val) => val == '' ? 'Please type a comment' : null,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                    ),
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        Comment comment = Comment(
                          uid: context.read<AuthServiceProvider>().getUserID,
                          fullname: context.read<AuthServiceProvider>().getUserData.fullname,
                          timeCreated: DateTime.now().toString(),
                          comment: _commentController.text.trim(),
                        );
                        context.read<StatusServiceProvider>().addComment(widget.statusModel, comment).then((value) => _commentController.clear());
                      }
                    },
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.only(
                    left: 20,
                  ),
                  hintText: 'Write a comment',
                ),
              ),
            ),
          ],
        ));
  }
}
