import 'package:bryte/components/utils/palette.dart';
import 'package:bryte/components/utils/typography.dart';
import 'package:flutter/material.dart';

class ProfileStudent extends StatelessWidget {
  const ProfileStudent({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: 1 < 3 ? Palette.grey2 : Palette.orange2,
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              padding: const EdgeInsets.all(2),
              height: 25,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: 1 < 3 ? Palette.grey1 : Palette.orange1,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      'LEVEL',
                      style: BryteTypography.bodyRegular.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        color: 1 < 3 ? Palette.grey2 : Palette.orange2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '0',
                        style: BryteTypography.bodyRegular.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
