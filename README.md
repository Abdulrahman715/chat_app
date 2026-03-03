# Scholar Chat 🎓💬

تطبيق محادثة فورية متكامل مبني باستخدام إطار العمل **Flutter** ومنصة **Firebase**. يتيح التطبيق للمستخدمين التواصل بشكل حي وتجربة مستخدم سلسة.

## ✨ المميزات (Features)
- **نظام توثيق المستخدمين:** تسجيل حساب جديد وتسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور عبر `Firebase Auth`.
- **محادثة فورية (Real-time Chat):** إرسال واستقبال الرسائل لحظياً باستخدام `Cloud Firestore`.
- **واجهة مستخدم احترافية:** تصميم عصري باستخدام Custom Widgets و Google Fonts.
- **إدارة الحالة:** التعامل مع التحميل (Loading Indicators) والتحقق من صحة البيانات (Validation).
- **التمييز بين المرسل والمستقبل:** عرض فقاعات الدردشة (Chat Bubbles) بشكل مختلف بناءً على هوية المستخدم.

## 🛠 التقنيات المستخدمة (Tech Stack)
- **Flutter:** Mobile UI Framework.
- **Firebase Auth:** للتعامل مع حسابات المستخدمين.
- **Cloud Firestore:** كقاعدة بيانات سحابية لتخزين الرسائل.
- **Modal Progress HUD:** لعرض مؤشر التحميل أثناء العمليات.
- **Google Fonts:** لتحسين الخطوط داخل التطبيق.

## 📸 لقطات من التطبيق (Screenshots)

<p align="center">
  <img src="screenshots\login.jpg" width="30%" alt="Login Screen">
  <img src="screenshots\register.jpg" width="30%" alt="Register Screen">
  <img src="screenshots\chat_page.jpg" width="30%" alt="Chat Screen">
</p>

## 🚀 كيفية التشغيل
1. قم بعمل `Clone` للمستودع.
2. تأكد من إعداد مشروعك على **Firebase Console**.
3. أضف ملف `google-services.json` (للأندرويد) أو `GoogleService-Info.plist` (للآيفون).
4. نفذ الأمر `flutter pub get`.
5. قم بتشغيل التطبيق باستخدام `flutter run`.
