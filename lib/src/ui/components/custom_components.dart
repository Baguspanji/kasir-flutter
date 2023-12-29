import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kasir_app/src/config/constans_assets.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageNetwork extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  const CustomImageNetwork(
    this.url, {
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.red,
              BlendMode.colorBurn,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      placeholder: (context, url) =>
          CustomShimmer(width: width, height: height),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          'Image Not Found',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black45,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const CustomShimmer({
    Key? key,
    required this.height,
    required this.width,
    this.radius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}

class CustomEmptyData extends StatelessWidget {
  final double height;
  final String text;
  final void Function()? onPressed;

  const CustomEmptyData({
    super.key,
    required this.height,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 50,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          if (onPressed != null)
            button(
              'Refresh',
              color: Colors.grey,
              onPressed: onPressed,
            ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(
            maxHeight: 24,
            maxWidth: 24,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class CustomRefresh extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final void Function()? onRefresh;
  final void Function()? onLoading;

  CustomRefresh({
    required this.controller,
    required this.child,
    this.onRefresh,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("Load Data baru");
          } else if (mode == LoadStatus.loading) {
            body = Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: primaryColor,
              ),
            );
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Data Gagal, Silahkan Coba Lagi");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("Tarik ke atas untuk load data");
          } else {
            body = Text("Tidak Ada Data Lagi");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: controller,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: WaterDropHeader(
        complete: Icon(
          Icons.check,
          color: Colors.white,
        ),
        waterDropColor: primaryColor,
        refresh: Container(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            color: primaryColor,
          ),
        ),
      ),
      child: child,
    );
  }
}
