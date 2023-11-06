import 'package:audio_player/consts/colors.dart';
import 'package:audio_player/controller/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/text_style.dart';
import 'player.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: whiteColor,
              ),
            )
          ],
          leading: Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text(
            "Beats",
            style: ourStyle(),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: true,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (BuildContext context, snapshot) {
              //.connectionState == ConnectionState.waiting
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
                //hasError || snapshot.data == null
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "Error loading songs",
                    style: ourStyle(),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var song = snapshot.data![index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Obx(
                          () => ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: bgColor,
                            title: Text(
                              song.title,
                              style: ourStyle(size: 15),
                            ),
                            subtitle: Text(
                              song.artist ?? "Unknown Artist",
                              style: ourStyle(size: 15),
                            ),
                            leading: QueryArtworkWidget(
                              id: song.id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Icon(
                                Icons.music_note,
                                color: whiteColor,
                                size: 32,
                              ),
                            ),
                            trailing: controller.playIndex.value == index &&
                                    controller.isPlaying.value
                                ? Icon(
                                    Icons.play_arrow,
                                    color: whiteColor,
                                    size: 26,
                                  )
                                : null,
                            onTap: () {
                              // controller.PlaySong(snapshot.data![index].uri, index);
                              Get.to(
                                () => Player(
                                  data: snapshot.data!,
                                ),
                                transition: Transition.downToUp,
                              );
                              controller.PlaySong(
                                  snapshot.data![index].uri, index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }));
  }
}
