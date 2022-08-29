import 'package:flutter/material.dart';

import '../local_widget/profile_participant.dart';

class DetailProfileParticipant extends StatelessWidget {
  const DetailProfileParticipant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ProfileParticipant(),
          ],
        ),
      ),
    );
  }
}
