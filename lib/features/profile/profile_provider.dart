import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProfile {
  final String name;
  final String email;
  final String bio;

  UserProfile({
    required this.name,
    required this.email,
    required this.bio,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? bio,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }
}

class ProfileNotifier extends StateNotifier<UserProfile> {
  final Box _box;

  ProfileNotifier(this._box)
    : super(
        UserProfile(
          name: _box.get('name', defaultValue: 'Utilisateur'),
          email: _box.get('email', defaultValue: 'votre@email.com'),
          bio: _box.get('bio', defaultValue: 'Parlez-nous de vous...'),
        ),
      );

  void updateProfile({String? name, String? email, String? bio}) {
    state = state.copyWith(name: name, email: email, bio: bio);
    _box.put('name', state.name);
    _box.put('email', state.email);
    _box.put('bio', state.bio);
  }
}

final profileBoxProvider = Provider<Box>((ref) {
  return Hive.box('settings'); // On utilise la boîte settings déjà existante
});

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile>((ref) {
  return ProfileNotifier(ref.watch(profileBoxProvider));
});
