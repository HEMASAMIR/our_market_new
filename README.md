#Goal Zone🛒

---

## Description
**Our Market** is a production-ready Flutter e-commerce app designed for a seamless shopping experience.  
It features **authentication**, **product catalog**, **favorites**, **profile management**, **detailed product views**, and more.  
Built with **Clean Architecture** and **Bloc** for maintainable and scalable code.

---

## Features

- User Authentication (Login, Signup, Forgot Password)  
- Product Catalog with Categories  
- Favorites Management  
- Product Details with Ratings & Comments  
- Profile Management & Editing  
- Bottom Navigation Bar  
- Smooth UI with custom reusable widgets  
- Cached Network Images for performance  
- Payment Integration with Paymob  
- Carousel for banners & promotions  

---

## Dependencies

```yaml
flutter_lints: ^5.0.0
google_nav_bar: ^5.0.6
flutter_bloc: ^8.1.6
cached_network_image: ^3.3.1
flutter_rating_bar: ^4.0.1
supabase_flutter: ^2.8.0
google_sign_in: ^6.2.1
flutter_automation: ^2.0.0
dio: ^5.9.0

lib/
├── main.dart
├── core/
│   ├── api_services.dart
│   ├── app_colors.dart
│   ├── my_observer.dart
│   ├── components/
│   │   ├── cache_image.dart
│   │   ├── custom_circle_pro_ind.dart
│   │   ├── custom_search_field.dart
│   │   ├── products_list.dart
│   │   └── product_card.dart
│   ├── constant/
│   │   ├── const.dart
│   │   └── sensetive_constant/
│   ├── cubit/
│   │   ├── home_cubit.dart
│   │   └── home_state.dart
│   ├── functions/
│   │   ├── build_appbar.dart
│   │   ├── navigate_to.dart
│   │   ├── navigate_without_back.dart
│   │   └── show_msg.dart
│   └── models/
│       ├── banners_model/
│       │   └── banners_model.dart
│       └── product_model/
│           ├── favorite_product.dart
│           ├── product_model.dart
│           └── purchase_table.dart
├── views/
│   ├── auth/
│   │   ├── logic/
│   │   │   ├── cubit/
│   │   │   │   ├── authentication_cubit.dart
│   │   │   │   └── authentication_state.dart
│   │   │   └── models/
│   │   │       └── user_model.dart
│   │   └── ui/
│   │       ├── forgot_view.dart
│   │       ├── login_view.dart
│   │       ├── signup_view.dart
│   │       └── widgets/
│   │           ├── custom_arrow_btn.dart
│   │           ├── custom_elevated_btn.dart
│   │           ├── custom_row_with_arrow.dart
│   │           ├── custom_text_btn.dart
│   │           └── custom_text_field.dart
│   ├── favorite/ui/
│   │   └── favorite_view.dart
│   ├── home/ui/
│   │   ├── category_view.dart
│   │   ├── home_view.dart
│   │   ├── search_view.dart
│   │   ├── see_all.dart
│   │   └── widgets/
│   │       ├── categories_list.dart
│   │       └── Untitled-1.dart
│   ├── nav_bar/
│   │   ├── logic/cubit/
│   │   │   ├── nav_bar_cubit.dart
│   │   │   └── nav_bar_state.dart
│   │   └── ui/
│   │       └── main_home_view.dart
│   ├── product_details/
│   │   ├── logic/cubit/
│   │   │   ├── product_details_cubit.dart
│   │   │   └── product_details_state.dart
│   │   ├── logic/models/
│   │   │   └── rate_model.dart
│   │   └── ui/
│   │       ├── product_details_view.dart
│   │       └── widgets/
│   │           └── comments_list.dart
│   ├── profile/ui/
│   │   ├── edit_name_view.dart
│   │   ├── my_orders.dart
│   │   ├── profile_view.dart
│   │   └── widgets/
│   │       └── custom_row_btn.dart
│   └── store/
│       ├── sensetive.dart
│       └── ui/
│           └── store_view.dart
 Quick Start
1 - Clone the repo
git clone https://github.com/<your-username>/our_market_new_fixed.git
cd our_market_new_fixed
2 - Install dependencies:
flutter pub get
 3 - Run the app:flutter run
 Make sure Flutter SDK >= 3.38 and a device/emulator is connected.

https://github.com/HEMASAMIR/our_market_new/blob/0fd2d0e99b6df5d2f01d0a0aa0737690aaa95bd4/1.jpeg
pay_with_paymob: ^1.4.0
carousel_slider: ^5.1.1
![Image](https://github.com/user-attachments/assets/5db47ca7-6296-4f53-a10a-4306ecd2def6)
![Image](https://github.com/user-attachments/assets/d29a3763-848b-4cd8-b79e-f349d3976451)
![Image](https://github.com/user-attachments/assets/7a214e27-9be9-4557-a8b9-efc446b1a90f)
![Image](https://github.com/user-attachments/assets/c47438f9-95b4-4fbe-bd01-051681e38128)
![Image](https://github.com/user-attachments/assets/6ab7e3e9-2cf6-4569-9889-38a190f2622b)
![Image](https://github.com/user-attachments/assets/8edd8858-d559-4f85-b42d-05ae67232228)
![Image](https://github.com/user-attachments/assets/9170d778-028a-4cf5-8da5-dbf845d82c6a)
![Image](https://github.com/user-attachments/assets/2aa2c2ed-c162-4821-b51a-3c3df93c0d83)
![Image](https://github.com/user-attachments/assets/3f8dcc78-51e2-472f-8ac4-5d0e11a48bc0)
![Image](https://github.com/user-attachments/assets/5c3eeb4b-1156-4c76-8dc9-94bc8459b99c)
![Image](https://github.com/user-attachments/assets/fb201a4f-3a00-4ad9-a6e5-a4ed096efc92)
![Image](https://github.com/user-attachments/assets/cdd2c255-1967-4129-9892-0e592b4aab22)
