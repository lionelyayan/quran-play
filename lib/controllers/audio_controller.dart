import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  late final AudioPlayer _player;

  bool _isHandlingCompleted = false;

  final isPlaying = false.obs;
  final isBuffering = false.obs;
  final currentUrl = ''.obs;
  final errorMessage = Rx<String?>(null);

  final position = Rx<Duration>(Duration.zero);
  final duration = Rx<Duration>(Duration.zero);

  final List<String> _playlist = [];
  final currentIndex = (-1).obs;
  final totalTracks = 0.obs;

  bool get hasPlaylist => totalTracks.value > 0;
  bool get hasNext => currentIndex.value < totalTracks.value - 1 && hasPlaylist;
  bool get hasPrevious => currentIndex.value > 0 && hasPlaylist;
  int get currentNumber =>
      hasPlaylist && currentIndex.value >= 0 ? currentIndex.value + 1 : 0;
  int get playlistLength => totalTracks.value;

  @override
  void onInit() {
    super.onInit();
    _player = AudioPlayer();
    _listenToPlayerState();
    _player.positionStream.listen((pos) => position.value = pos);
    _player.durationStream.listen(
      (dur) => duration.value = dur ?? Duration.zero,
    );
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  Future<void> play(String url) async {
    try {
      errorMessage.value = null;
      isBuffering.value = true;

      if (currentUrl.value != url) {
        currentUrl.value = url;
        await _player.stop();
        await _player.setUrl(url);
      }

      unawaited(_player.play());
    } catch (e) {
      errorMessage.value = 'Gagal memutar audio: $e';
      isPlaying.value = false;
      isBuffering.value = false;
    }
  }

  Future<void> pause() async => _player.pause();

  Future<void> stop() async {
    await _player.stop();
    currentUrl.value = '';
    currentIndex.value = -1;
    totalTracks.value = 0;
    position.value = Duration.zero;
    duration.value = Duration.zero;
    _playlist.clear();
  }

  Future<void> toggle(String url) async {
    if (currentUrl.value == url && isPlaying.value) {
      await pause();
    } else {
      _playlist.clear();
      currentIndex.value = -1;
      totalTracks.value = 0;
      await play(url);
    }
  }

  Future<void> playAll(List<String> urls, {int startIndex = 0}) async {
    if (urls.isEmpty) return;
    _playlist
      ..clear()
      ..addAll(urls);
    totalTracks.value = _playlist.length;
    currentIndex.value = startIndex;
    await play(_playlist[currentIndex.value]);
  }

  Future<void> next() async {
    if (!hasNext) return;
    currentIndex.value++;
    await play(_playlist[currentIndex.value]);
  }

  Future<void> previous() async {
    if (!hasPrevious) return;
    currentIndex.value--;
    await play(_playlist[currentIndex.value]);
  }

  Future<void> togglePlaylist(List<String> urls) async {
    if (hasPlaylist && isPlaying.value) {
      await pause();
    } else if (hasPlaylist && !isPlaying.value) {
      await play(_playlist[currentIndex.value]);
    } else {
      await playAll(urls);
    }
  }

  bool isCurrentTrack(String url) => currentUrl.value == url;
  bool isPlayingUrl(String url) => currentUrl.value == url && isPlaying.value;

  Future<void> seek(Duration pos) => _player.seek(pos);

  void _listenToPlayerState() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (_isHandlingCompleted) return;
        _isHandlingCompleted = true;

        isPlaying.value = false;
        isBuffering.value = false;

        Future.microtask(() async {
          if (hasNext) {
            currentIndex.value++;
            await play(_playlist[currentIndex.value]);
          } else {
            currentUrl.value = '';
            currentIndex.value = -1;
            totalTracks.value = 0; // ← reset Rx
            _playlist.clear();
            await _player.stop();
          }
          _isHandlingCompleted = false;
        });
        return;
      }

      isBuffering.value =
          state.processingState == ProcessingState.buffering ||
          state.processingState == ProcessingState.loading;
      isPlaying.value = state.playing;
    });
  }
}
