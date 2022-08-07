import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data/presentation/view/show_screen.dart';
import 'package:student_data/provider/student_list.dart';
import 'package:student_data/widgets/delete_verification.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: 
      Consumer<StudentListProvider>(
              builder: (context, studentList, Widget? child) {
            return      
        Provider.of<StudentListProvider>(context).studentList.isNotEmpty? 
          ListView.separated(
            itemBuilder: (context, index) {
              final data = Provider.of<StudentListProvider>(context).studentList[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: MemoryImage(
                  const Base64Decoder().convert(data.image)),
                  radius: 35,
                ),
                title: Text(data.name),
                trailing: IconButton(
                  onPressed: () {
                    DeleteVerification(context: context,index: index).function();  
                  },
                  icon: const Icon(Icons.delete,color: Colors.red,size: 20,),
                ),
                onTap: () {
                  Navigator.of(context).push(
             MaterialPageRoute(builder: (context) =>ShowScreen(data: data,index:index)));
                },
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: Provider.of<StudentListProvider>(context).studentList.length,
          ):
          const Center(
            child: Text('No Data Added'),
            );          
        },
      ),
    );
  }

}
