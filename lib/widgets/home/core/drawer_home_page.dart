import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/common/custom_snack_bar.dart.dart';
import 'package:workit/common/loader.dart';
import 'package:workit/controller/auth_controller.dart';
import 'package:workit/controller/user_controller.dart';
import 'package:workit/models/business.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/business/business_id.dart';
import 'package:workit/providers/business/businesses_notifier.dart';
import 'package:workit/providers/community/communities_notifier.dart';
import 'package:workit/providers/community/community_id.dart';
import 'package:workit/screens/business/business_detail_screen_admin.dart';
import 'package:workit/screens/community/community_detail_screen_admin.dart';
import 'package:workit/widgets/profile/list_tile_darwer.dart';
import 'package:workit/widgets/profile/profile_picture.dart';

class DrawerHomePage extends ConsumerWidget {
  const DrawerHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final futureUser = ref.watch(userDataFutureProvider);

    return Drawer(
      child: futureUser.when(
        data: (data) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 245,
              child: DrawerHeader(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfilePicture(profilePicture: data.imageUrl),
                      const SizedBox(height: 15),
                      Text(
                        data.fullName,
                        style: const TextStyle(
                            fontSize: 28,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (data.role == 'Admin' &&
                data.businessId != null &&
                data.businessId!.isNotEmpty)
              ListTileDrawer(
                  title: "My Business",
                  leadingIconData: Icons.business_sharp,
                  trailingIconData: Icons.arrow_right_alt_sharp,
                  onTap: () async {
                    final BusinessModel business = await ref
                        .read(businessesStateNotifierProvider.notifier)
                        .getBusinessById(data.businessId!);

                    ref.read(businessIdProvider.notifier).state = business.id;

                    if (context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BusinessDeatilScreenAdmin(business: business)));
                    }
                  }),
            if (data.role == 'Admin' &&
                data.communityId != null &&
                data.communityId!.isNotEmpty) ...[
              const SizedBox(height: 10),
              ListTileDrawer(
                  title: "My Community",
                  leadingIconData: Icons.apartment_outlined,
                  trailingIconData: Icons.arrow_right_alt_sharp,
                  onTap: () async {
                    // get community by Id with the Id in user.
                    Community myCommunity = await ref
                        .read(communitiesStateNotifierProvider.notifier)
                        .getCommunityById(data.communityId!);

                    // set the community Id Provider State to the community.id.
                    ref.read(communityIdProvider.notifier).state =
                        myCommunity.id;

                    //navigate to screen.
                    if (context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CommunityDetailScreenAdmin(
                                community: myCommunity,
                              )));
                    }
                  }),
            ],
            const SizedBox(height: 10),
            const ListTileDrawer(
              title: "Events",
              leadingIconData: Icons.event_available_outlined,
              trailingIconData: Icons.arrow_right_alt_sharp,
            ),
            const SizedBox(height: 10),
            const ListTileDrawer(
              title: "Settings",
              leadingIconData: Icons.settings,
              trailingIconData: Icons.arrow_right_alt_sharp,
            ),
            const Spacer(),
            ListTile(
              contentPadding: const EdgeInsets.only(bottom: 4),
              title: Text(
                data.email,
                style: theme.textTheme.labelLarge!.copyWith(fontSize: 22),
              ),
              leading: IconButton(
                onPressed: () async {
                  await ref.read(authControllerProvider).signOut();
                  await ref.read(userControllerProvider).deleteUser();
                },
                icon: Transform.rotate(
                    angle: pi,
                    child: const Icon(
                      Icons.logout_outlined,
                    )),
              ),
            )
          ],
        ),
        error: (Object error, StackTrace stackTrace) {
          CustomSnackBar.showSnackBar(context, error.toString());
          return null;
        },
        loading: () => const Loader(),
      ),
    );
  }
}
