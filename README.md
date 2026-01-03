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
* ![Uploading 1PNG.PNG…]()


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

This README provides a **full overview of the project, structure, features, dependencies, UI/UX highlights, and installation instructions**, making it easy for anyone to download, run, and understand the p
