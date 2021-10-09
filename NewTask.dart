import 'package:flutter/material.dart';
import 'package:task_manager_app/HomePage.dart';
import 'package:task_manager_app/datetime_picker_widget.dart';


class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir'
      ),
      home: newTask(),
    );
  }
}
class newTask extends StatefulWidget {
  @override
  _newTaskState createState() => _newTaskState();
}

class _newTaskState extends State<newTask> {
  List<String> chipList = ["\t\t\tMatrix 1\t\t\t", "\t\t\tMatrix 2\t\t\t",
    "\t\t\tMatrix 3\t\t\t", "\t\t\tMatrix 4\t\t\t"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff96060),
        elevation: 0,
        title: Text("New Task", style: TextStyle(
          fontSize: 25
        ),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 30,
              color: Color(0xfff96060),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: Colors.white
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5,),


                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Title", textAlign: TextAlign.left, style: TextStyle(
                              fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 1,),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(11)),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: .5,
                            ),),
                            //color: Colors.grey.withOpacity(0.2),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Title",
                                  // fillColor: Colors.white,
                                   border: InputBorder.none
                              ),
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 4,),



                          Text("Description", style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 1,),
                          Container(
                          height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(14)),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: .5,
                              )
                            ),
                            child: TextField(
                              maxLines: 6,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add description here",
                              ),
                              style: TextStyle(
                                fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 9,),


                          Padding(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DatetimePickerWidget(),
                              ],
                            ),
                          ),


                          Text("Choose Matrix", textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 18,
                                  fontWeight: FontWeight.bold,
                          ),),



                          Container(
                              child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                children: <Widget>[
                                  choiceChipWidget(chipList),
                                ],
                              )),
                         SizedBox(height:15,),



                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              InkWell(
                                onTap: openHomePage,
                                child: Container(
                                  height:50,
                                  width: 200,
                                  // alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical:8,horizontal: 52),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(11)),
                                    color: Color(0xfff96060),
                                  ),
                                  child: Text("Save task", style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

   void openHomePage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
}


class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 18.0,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.black38,
          selectedColor: Color(0xfff96060),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}