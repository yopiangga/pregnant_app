import 'dart:convert';

import 'package:pregnant_app/main.dart';
import 'package:pregnant_app/methods/get_category_by_index.dart';
import 'package:pregnant_app/methods/methods.dart';
import 'package:pregnant_app/models/models.dart';
import 'package:pregnant_app/providers/providers.dart';
import 'package:pregnant_app/services/services.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/shared.dart';
import '../widgets/widgets.dart';

part 'login_page.dart';
part 'main_page.dart';
part 'profile_page.dart';
part 'video_detail_page.dart';
part 'videos_page.dart';
part 'home_page.dart';
part 'announcement_page.dart';
