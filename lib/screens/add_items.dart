import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './display_items.dart';
import '../models/product.dart';
import 'Cart_items.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? imageFile;
  final picker = ImagePicker();
  Image? normalImage;
  String errorText = "";
  Color? errorBackgroundColor;
  Color? errorTextColor;

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() async {
      imageFile = File(pickedFile!.path);
      normalImage = await convertFileToImage(imageFile!);
    });
  }

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }

  void addItem() {
    if (itemNameController.text.isEmpty) {
      setState(() {
        errorText = "Please enter the product name";
        errorBackgroundColor = Colors.black;
        errorTextColor = Colors.red;
      });
    } else if (priceController.text.isEmpty) {
      setState(() {
        errorText = "Please enter the product price";
        errorBackgroundColor = Colors.black;
        errorTextColor = Colors.red;
      });
    } else if (descriptionController.text.isEmpty) {
      setState(() {
        errorText = "Please enter the product description";
        errorBackgroundColor = Colors.black;
        errorTextColor = Colors.red;
      });
    } else if (normalImage == null) {
      setState(() {
        errorText = "Please enter the product image";
        errorBackgroundColor = Colors.black;
        errorTextColor = Colors.red;
      });
    } else {
      setState(() {
        DisplayItems.id++;
        errorText = "Product Successfully Added";
        errorBackgroundColor = Colors.greenAccent;
        errorTextColor = Colors.blue;

        DisplayItems.itemsData.add(
          Product(
              id: DisplayItems.id.toString(),
              itemName: itemNameController.text,
              description: descriptionController.text,
              price: int.parse(priceController.text),
              image: normalImage!,
              isFavourite: false),
        );
        itemNameController.text = "";
        priceController.text = "";
        descriptionController.text = "";
        CartItems.quantity.add(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Product Name",
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
                controller: itemNameController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Product Price",
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
                controller: priceController,
              ),
              SizedBox(
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Enter Product Description",
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                  controller: descriptionController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              imageFile == null
                  ? GestureDetector(
                      onTap: () {
                        chooseImage();
                      },
                      child: DottedBorder(
                        borderType: BorderType.Rect,
                        color: Colors.grey,
                        strokeWidth: 2,
                        radius: const Radius.circular(8),
                        dashPattern: [8, 4],
                        child: const ClipRRect(
                          child: SizedBox(
                            width: 350,
                            height: 200,
                            child: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        image: DecorationImage(
                          image: FileImage(imageFile!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Add Item"),
                onPressed: () {
                  addItem();
                },
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                color: errorBackgroundColor,
                child: Center(
                  child: Text(
                    errorText,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: errorTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
