import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget agImageProvider({
  String imgUrl,
  String imgTipo,
  BoxFit fit = BoxFit.cover,
}) {
 
  try {
    if (imgUrl?.isEmpty ?? true) return Image.asset('assets/noImage.jpg', fit: fit);
    //
    if (imgTipo == 'INT') return Image.asset('assets/$imgUrl', fit: fit);
    //
    // if (imgTipo == 'EXT') {
    //   try {
    //     return Image(
    //       fit: fit,
    //       image: !kIsWeb
    //           ? Image.network(imgUrl)
    //           : CacheImage(
    //               imgUrl,
    //               duration: Duration(seconds: 2),
    //               durationExpiration: Duration(seconds: 10),
    //             ),
    //     );
    //   } on Exception catch (_) {
    //     return Image.asset('assets/noImage.jpg', fit: fit);
    //   }
    // }
    //
    if (imgTipo == 'WEB' || imgTipo == 'EXT') {
      return kIsWeb
          ? Image.network(imgUrl , fit: fit, errorBuilder: (_,exp,stac) => Image.asset('assets/noImage.jpg', fit: fit) )
          : CachedNetworkImage(
              fit: fit,
              imageUrl: imgUrl,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/noImage.jpg', fit: fit),
            );
    }

    return Image.asset('assets/noImage.jpg', fit: fit);
  } on Exception catch (_) {
    return Image.asset('assets/noImage.jpg', fit: fit);
  }
}
