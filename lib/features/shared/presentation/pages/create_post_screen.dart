import 'package:expatx/core/app_colors.dart';
import 'package:expatx/features/shared/presentation/widgets/create_post_language_dropdown.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Post",
          style: TextStyle(
            color: AppColors.expatxBlack,
            fontFamily: "Roboto",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.expatxBlack,
            size: 35,
            weight: 2,
          ),
          //replace with our own icon data.
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_postController.text != "") {
                Navigator.pop(context, _postController.text);
              }
            },
            child: const Text(
              "Post",
              style: TextStyle(
                color: AppColors.expatxPurple,
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF0F0F0),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipOval(
                      child: Image.asset("assets/images/user_profile.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const CreatePostLanguageDropdown(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Text Input
            SizedBox(
              width: double.infinity,
              height: 350,
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                maxLines: null,
                onChanged: (val) {},
                keyboardType: TextInputType.multiline,
                controller: _postController,
                // validator: (val) {
                //   if (val!.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  // contentPadding: const EdgeInsets.symmetric(
                  //   horizontal: 10,
                  //   vertical: 10,
                  // ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "What's happening?",
                  hintStyle: const TextStyle(
                    color: AppColors.expatxBlack,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  suffixIcon: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.add_photo_alternate_outlined,
                            color: AppColors.expatxPurple,
                            size: 35,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
