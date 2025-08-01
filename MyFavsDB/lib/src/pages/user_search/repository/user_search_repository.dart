import 'package:myfavsdb/src/constants/endoints.dart';
import 'package:myfavsdb/src/models/user_search_result.dart';
import 'package:myfavsdb/src/services/http_manager.dart';

class UserSearchRepository {
  final HttpManager _httpManager = HttpManager();

  Future<List<UserSearchResult>> searchUsers(String query) async {
    try {
      final result = await _httpManager.get(
        '${Endpoints.searchUsers}?query=$query',
      );

      if (result?.statusCode == 200 && result?.data != null) {
        final List<UserSearchResult> users = [];
        final data = result?.data['users'] as List?;
        
        if (data != null) {
          for (var item in data) {
            try {
              final user = UserSearchResult.fromMap(item);
              users.add(user);
            } catch (e) {
              print('Erro ao parsear usuário: $e');
            }
          }
        }
        return users;
      } else {
        return [];
      }
    } catch (e) {
      print('Erro na busca de usuários: $e');
      return [];
    }
  }

  Future<UserProfileResult?> getUserProfile(String email) async {
    try {
      final result = await _httpManager.get(
        '${Endpoints.getUserProfile}/$email',
      );

      if (result?.statusCode == 200 && result?.data != null) {
        return UserProfileResult.fromMap(result?.data);
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar perfil do usuário: $e');
      return null;
    }
  }
} 