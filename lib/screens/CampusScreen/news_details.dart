import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/loader_service.dart';
import 'package:frontend/services/news_service.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
  final NewsModel? news;
  const NewsDetails({super.key, required this.news});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  late NewsService newsService;
  late AlertService alertService;
  final LoaderService loaderService = LoaderService();
  final TextEditingController _commentController = TextEditingController();
  List<CommentModel> comments = [];

  @override
  void initState() {
    super.initState();
    newsService = GetIt.instance<NewsService>();
    alertService = GetIt.instance<AlertService>();
    getComments(widget.news!.id).then((value) {
      setState(() {
        comments = value;
      });
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> createComment(String newsId, String comment) async {
    try {
      await newsService.createComment(newsId, comment);
      alertService.showSnackBar(message: 'Comment added successfully');
      _commentController.clear();
      getComments(widget.news!.id).then((value) {
        setState(() {
          comments = value;
        });
      });
    } catch (e) {
      debugPrint("Error: $e");
      loaderService.hideLoader();
      alertService.showSnackBar(message: 'Failed to add comment');
    }
  }

  Future<void> updateComment(String commentId, String comment) async {
    try {
      print('Comment: $comment');
      await newsService.updateComment(commentId, comment);
      alertService.showSnackBar(message: 'Comment updated successfully');
      getComments(widget.news!.id).then((value) {
        setState(() {
          comments = value;
        });
      });
    } catch (e) {
      debugPrint("Error: $e");
      loaderService.hideLoader();
      alertService.showSnackBar(message: 'Failed to update comment');
    }
  }

  Future<List<CommentModel>> getComments(String newsId) async {
    try {
      return await newsService.getComments(newsId);
    } catch (e) {
      debugPrint("Error: $e");
      loaderService.hideLoader();
      alertService.showSnackBar(message: 'Failed to get comments');
      return [];
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      await newsService.deleteComment(commentId);
      alertService.showSnackBar(message: 'Comment deleted successfully');
      getComments(widget.news!.id).then((value) {
        setState(() {
          comments = value;
        });
      });
    } catch (e) {
      debugPrint("Error: $e");
      loaderService.hideLoader();
      alertService.showSnackBar(message: 'Failed to delete comment');
    }
  }

  void _editComment(CommentModel comment) {
    final TextEditingController editController = TextEditingController(text: comment.comment);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom , left: 20.0,right: 20.0,top: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editController,
                decoration: InputDecoration(
                  labelText: 'Edit Comment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  final updatedComment = editController.text;
                  if (updatedComment.isNotEmpty) {
                    updateComment(comment.id, updatedComment);
                    Navigator.of(context).pop();
                  } else {
                    alertService.showSnackBar(
                        message: 'Comment cannot be empty');
                  }
                },
                child: Text('Update Comment'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news!.title,
                      style: kEventNewsHeading,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(" - "),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: AssetImage('assets/default-user.jpg'),
                        ),
                        Text(
                          '${widget.news!.author?.fullName ?? 'Unknown'}, ${DateFormat.yMd().format(widget.news!.created_at)}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      widget.news!.description,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: ListView.builder(
                        itemCount: comments.length + 1,
                        itemBuilder: (context, index) {
                          if (index == comments.length) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'No more comments',
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: AssetImage('assets/default-user.jpg'),
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comments[index].user.fullName,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text(
                                            comments[index].comment,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        _editComment(comments[index]);
                                      },
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteComment(comments[index].id);
                                      },
                                      icon: Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      filled: true,
                      hintText: 'Add a comment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      createComment(widget.news!.id, _commentController.text);
                    } else {
                      alertService.showSnackBar(message: 'Comment cannot be empty');
                    }
                  },
                  icon: Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
