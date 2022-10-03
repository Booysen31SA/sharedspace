# sharedspace

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# IOS m1
sudo arch -x86_64 gem install ffi
# go to ios folder then run
arch -x86_64 pod install

# Test this example
// first group_user then inside do a stream to group
  Stream<UserModel?> getCurrentUserModelStream() {
    return FirebaseAuth.instance.authStateChanges().asyncExpand<UserModel?>(
      (currentUser) {
        if (currentUser == null) {
          return Stream.value(null);
        }
        return FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .snapshots()
            .map((doc) {
          final userData = doc.data();
          if (userData == null) {
            return null;
          }
          return UserModel.fromJson(userData);
        });
      },
    );
  }
