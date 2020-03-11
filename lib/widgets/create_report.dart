import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:timwan/providers/main_event_details.dart';

class CreateReportState extends StatefulWidget {
  @override
  _CreateReport createState() => _CreateReport();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _CreateReport extends State<CreateReportState> {
  @override
  File _image;
  bool camCheck = false;
  Item selectedWasteType;
  Item selectedWasteSize;

  List<Item> wasteType = <Item>[
    const Item(
        'Hazardous',
        Icon(
          Icons.warning,
          color: const Color(4290190364),
        )),
    const Item(
        'Recyclable',
        Icon(
          Icons.phone,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Decomposable',
        Icon(
          Icons.sentiment_dissatisfied,
          color: const Color(0xFF167F67),
        )),
  ];

  List<Item> wasteSize = <Item>[
    const Item(
        'Small (less than 1 cubic feets.)',
        Icon(
          Icons.warning,
          color: const Color(4290190364),
        )),
    const Item(
        'Medium (not more than half of a trash container.)',
        Icon(
          Icons.phone,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Large (couple of containers.)',
        Icon(
          Icons.sentiment_dissatisfied,
          color: const Color(0xFF167F67),
        )),
  ];
   openCam() {
  
    return false;
  }

  void camOpenInitial() {
    camCheck = openCam();
  }

  // File openCamera() {}

  //making radio buttons unselected at initial state

  @override
  void initState() {
    super.initState();
    if (camCheck != true) {
      openCam();
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainAppDetails = Provider.of<MainAppDetails>(context);
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Back',
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  mainAppDetails.clearPoints();
                  mainAppDetails.appState = MainAppState.StartState;
                },
              ),
              Text("Create Report"),
              Expanded(
                child: Container(),
              ),
              IconButton(
                tooltip: 'Reload',
                icon: Icon(Icons.restore_page),
                onPressed: pickImage,
              ),
              IconButton(
                tooltip: 'Gallery Image',
                icon: Icon(Icons.photo_album),
                onPressed: pickImage,
              ),
              IconButton(
                tooltip: 'Pick Image',
                onPressed: getImage,
                icon: Icon(Icons.add_a_photo),
              )
            ],
          ),
        ),
        Container(
          height: 320,
          width: 180,
          padding: const EdgeInsets.all(8.0),
          child: _image == null
              ? Image(image: AssetImage("assets/placeholder.jpg"))
              : Image.file(_image),
        ),
        Divider(
          height: 0,
          color: Colors.green,
        ),
    Container(
      color: Colors.green,
     child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    Text('Type of the Waste Materials:-', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0, backgroundColor: Colors.blue,),textAlign: TextAlign.center,),
     new DropdownButton<Item>(
          hint: Text("Select item"),
          value: selectedWasteType,
          onChanged: (Item Value) {
            setState(() {
              selectedWasteType = Value;
            });
          },
          items: wasteType.map((Item wasteType) {
            return DropdownMenuItem<Item>(
              value: wasteType,
              child: Row(
                children: <Widget>[
                  wasteType.icon,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    wasteType.name,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
            Text('Size of the Waste Materials:-', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0, backgroundColor: Colors.blue)),
        new DropdownButton<Item>(
          hint: Text("Select item"),
          value: selectedWasteSize,
          isExpanded: true,
          onChanged: (Item Value) {
            setState(() {
              selectedWasteSize = Value;
            });
          },
          items: wasteSize.map((Item wasteSize) {
            return DropdownMenuItem<Item>(
              value: wasteSize,
              // overflow: TextOverflow.ellipsis,
              child: ListTile(
                leading: wasteSize.icon,
                title: Text(
                  wasteSize.name,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
      ],
      ),
      ),
     
      ]),
    );
  }
}