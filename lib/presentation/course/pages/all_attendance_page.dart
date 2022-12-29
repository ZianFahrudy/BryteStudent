import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:bryte/core/blocs/attendance_rate/attendance_rate_bloc.dart';
import 'package:bryte/core/data/model/profile/request/attendance_rate_student.dart';
import 'package:bryte/core/di/injection.dart';
import 'package:bryte/presentation/profile/local_widgets/dropdown_attd_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import '../../../components/utils/constant.dart';
import '../../../components/widgets/back_button.dart';
import '../../../core/blocs/attendance_rate/bloc/attendance_rate_det_bloc.dart';
import '../../../core/data/model/profile/response/attendance_rate_student_model.dart';

class AllAttendancePage extends StatefulWidget {
  const AllAttendancePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AllAttendancePage> createState() => _AllAttendancePageState();
}

class _AllAttendancePageState extends State<AllAttendancePage> {
  final attRateBloc = getIt<AttendanceRateBloc>();
  final attRateDetBloc = getIt<AttendanceRateDetBloc>();

  String attdRate = '';
  final selectedValue = ValueNotifier<String>('0');

  List<DataAttendanceRateStudentModel> dataAttendanceRates = [];

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final token = box.read(KeyConstant.token);
    final userId = box.read(KeyConstant.userId);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => attRateBloc
            ..add(
              GetAttendanceRateStudentEvent(
                body: AttendanceRateStudentBody(
                    token: token, userid: userId, idAperiod: ''),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => attRateDetBloc
            ..add(
              GetAttendaceRateDetEvent(
                body: AttendanceRateStudentBody(
                    token: token, userid: userId, idAperiod: '0'),
              ),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButtonAppBar(),
          title: Image.asset(
            AssetConstant.bryteLogoWhite,
            width: 59,
          ),
          centerTitle: true,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AttendanceRateBloc, AttendanceRateState>(
              listener: (context, state) {
                if (state is AttendanceRateSuccess) {
                  attdRate = state.response.data[0].attdRate[0];
                  setState(() {});
                }
              },
            ),
            BlocListener<AttendanceRateDetBloc, AttendanceRateDetState>(
              listener: (context, state) {
                if (state is AttendanceRateDetSuccess) {
                  dataAttendanceRates = state.response.data;
                  setState(() {});
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shadowColor: Palette.purple.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Current Attendance Rate',
                              style: BryteTypography.headerExtraBold.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff666666),
                                  fontFamily: 'SF Pro Bold'),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              attdRate,
                              style: BryteTypography.headerExtraBold.copyWith(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w700,
                                  color: Palette.purple,
                                  fontFamily: 'SF Pro Bold'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                ),
                DropdownAttdRate(
                  attendanceRateDetBloc: attRateDetBloc,
                  selectedValue: selectedValue,
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    dataAttendanceRates.length,
                    (index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    dataAttendanceRates[index].academicPeriod!,
                                    style: BryteTypography.titleSemiBold
                                        .copyWith(
                                            fontSize: 15,
                                            fontFamily: 'SF Pro Bold',
                                            fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' • ' +
                                        dataAttendanceRates[index]
                                            .attendance![0]
                                            .currentSksTot
                                            .toString() +
                                        ' credits',
                                    style:
                                        BryteTypography.titleSemiBold.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                dataAttendanceRates[index]
                                    .attendance![0]
                                    .currentAttdRate,
                                style: BryteTypography.titleSemiBold.copyWith(
                                  color: Palette.purple,
                                ),
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Column(
                            children: List.generate(
                              dataAttendanceRates[index]
                                  .attendance![0]
                                  .details
                                  .length,
                              (ind) => Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  left: 30,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Get.width - 150,
                                      child: Text(
                                        '${dataAttendanceRates[index].attendance![0].details[ind].courseName} ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: BryteTypography.titleMedium
                                            .copyWith(
                                                color: const Color(
                                                  0xffA2A2A2,
                                                ),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                      ),
                                    ),
                                    Text(
                                      dataAttendanceRates[index]
                                          .attendance![0]
                                          .details[ind]
                                          .attdRate,
                                      style: BryteTypography.titleSemiBold
                                          .copyWith(
                                        color: const Color(0xffA2A2A2),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
