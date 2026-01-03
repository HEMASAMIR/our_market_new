# 🏷️ App Overview – Goal Zone / Store Flutter App

**App Name:** (Your App Name)
**Platform:** Flutter (Android & iOS)
**Purpose:** Full-featured e-commerce app with authentication, product catalog, favorites, product details, profile management, and integrated payment system.

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

## 📱 Screens Included

1. **Authentication Screens:**

   * Login, Signup, Forgot Password
   * Custom text fields, buttons, and navigation

2. **Home / Categories:**

   * Featured products
   * Category list with icons and labels
   * Search bar for products

3. **Product Details:**

   * Images carousel
   * Ratings & reviews
   * Comments list
   * Add to cart / Buy now buttons

4. **Favorites:**

   * Favorite products list
   * Easy management of liked products

5. **Profile:**

   * Edit profile information
   * View order history
   * Settings

6. **Store / Checkout:**

   * Secure payment via Paymob
   * Order summary
   * Multiple payment methods

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

## 🛠️ Architecture & Structure

* **State Management:** Flutter BLoC
* **Networking:** Dio & Supabase
* **Caching:** CachedNetworkImage for better performance
* **Modular Structure:** Organized by `core`, `views`, `logic`, `ui`, and `widgets`
* **Reusable Components:** Buttons, cards, progress indicators, search fields

---

## 🎨 UI/UX Highlights

* Modern, clean, minimalistic design
* Custom icons and intuitive navigation
* Fast and smooth transitions
* Dark mode available
* Optimized for performance with Flutter best practices
