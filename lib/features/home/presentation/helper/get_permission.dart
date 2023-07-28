import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_play/features/home/presentation/bloc/home_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> getPermission(BuildContext context) async {
  PermissionStatus status = await Permission.audio.status;
  if (status.isDenied) {
    await Permission.audio.request();

    BlocProvider.of<HomeBloc>(context).add(GetAllSongEvent());
  } else {
    BlocProvider.of<HomeBloc>(context).add(GetAllSongEvent());
  }
}
