import 'package:flutter/material.dart';
 
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nameCtrl = new TextEditingController();
   
  TextEditingController descriptionCtrl = new TextEditingController();
   
  TextEditingController _date = new TextEditingController();
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String dropdownvalue2 = 'Item 1';
  var items2 = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      key: keyForm,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            formItemsDesign(
              Icons.add_box,

              DropdownButton(
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            formItemsDesign(
                Icons.text_snippet,
                TextFormField(
                  controller: descriptionCtrl,
                  decoration: new InputDecoration(
                    labelText: 'descripcion',
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  //validator: validateMobile,
                )),
            formItemsDesign(
                Icons.calendar_today,
                TextField(
                  controller: _date,
                  decoration: const InputDecoration(
                    labelText: "Selecciona la fecha",
                  ),
                  onTap: () async {
                    DateTime? pickedate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    if (pickedate != null) {
                      setState(() {
                       // _date.text = DateFormat('yyyy-MM-dd').format(pickedate);
                      });
                    }
                  },
                )),
            formItemsDesign(
                null,
                Column(children: <Widget>[
                  Text("Tipo de producto"),
                  RadioListTile<String>(
                    title: const Text('Organico'),
                    value: 'organico',
                    groupValue: producto,
                    onChanged: (value) {
                      setState(() {
                        producto = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Inorganico'),
                    value: 'inorganico',
                    groupValue: producto,
                    onChanged: (value) {
                      setState(() {
                        producto = value!;
                      });
                    },
                  )
                ])),
            formItemsDesign(
              Icons.three_k_plus,
              DropdownButton(
                // Initial Value
                value: dropdownvalue2,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items2) {
                  return DropdownMenuItem(
                    value: items2,
                    child: Text(items2),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue2 = newValue!;
                  });
                },
              ),
            ),
            GestureDetector(
                onTap: () {
                  save();
                },
                child: Container(
                  margin: const EdgeInsets.all(30.0),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 12, 240, 88),
                      Color.fromARGB(255, 13, 36, 24),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Text("Enviar Formulario",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                ))
          ],
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  String producto = 'Solido';

   

  save() {
    if (keyForm.currentState!.validate()) {
      print("Nombre ${nameCtrl.text}");
      print("Telefono ${descriptionCtrl.text}");
       
      keyForm.currentState!.reset();
    }
  }
}
