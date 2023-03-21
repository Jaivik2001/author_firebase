import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../component/capture_screenshot.dart';
import '../component/delete_dialog_box.dart';
import '../global.dart';
import '../helpers/cloud_firestore_helper.dart';
import '../helpers/collection_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Author Registration",
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.9),
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        onPressed: () {
          Global.isUpdate = false;
          Navigator.of(context).pushNamed("edit_add_author_page");
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Authors').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error : ${snapshot.hasError}");
            return const Text("Something  Wrong!");
          } else if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Global.authorList = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:Border.all(color: Colors.black26,width: 2),
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: ListTile(
                        onTap: (){
                             },
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        tileColor: Color(0xffFE4DCCF),

                        title: Text("${Global.authorList[index]['author']}",style: GoogleFonts.lato(
                            fontSize: 20,
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.bold
                        ),),
                        subtitle: Text("${Global.authorList[index]['book']}",style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold
                        ),),
                        trailing: IconButton(
                          splashRadius: 25,
                          icon: const Icon(Icons.delete,color: CupertinoColors.black,),
                          onPressed: () {
                            Helper.instance.deleteData(index: index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
