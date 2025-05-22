import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/widget/list_skeleton.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

abstract class BaseScreen<T extends GetxController> extends GetView<T> {
  const BaseScreen({super.key});

  Widget buildMobile(BuildContext context);
  Widget? buildTablet(BuildContext context) => null;
  Widget? buildDesktop(BuildContext context) => null;
  Widget? buildWatch(BuildContext context) => null;
  Widget? buildLoading(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ResponsiveBuilder(
          builder: (builderContext, sizingInformation) {
            switch (sizingInformation.deviceScreenType) {
              case DeviceScreenType.desktop:
                return buildDesktop(context) ?? buildMobile(context);
              case DeviceScreenType.tablet:
                return buildTablet(context) ?? buildMobile(context);
              case DeviceScreenType.mobile:
                return buildMobile(context);
              case DeviceScreenType.watch:
                return buildWatch(context) ?? buildMobile(context);
              default:
                return buildMobile(context);
            }
          },
        ),
        buildLoading(context) ?? const ListSkeleton(),
      ],
    );
  }
}
