import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages_routes/app_pages.dart';
import '../../services/utils_services.dart';
import '../auth/components/custom_text_field.dart';
import '../auth/controller/auth_controller.dart';
import '../movie_search/view/movie_search_screen.dart';
import '../game_search/view/game_search_screen.dart';
import '../book_search/view/book_search_screen.dart';
import '../album_search/view/album_search_screen.dart';
import 'controller/adicionar_controller.dart';

class AdicionarScreen extends StatefulWidget {
  const AdicionarScreen({Key? key}) : super(key: key);

  @override
  State<AdicionarScreen> createState() => _AdicionarScreenState();
}

class _AdicionarScreenState extends State<AdicionarScreen> {
  final categoryController = TextEditingController();
  final titleController = TextEditingController();
  final ratingController = TextEditingController();
  final noteController = TextEditingController();
  final coverUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final utilsServices = UtilsServices();

  final List<Map<String, dynamic>> items = [
    {'name': 'Movies', 'value': 1},
    {'name': 'Series', 'value': 2},
    {'name': 'Albums', 'value': 3},
    {'name': 'Books', 'value': 4},
    {'name': 'Games', 'value': 5},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final adicionarController = Get.put(AdicionarController());

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Novo Item',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),

                  // Formulário
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Dropdown
                          Obx(() {
                            return DropdownButtonFormField<
                                Map<String, dynamic>>(
                              padding: const EdgeInsets.only(bottom: 15),
                              decoration: InputDecoration(
                                labelText: 'Category',
                                prefixIcon: const Icon(Icons.category),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              value: adicionarController.selectedItem.value,
                              items: items.map((item) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: item,
                                  child: Text(item['name']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                adicionarController.setSelectedItem(value!);
                              },
                            );
                          }),

                          // Campo de título com botão de busca
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: titleController,
                                      icon: Icons.title,
                                      label: 'Title',
                                      validator: (title) {
                                        if (title == null || title.isEmpty) {
                                          return 'Title is required!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                                                     // Botão de busca para todas as categorias
                                   Obx(() {
                                     final selectedCategory = adicionarController.selectedItem.value?['name'];
                                     final hasSearch = selectedCategory == 'Movies' ||
                                                     selectedCategory == 'Series' ||
                                                     selectedCategory == 'Games' ||
                                                     selectedCategory == 'Books' ||
                                                     selectedCategory == 'Albums';
                                    
                                     return AnimatedContainer(
                                       duration: const Duration(milliseconds: 300),
                                       height: 56,
                                       child: hasSearch
                                           ? Container(
                                               width: 36,
                                               height: 36,
                                               child: ElevatedButton(
                                                 style: ElevatedButton.styleFrom(
                                                   backgroundColor: Colors.grey[200],
                                                   foregroundColor: Colors.grey[700],
                                                   elevation: 0,
                                                   padding: EdgeInsets.zero,
                                                   shape: const CircleBorder(),
                                                 ),
                                                 onPressed: () async {
                                                   Widget searchScreen;
                                                   
                                                   switch (selectedCategory) {
                                                     case 'Movies':
                                                     case 'Series':
                                                       searchScreen = const MovieSearchScreen();
                                                       break;
                                                     case 'Games':
                                                       searchScreen = const GameSearchScreen();
                                                       break;
                                                     case 'Books':
                                                       searchScreen = const BookSearchScreen();
                                                       break;
                                                     case 'Albums':
                                                       searchScreen = const AlbumSearchScreen();
                                                       break;
                                                     default:
                                                       return;
                                                   }
                                                   
                                                   final result = await Navigator.push(
                                                     context,
                                                     MaterialPageRoute(
                                                       builder: (context) => searchScreen,
                                                     ),
                                                   );
                                                   
                                                   if (result != null) {
                                                     setState(() {
                                                       titleController.text = result['title'] ?? '';
                                                       coverUrlController.text = result['imgUrl'] ?? '';
                                                       noteController.text = result['overview'] ?? '';
                                                     });
                                                   }
                                                 },
                                                 child: const Icon(
                                                   Icons.search,
                                                   size: 16,
                                                 ),
                                               ),
                                             )
                                           : const SizedBox.shrink(),
                                     );
                                   }),
                                ],
                              ),

                            ],
                          ),

                          CustomTextField(
                            controller: ratingController,
                            icon: Icons.star_rate,
                            label: 'My rating',
                            validator: (rating) {
                              if (rating == null || rating.isEmpty) {
                                return 'Rating is required!';
                              }
                              return null;
                            },
                          ),

                          CustomTextField(
                            controller: noteController,
                            icon: Icons.rate_review,
                            label: 'Note',
                          ),

                          CustomTextField(
                            controller: coverUrlController,
                            icon: Icons.link,
                            label: 'Poster Url',
                          ),

                          SizedBox(
                            height: 50,
                            child: Obx(() {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: adicionarController.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          adicionarController
                                              .adicionarItem(
                                            categoryId: adicionarController.selectedItem.value?['value'],
                                            title: titleController.text,
                                            opinion: noteController.text,
                                            myRating: ratingController.text,
                                            imgUrl: coverUrlController.text
                                          )
                                              .then((response) async {
                                            if (response.statusCode == 200) {
                                              // Aguarda um pouco para garantir que a atualização foi processada
                                              await Future.delayed(const Duration(milliseconds: 300));
                                              Navigator.of(context).pop();
                                            } else {
                                              utilsServices.showToast(
                                                message: response.returnMsg,
                                                isError: true,
                                              );
                                            }
                                          });
                                        }
                                      },
                                child: adicionarController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        'Adicionar',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
