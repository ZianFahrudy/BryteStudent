import 'dart:developer';
import 'package:bryte/core/data/model/course/request/participant_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:bryte/core/blocs/participant/participant_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../components/utils/constant.dart';
import '../../../../components/utils/palette.dart';
import '../../../../components/utils/typography.dart';
import '../detail_profile_participant.dart';

class ParticipantContent extends StatefulWidget {
  const ParticipantContent({
    Key? key,
    required this.participantBloc,
    required this.idCourse,
  }) : super(key: key);

  final ParticipantBloc participantBloc;
  final String idCourse;

  @override
  State<ParticipantContent> createState() => _ParticipantContentState();
}

class _ParticipantContentState extends State<ParticipantContent> {
  final box = GetStorage();
  final _scrollController = ScrollController();

  int totalPage = 0;
  int participantTotal = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);

    return BlocConsumer<ParticipantBloc, ParticipantState>(
        listener: (context, state) {
      if (state is ParticipantSuccess) {
        log('participant successs');
      } else if (state is ParticipantFailure) {
        log('participant failure');
      }
      return;
    }, builder: (context, state) {
      if (state is ParticipantInitial ||
          state is ParticipantLoading &&
              widget.participantBloc.participants.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ParticipantSuccess) {
        totalPage = state.response.data[0].totPage;
        participantTotal = state.response.data[0].totParticipant;
        widget.participantBloc.isFetching = false;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } else if (state is ParticipantFailure &&
          widget.participantBloc.participants.isEmpty) {
        return const SizedBox();
      }
      return _buildParticipantSuccess(token, userId);
    });
  }

  Widget _buildParticipantSuccess(token, userId) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Participants',
                style: BryteTypography.headerExtraBold.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                participantTotal.toString(),
                style: BryteTypography.headerSemiBold.copyWith(
                    color: Palette.purple,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            height: 0,
            thickness: 1,
          ),
        ),
        SizedBox(
          height: Get.height - 260,
          child: ListView.separated(
            controller: _scrollController
              ..addListener(
                () {
                  if ((_scrollController.offset ==
                              _scrollController.position.maxScrollExtent &&
                          !widget.participantBloc.isFetching) &&
                      widget.participantBloc.page != totalPage + 1) {
                    widget.participantBloc
                      ..isFetching = true
                      ..add(
                        GetParticipantEvent(
                          body: ParticipantBody(
                            token: token,
                            userid: userId,
                            idCourse: widget.idCourse,
                            page: widget.participantBloc.page,
                          ),
                        ),
                      );
                    log(widget.participantBloc.page.toString());
                  }
                },
              ),
            // shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Card(
                elevation: 2,
                shadowColor: Palette.purple,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  onTap: () => Get.to(() => const DetailProfileParticipant()),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: 2 < 3 ? Palette.grey2 : Palette.orange2,
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  widget
                                      .participantBloc.participants[index].img,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 0,
                            //   left: 0,
                            //   right: 0,
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(
                            //         15,
                            //       ),
                            //     ),
                            //     margin: const EdgeInsets.symmetric(
                            //       horizontal: 5,
                            //     ),
                            //     padding: const EdgeInsets.all(2),
                            //     height: 16,
                            //     child: Container(
                            //       alignment: Alignment.center,
                            //       decoration: BoxDecoration(
                            //           color:
                            //               1 < 3 ? Palette.grey1 : Palette.orange1,
                            //           borderRadius: BorderRadius.circular(10)),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //         crossAxisAlignment: CrossAxisAlignment.center,
                            //         children: [
                            //           const Spacer(),
                            //           Text(
                            //             'LVL',
                            //             style: BryteTypography.bodyRegular.copyWith(
                            //               color: Colors.white,
                            //               fontSize: 8,
                            //             ),
                            //           ),
                            //           const Spacer(),
                            //           Container(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 5),
                            //             decoration: BoxDecoration(
                            //                 color: 4 < 3
                            //                     ? Palette.grey2
                            //                     : Palette.orange2,
                            //                 borderRadius:
                            //                     BorderRadius.circular(10)),
                            //             child: Text(
                            //               '4',
                            //               style: BryteTypography.bodyRegular
                            //                   .copyWith(color: Colors.white),
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: Get.width - 200,
                          child: Text(
                            widget.participantBloc.participants[index].name,
                            style: BryteTypography.titleExtraBold.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          color: Palette.purple,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: widget.participantBloc.participants.length,
          ),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
