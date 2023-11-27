// import 'package:stack_appodeal_flutter/src/appodeal_platform_arguments.dart';
//
// abstract class NativeOptions with AppodealPlatformArguments {}
//
// class NativeCustomOptions extends NativeOptions {
//   final NativeBannerViewPosition? viewPosition;
//   final MediaViewPosition? mediaViewPosition;
//   final int? containerMargin;
//   final AdAttributionOptions? adAttributionOptions;
//   final CTAOptions? ctaOptions;
//   final DescriptionOptions? descriptionOptions;
//   final IconOptions? nativeIconOptions;
//   final MediaOptions? nativeMediaOptions;
//   final TitleOptions? titleOptions;
//
//   NativeCustomOptions({
//     this.viewPosition = NativeBannerViewPosition.ICON_START,
//     this.mediaViewPosition,
//     this.containerMargin,
//     this.adAttributionOptions,
//     this.ctaOptions,
//     this.descriptionOptions,
//     this.nativeIconOptions,
//     this.nativeMediaOptions,
//     this.titleOptions,
//   }) : super();
//
//   @override
//   Map<String, dynamic> get toMap => <String, dynamic>{
//     'mediaViewPosition': mediaViewPosition?.toString(),
//     'viewPosition': viewPosition?.toString(),
//     'containerMargin': containerMargin,
//     'adAttributionOptions': adAttributionOptions?.toMap,
//     'ctaOptions': ctaOptions?.toMap,
//     'descriptionOptions': descriptionOptions?.toMap,
//     'nativeIconOptions': nativeIconOptions?.toMap,
//     'nativeMediaOptions': nativeMediaOptions?.toMap,
//     'titleOptions': titleOptions?.toMap,
//   };
// }
//
// enum NativeBannerViewPosition { ICON_START, CTA_START }
//
// enum MediaViewPosition { TOP, BOTTOM }
//
//
// class NativeTemplateOptions extends NativeOptions {
//   final int? iconSize, titleTextSize, ctaTextSize, descriptionTextSize;
//   final Color? adAttributionBackgroundColor, adAttributionTextColor;
//
//   NativeTemplateOptions({
//     this.iconSize,
//     this.titleTextSize,
//     this.ctaTextSize,
//     this.descriptionTextSize,
//     this.adAttributionBackgroundColor,
//     this.adAttributionTextColor,
//   });
//
//   @override
//   Map<String, dynamic> get toMap => <String, dynamic>{
//     'iconSize': iconSize,
//     'titleTextSize': titleTextSize,
//     'ctaTextSize': ctaTextSize,
//     'descriptionTextSize': descriptionTextSize,
//     'adAttributionBackgroundColor': Utils.convertColorToInt(adAttributionBackgroundColor),
//     'adAttributionTextColor': Utils.convertColorToInt(adAttributionTextColor),
//   };
// }