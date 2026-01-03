# 🏷️ App Overview – Shop / Store Flutter App

**App Name:** (Your App Name)
**Platform:** Flutter (Android & iOS)
**Purpose:** Full-featured e-commerce app with authentication, product catalog, favorites, product details, profile management, and integrated payment system.

---

## 📂 Project Structure

```
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
```

---

## 🌟 Key Features

* **User Authentication:**

  * Login, Signup, Forgot Password
  * Social Login via Google Sign-In

* **Product Catalog:**

  * Categorized products with search and filter
  * Carousel banners for promotions and featured items
  * Smooth scrolling and grid/list views

* **Favorites Management:**

  * Add or remove products from favorites
  * View all favorite items easily

* **Product Details:**

  * Detailed product info (name, price, description)
  * Ratings and user comments
  * Add to cart & buy now options

* **Profile Management:**

  * View and edit user information (name, address, contact)
  * My Orders screen with order history
  * Settings for notifications, payment methods, and dark mode

* **Navigation:**

  * Bottom navigation bar with icons for Home, Categories, Cart, Orders, and Profile
  * Smooth transitions between screens

* **Custom UI Components:**

  * Reusable widgets: buttons, search field, cards, circular progress indicators
  * Cached network images for better performance
  * Modern design with clean layout and vibrant colors

* **Payment Integration:**

  * Paymob integration for secure in-app payments
  * Multiple payment methods supported (card, wallet, cash on delivery)

* **Additional Features:**

  * Dark mode support
  * Push notifications for offers, updates, and orders
  * Carousel slider for banners & promotions
  * Responsive design for phones and tablets

---

## ⚙️ Core Dependencies

```yaml
flutter_lints: ^5.0.0
google_nav_bar: ^5.0.6
flutter_bloc: ^8.1.6
cached_network_image: ^3.3.1
flutter_rating_bar: ^4.0.1
supabase_flutter: ^2.8.0
google_sign_in: ^6.2.1
dio: ^5.9.0
pay_with_paymob: ^1.4.0
carousel_slider: ^5.1.1
```

---

## 🎨 UI/UX Highlights

* Modern, clean, minimalistic design
* Custom icons and intuitive navigation
* Fast and smooth transitions
* Dark mode available
* Optimized for performance with Flutter best practices

---

## ⚡ How to Run / Install

1. **Clone the repository:**

```bash
git clone <repository-url>
cd <project-folder>
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Set up environment variables / sensitive keys:**

* Configure your Supabase URL & API Key in `core/constant/sensetive_constant/`
* Configure Paymob keys in `store/sensetive.dart`

4. **Run the app on device or emulator:**

```bash
flutter run
```

5. **Build APK / iOS:**

```bash
flutter build apk --release
flutter build ios --release
```

6. **Login / Signup flow:**

* Use email/password or Google Sign-In to authenticate.

7. **Explore Features:**

* Browse products, add to favorites, view details, place orders, and make payments.

---

## 🖼️ App Screenshots

### Splash Screen

![Splash](https://github.com/user-attachments/assets/98d12f07-5696-44d9-9e68-aeee0ece6e24)

### Home Screen

![Home](https://github.com/user-attachments/assets/5a1569f8-1620-4a21-944d-47a48f2ce875)

### Product Details

![Product Details](https://github.com/user-attachments/assets/bfd4d8e4-41cd-4c6e-996e-53de8c738213)

### Cart

![Cart](https://github.com/user-attachments/assets/a492614e-94a7-45c3-9d01-ecc4717d393e)

### Profile

![Profile](https://github.com/user-attachments/assets/f3f4c443-0060-4fed-b339-1581ee9d8a79)

### Favorites

![Favorites](https://github.com/user-attachments/assets/1f65d67b-ef0c-4bfd-9d91-e947c3674724)

### Checkout

![Checkout](https://github.com/user-attachments/assets/6893d056-a5c3-4522-bc77-2a19923e6234)

### Settings

![Settings](https://github.com/user-attachments/assets/efacc9c8-32b6-416e-a797-7d43090f10fb)

### Search

![Search](https://github.com/user-attachments/assets/be5f44c9-e927-42af-ac9b-34f30bb40a82)

### See All Products

![See All](https://github.com/user-attachments/assets/f073a565-05e5-44e4-bfdc-d89303b06973)

### Banners / Promotions

![Banners](https://github.com/user-attachments/assets/20c7988b-86b3-471e-a391-6a2488d82964)
