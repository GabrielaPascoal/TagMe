import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfavsdb/src/models/item_model.dart';
import 'package:myfavsdb/src/pages/auth/components/custom_text_field.dart';
import 'package:myfavsdb/src/pages/item/controller/item_controller.dart';
import 'package:myfavsdb/src/services/utils_services.dart';

class EditItemScreen extends StatefulWidget {
  final ItemModel item;
  
  const EditItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final titleController = TextEditingController();
  final ratingController = TextEditingController();
  final noteController = TextEditingController();
  final coverUrlController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  final utilsServices = UtilsServices();
  final itemController = Get.put(ItemController());

  final List<Map<String, dynamic>> categories = [
    {'name': 'Movies', 'value': 1},
    {'name': 'Series', 'value': 2},
    {'name': 'Albums', 'value': 3},
    {'name': 'Books', 'value': 4},
    {'name': 'Games', 'value': 5},
  ];

  Map<String, dynamic>? selectedCategory;

  @override
  void initState() {
    super.initState();
    // Preenche os campos com os dados atuais do item
    titleController.text = widget.item.title;
    ratingController.text = widget.item.myRating;
    noteController.text = widget.item.opinion;
    coverUrlController.text = widget.item.imgUrl;
    
    // Define a categoria atual
    selectedCategory = categories.firstWhere(
      (cat) => cat['name'] == widget.item.category,
      orElse: () => categories.first,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    ratingController.dispose();
    noteController.dispose();
    coverUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Editar Item'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown de categoria
              DropdownButtonFormField<Map<String, dynamic>>(
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  prefixIcon: const Icon(Icons.category, color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                value: selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: category,
                    child: Text(category['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Campo de título
              CustomTextField(
                controller: titleController,
                icon: Icons.title,
                label: 'Título',
                validator: (title) {
                  if (title == null || title.isEmpty) {
                    return 'Título é obrigatório!';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Campo de rating
              CustomTextField(
                controller: ratingController,
                icon: Icons.star_rate,
                label: 'Minha avaliação',
                validator: (rating) {
                  if (rating == null || rating.isEmpty) {
                    return 'Avaliação é obrigatória!';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Campo de nota
              CustomTextField(
                controller: noteController,
                icon: Icons.rate_review,
                label: 'Nota',
              ),
              
              const SizedBox(height: 16),
              
              // Campo de URL da imagem
              CustomTextField(
                controller: coverUrlController,
                icon: Icons.link,
                label: 'URL da imagem',
              ),
              
              const SizedBox(height: 24),
              
              // Botão de salvar
              SizedBox(
                height: 50,
                child: Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: itemController.isLoading.value
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await itemController.updateItem(
                                itemId: widget.item.id,
                                title: titleController.text,
                                myRating: ratingController.text,
                                opinion: noteController.text,
                                categoryId: selectedCategory!['value'],
                                imgUrl: coverUrlController.text,
                              );
                              
                              if (response.statusCode == 200) {
                                Navigator.of(context).pop();
                              } else {
                                utilsServices.showToast(
                                  message: response.returnMsg,
                                  isError: true,
                                );
                              }
                            }
                          },
                    child: itemController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Salvar',
                            style: TextStyle(fontSize: 18),
                          ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 