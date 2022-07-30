import 'package:flutter/material.dart';
import 'package:gestion_tareas/src/api/providers/provider_addNewTask.dart';
import 'package:intl/intl.dart';

import '../api/response.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}


TextEditingController tituloController = TextEditingController();
TextEditingController comentariosController = TextEditingController();
TextEditingController descripcionController = TextEditingController();

//GetTasksProvider getTasksProv = new GetTasksProvider();

AddNewTask addTask = new AddNewTask();


GlobalKey<FormState> _tituloKey = GlobalKey<FormState>();

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

 late List<String> _choices;
 late bool _isSelected;
 late List<String> _filters;
 late int _choiceIndex;
 String titulo = "";

 @override
 void initState() {
   super.initState();
   _isSelected = false;
   _choiceIndex = 0;
   _choices = ["Baja","Media", "Alta"];
 }


 @override
 void onClose() {
   tituloController.clear();
   descripcionController.clear();
   comentariosController.clear();
   tituloController.dispose();
   descripcionController.dispose();
   comentariosController.dispose();
 }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Si se le da tap a cualquier parte de la pantalla se cierra el teclado
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                borrar();
                Navigator.popAndPushNamed(context, "home");
                },
              child: Icon(Icons.arrow_back)),
          title: Text("Add new task"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Form(
                  key: _tituloKey,
                    child: _titleTFF()
                ),
                _comentariosTFF(),
                _descriptionTFF(),
                _doneCheckBox(),
                _tagText(),
                _buildChoiceChips(),
                Row(
                  children: [
                    _addNewTaskButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tagText(){
   return Padding(padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
    child: Text("Añadir TAG", style: TextStyle(fontSize: 20),),
   );
  }


  Widget _titleTFF(){
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 15),
            child: Container(
              height: 80,
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.title_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Titulo",
                    fillColor: Colors.white70),

                controller: tituloController,
                onSaved: (value) {
                  titulo = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obligatorio';
                  }
                  return null;
                },

              ),
            ),
          ),
        ),
      ],
    );
  }

  int done = 0;
  bool doneIsChecked = false;

  Widget _doneCheckBox(){
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.grey;
    }
    return Row(
      children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.fromLTRB(23, 10, 13, 5),
              alignment: Alignment.centerLeft,
              //color: Colors.red,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Marcar como terminada",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'AveniMed'
                  ),
                ),
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Transform.scale(
            scale: 1.3,
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: doneIsChecked,
              onChanged: (bool? value) {
                setState(() {
                  print(value);
                  doneIsChecked = value!;
                  if(value == true){
                    done = 1;
                  }else{
                    done = 0;
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }


  Widget _comentariosTFF(){
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: SizedBox(
              child: TextFormField(
                maxLines: 3,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.text_fields_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Comentarios",
                    fillColor: Colors.white70),

                controller: comentariosController,
                onSaved: (value) {
                  //comentariosController.text = value!;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _descriptionTFF(){
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: SizedBox(
              child: TextFormField(
                maxLines: 3,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.text_fields_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Descripción",
                    fillColor: Colors.white70),

                controller: descripcionController,
                onSaved: (value) {
                  //descripcionController.text = value!;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChips() {
    return Container(
      //width: 400,
      alignment: Alignment.center,
      //color: Colors.grey,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _choices.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:  EdgeInsets.fromLTRB(50, 10, 20, 10),
            child: ChoiceChip(
              label: Text(_choices[index]),
              selected: _choiceIndex == index,
              selectedColor: Colors.blue,
              onSelected: (bool selected) {
                setState(() {
                  _choiceIndex = selected ? index : 0;
                });
              },
              backgroundColor: Colors.grey,
              labelStyle: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

 Widget _addNewTaskButton(){
   return Expanded(
     child: Padding(
       padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
       child: Container(
         height: 70,
         child: ElevatedButton(
           style: ButtonStyle(
               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                   RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12.0),
                   )
               )
           ),
           onPressed: () {
             _addNewTaskOnTap();
           },
           child: Center(
             child: Text("Add new task", style: TextStyle(fontSize: 25),)
           ),
         ),
       ),
     ),
   );
 }


  /// Metodos ----------------------------------------------
 ///
 ///


 static const snackBar = SnackBar(
   content: Text('Se encuentran campos vacíos'),
 );

 Future<void> _addNewTaskOnTap() async {
  checkTitle();

   ///Obtenemos la fecha actual
   DateTime date = DateTime.now();
   String formattedDate = DateFormat('yyyy-MM-dd').format(date);

   ///Obtenemos el texto de los comentarios
   late String comments;
   if(comentariosController.text.isEmpty){
     comments = "";
   }else{
     comments = comentariosController.text;
   }


   ///Obtenemos el tag
      String tag = "";
      if(_choiceIndex == 0){
        tag = "Baja";
      }else{
        if(_choiceIndex == 1){
          tag = "Media";
        }else{
          tag = "Alta";
        }
      }


   ///Obtenemos el texto de la descripción
   late String description;
   if(descripcionController.text.isEmpty){
     description = "";
   }else{
     description = descripcionController.text;
   }

   Respuesta requestOK = await addTask.addNewTaskProv("123456", titulo, done, formattedDate, comments, description, tag);

   //LoginModel loginM = requestOK.data;

     if (requestOK.statusCode != 200 && tituloController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
       //ctrl.loading.value = !ctrl.loading.value;
     } else {
       print("Todo bien");
       borrar();

       ///Enviar a la siguente pantalla
       Navigator.popAndPushNamed(context, "home");
     }

 }

  String? validateTitle(String value) {
    if (value.isEmpty) {
      return "Requiered field";
    }
    return null;
  }

   void checkTitle() {
     if (_tituloKey.currentState!.validate()) {
       _tituloKey.currentState!.save();
       // If the form is valid, display a snackbar. In the real world,
       // you'd often call a server or save the information in a database.
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Processing Data')),
       );
       //Get.toNamed("/signUpForm");
     }else{
       return;
     }
   }

 @override
 void borrar() {
   tituloController.clear();
   descripcionController.clear();
   comentariosController.clear();
 }


}
