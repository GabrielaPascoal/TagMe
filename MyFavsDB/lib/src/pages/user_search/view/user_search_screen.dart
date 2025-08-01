import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfavsdb/src/models/user_search_result.dart';
import 'package:myfavsdb/src/pages/user_search/controller/user_search_controller.dart';
import 'package:myfavsdb/src/pages/user_profile/view/user_profile_screen.dart';
import 'package:myfavsdb/src/pages/common_widgets/search_bar_widget.dart';
import 'package:myfavsdb/src/pages/common_widgets/empty_state_widget.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final UserSearchController _controller = Get.put(UserSearchController());
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _controller.searchUsers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Buscar Usuários',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barra de pesquisa padronizada
          SearchBarWidget(
            controller: _searchController,
            hintText: 'Digite o email do usuário...',
            onChanged: _onSearchChanged,
            onClear: _controller.clearSearch,
          ),
          
          // Lista de resultados
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Buscando usuários...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              if (_controller.searchResults.isEmpty) {
                if (_controller.searchQuery.value.isNotEmpty) {
                  return const EmptyStateWidget(
                    icon: Icons.person_off,
                    title: 'Nenhum usuário encontrado',
                    subtitle: 'Tente usar um email diferente',
                  );
                }
                return const EmptyStateWidget(
                  icon: Icons.people,
                  title: 'Digite um email para buscar usuários',
                  subtitle: 'Encontre outros usuários e veja suas coleções',
                );
              }
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      '${_controller.searchResults.length} usuário(s) encontrado(s)',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final user = _controller.searchResults[index];
                        return _buildUserCard(user);
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(UserSearchResult user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shadowColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue[100],
          child: Text(
            user.email[0].toUpperCase(),
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        title: Text(
          user.email,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Icon(Icons.collections_bookmark, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${user.totalItems} itens',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.category, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${user.totalCategories} categorias',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfileScreen(userEmail: user.email),
            ),
          );
        },
      ),
    );
  }
} 