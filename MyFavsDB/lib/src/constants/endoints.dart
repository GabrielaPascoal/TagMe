//const String baseUrl = 'http://c809-179-107-254-4.ngrok-free.app/api';

abstract class Endpoints {
  static const String baseUrl = 'http://localhost:8080/api';
  
  // Auth
  static const String login = '$baseUrl/user';
  
  // Categories
  static const String categories = '$baseUrl/category';
  
                    // Items
                  static const String items = '$baseUrl/item';
                  static const String getItemsByCategory = '$baseUrl/item/get-by-category';
                  static const String addItem = '$baseUrl/item/add-item';
                  static const String updateItem = '$baseUrl/item/update-item';
                  static const String deleteItem = '$baseUrl/item/delete-item';
  
  // Search APIs
  static const String searchMovies = '$baseUrl/search/movies';
  static const String searchGames = '$baseUrl/search/games';
  static const String searchBooks = '$baseUrl/search/books';
  static const String searchAlbums = '$baseUrl/search/albums';
  
              // User Search
            static const String searchUsers = '$baseUrl/user/search';
            static const String getUserProfile = '$baseUrl/user/profile';
            
            // Global Search
            static const String globalSearch = '$baseUrl/search/global';
}