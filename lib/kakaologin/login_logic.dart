import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/services.dart';

Future<void> loginWithKakao({Function(int, String, String)? onProfileFetched}) async {
  try {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        // 토큰을 로컬 스토리지에 안전하게 저장
        await setToken(token);
        print('카카오톡으로 로그인 성공');
        await fetchProfile(onProfileFetched);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          await setToken(token);
          print('카카오계정으로 로그인 성공');
          await fetchProfile(onProfileFetched);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        await setToken(token);
        print('카카오계정으로 로그인 성공');
        await fetchProfile(onProfileFetched);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } catch (error) {
    print('카카오 로그인 중 오류 발생 $error');
  }
}

Future<void> setToken(OAuthToken token) async {
  // TokenManagerProvider를 통해 토큰을 저장
  TokenManagerProvider.instance.manager.setToken(token);
  print('토큰이 저장되었습니다.');
}

Future<void> fetchProfile(Function(int, String, String)? onProfileFetched) async {
  try {
    User user = await UserApi.instance.me();
    int userId = user.id.toInt();
    String nickname = user.kakaoAccount?.profile?.nickname ?? '';
    String email = user.kakaoAccount?.email ?? '';
    if (onProfileFetched != null) {
      onProfileFetched(userId, nickname, email);
    }
    print('사용자 프로필 가져오기 성공');
  } catch (error) {
    print('사용자 프로필 가져오기 실패 $error');
  }
}
