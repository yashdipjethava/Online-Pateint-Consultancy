import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key, required this.uid, required this.userName, required this.userId});
  final String uid;
  final String userName;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 306848818,
        appSign:
            "949a770098eee3ea0e7b5abe1c7dba897446e34267c4d77c5aa621df64a8d4a2",
        callID: uid,
        userID: userId,
        userName: userName,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
