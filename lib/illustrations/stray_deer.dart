import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/palettes/core_palette.dart';

// max_width coefficient is 1
class StrayDeerPainter extends CustomPainter {
  StrayDeerPainter({required this.colorPalette, required this.colorScheme});

  final CorePalette colorPalette;
  final ColorScheme colorScheme;

  @override
  void paint(final Canvas canvas, final Size size) {
    final Color deerTracks = Color(colorPalette.tertiary.get(70));
    final Color mailBag = Color(colorPalette.tertiary.get(80));
    final Color contourColor = Color(colorPalette.tertiary.get(10));
    final Color deerSkin = const Color(
      0xffe0ac9c,
    ).harmonizeWith(colorScheme.primary);

    final Path path0 =
        Path()
          ..moveTo(size.width * 0.6099773, size.height * 0.6719577)
          ..lineTo(size.width * 0.6088435, size.height * 0.6719577)
          ..lineTo(size.width * 0.6148904, size.height * 0.6727135)
          ..lineTo(size.width * 0.6099773, size.height * 0.6719577)
          ..close()
          ..moveTo(size.width * 0.5593348, size.height * 0.6723356)
          ..cubicTo(
            size.width * 0.5525321,
            size.height * 0.6723356,
            size.width * 0.5461073,
            size.height * 0.6738473,
            size.width * 0.5400605,
            size.height * 0.6761149,
          )
          ..lineTo(size.width * 0.5476190, size.height * 0.6806500)
          ..cubicTo(
            size.width * 0.5529101,
            size.height * 0.6798942,
            size.width * 0.5585790,
            size.height * 0.6806500,
            size.width * 0.5634921,
            size.height * 0.6787604,
          )
          ..cubicTo(
            size.width * 0.5653817,
            size.height * 0.6780045,
            size.width * 0.5680272,
            size.height * 0.6764928,
            size.width * 0.5680272,
            size.height * 0.6746032,
          )
          ..cubicTo(
            size.width * 0.5680272,
            size.height * 0.6727135,
            size.width * 0.5653817,
            size.height * 0.6727135,
            size.width * 0.5642479,
            size.height * 0.6727135,
          )
          ..lineTo(size.width * 0.5593348, size.height * 0.6727135)
          ..close()
          ..moveTo(size.width * 0.6757370, size.height * 0.6727135)
          ..lineTo(size.width * 0.6700680, size.height * 0.6730915)
          ..cubicTo(
            size.width * 0.6681784,
            size.height * 0.6734694,
            size.width * 0.6655329,
            size.height * 0.6730915,
            size.width * 0.6636432,
            size.height * 0.6746032,
          )
          ..lineTo(size.width * 0.6636432, size.height * 0.6753590)
          ..lineTo(size.width * 0.6723356, size.height * 0.6810280)
          ..lineTo(size.width * 0.6874528, size.height * 0.6825397)
          ..cubicTo(
            size.width * 0.6897203,
            size.height * 0.6825397,
            size.width * 0.6923658,
            size.height * 0.6832955,
            size.width * 0.6938776,
            size.height * 0.6814059,
          )
          ..cubicTo(
            size.width * 0.6953893,
            size.height * 0.6798942,
            size.width * 0.6931217,
            size.height * 0.6776266,
            size.width * 0.6919879,
            size.height * 0.6772487,
          )
          ..arcToPoint(
            Offset(size.width * 0.6757370, size.height * 0.6727135),
            radius: Radius.elliptical(
              size.width * 0.03325775,
              size.height * 0.03325775,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..close()
          ..moveTo(size.width * 0.5971277, size.height * 0.6768707)
          ..cubicTo(
            size.width * 0.5997732,
            size.height * 0.6780045,
            size.width * 0.6027967,
            size.height * 0.6780045,
            size.width * 0.6054422,
            size.height * 0.6768707,
          )
          ..close()
          ..moveTo(size.width * 0.4950869, size.height * 0.6814059)
          ..lineTo(size.width * 0.4924414, size.height * 0.6814059)
          ..cubicTo(
            size.width * 0.4909297,
            size.height * 0.6814059,
            size.width * 0.4886621,
            size.height * 0.6814059,
            size.width * 0.4871504,
            size.height * 0.6825397,
          )
          ..lineTo(size.width * 0.4833711, size.height * 0.6912320)
          ..cubicTo(
            size.width * 0.4894180,
            size.height * 0.6904762,
            size.width * 0.4954649,
            size.height * 0.6904762,
            size.width * 0.5011338,
            size.height * 0.6882086,
          )
          ..cubicTo(
            size.width * 0.5030234,
            size.height * 0.6874528,
            size.width * 0.5049131,
            size.height * 0.6866969,
            size.width * 0.5064248,
            size.height * 0.6851852,
          )
          ..cubicTo(
            size.width * 0.5071807,
            size.height * 0.6840514,
            size.width * 0.5056689,
            size.height * 0.6829176,
            size.width * 0.5045351,
            size.height * 0.6825397,
          )
          ..cubicTo(
            size.width * 0.5015117,
            size.height * 0.6817838,
            size.width * 0.4984883,
            size.height * 0.6814059,
            size.width * 0.4950869,
            size.height * 0.6814059,
          )
          ..close()
          ..moveTo(size.width * 0.6303855, size.height * 0.6832955)
          ..arcToPoint(
            Offset(size.width * 0.6179138, size.height * 0.6863190),
            radius: Radius.elliptical(
              size.width * 0.03401361,
              size.height * 0.03401361,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.6167800,
            size.height * 0.6866969,
            size.width * 0.6148904,
            size.height * 0.6874528,
            size.width * 0.6148904,
            size.height * 0.6889645,
          )
          ..cubicTo(
            size.width * 0.6148904,
            size.height * 0.6904762,
            size.width * 0.6167800,
            size.height * 0.6904762,
            size.width * 0.6175359,
            size.height * 0.6900983,
          )
          ..lineTo(size.width * 0.6179138, size.height * 0.6938776)
          ..cubicTo(
            size.width * 0.6250945,
            size.height * 0.6934996,
            size.width * 0.6322751,
            size.height * 0.6934996,
            size.width * 0.6386999,
            size.height * 0.6904762,
          )
          ..cubicTo(
            size.width * 0.6398337,
            size.height * 0.6900983,
            size.width * 0.6417234,
            size.height * 0.6889645,
            size.width * 0.6413454,
            size.height * 0.6874528,
          )
          ..cubicTo(
            size.width * 0.6405896,
            size.height * 0.6851852,
            size.width * 0.6379441,
            size.height * 0.6848073,
            size.width * 0.6360544,
            size.height * 0.6840514,
          )
          ..lineTo(size.width * 0.6303855, size.height * 0.6832955)
          ..close()
          ..moveTo(size.width * 0.7959184, size.height * 0.6885865)
          ..lineTo(size.width * 0.7932729, size.height * 0.6889645)
          ..lineTo(size.width * 0.7932729, size.height * 0.6893424)
          ..lineTo(size.width * 0.7932729, size.height * 0.6893424)
          ..lineTo(size.width * 0.7951625, size.height * 0.6980348)
          ..arcToPoint(
            Offset(size.width * 0.8148148, size.height * 0.7018141),
            radius: Radius.elliptical(
              size.width * 0.02116402,
              size.height * 0.02116402,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.8163265,
            size.height * 0.7010582,
            size.width * 0.8178382,
            size.height * 0.6999244,
            size.width * 0.8170824,
            size.height * 0.6980348,
          )
          ..cubicTo(
            size.width * 0.8163265,
            size.height * 0.6961451,
            size.width * 0.8140590,
            size.height * 0.6946334,
            size.width * 0.8121693,
            size.height * 0.6938776,
          )
          ..arcToPoint(
            Offset(size.width * 0.7981859, size.height * 0.6885865),
            radius: Radius.elliptical(
              size.width * 0.03665911,
              size.height * 0.03665911,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..lineTo(size.width * 0.7959184, size.height * 0.6885865)
          ..close()
          ..moveTo(size.width * 0.7448980, size.height * 0.6900983)
          ..lineTo(size.width * 0.7430083, size.height * 0.6900983)
          ..cubicTo(
            size.width * 0.7407407,
            size.height * 0.6904762,
            size.width * 0.7384732,
            size.height * 0.6916100,
            size.width * 0.7369615,
            size.height * 0.6938776,
          )
          ..cubicTo(
            size.width * 0.7365835,
            size.height * 0.6938776,
            size.width * 0.7369615,
            size.height * 0.6946334,
            size.width * 0.7369615,
            size.height * 0.6946334,
          )
          ..lineTo(size.width * 0.7369615, size.height * 0.6999244)
          ..cubicTo(
            size.width * 0.7418745,
            size.height * 0.7006803,
            size.width * 0.7467876,
            size.height * 0.7014361,
            size.width * 0.7520786,
            size.height * 0.7006803,
          )
          ..cubicTo(
            size.width * 0.7543462,
            size.height * 0.7006803,
            size.width * 0.7566138,
            size.height * 0.6999244,
            size.width * 0.7585034,
            size.height * 0.6980348,
          )
          ..cubicTo(
            size.width * 0.7600151,
            size.height * 0.6969010,
            size.width * 0.7585034,
            size.height * 0.6953893,
            size.width * 0.7573696,
            size.height * 0.6942555,
          )
          ..cubicTo(
            size.width * 0.7535903,
            size.height * 0.6919879,
            size.width * 0.7494331,
            size.height * 0.6897203,
            size.width * 0.7448980,
            size.height * 0.6900983,
          )
          ..close()
          ..moveTo(size.width * 0.4357521, size.height * 0.6961451)
          ..lineTo(size.width * 0.4349962, size.height * 0.7052154)
          ..cubicTo(
            size.width * 0.4399093,
            size.height * 0.7055933,
            size.width * 0.4448224,
            size.height * 0.7040816,
            size.width * 0.4489796,
            size.height * 0.7014361,
          )
          ..cubicTo(
            size.width * 0.4504913,
            size.height * 0.7010582,
            size.width * 0.4523810,
            size.height * 0.7003023,
            size.width * 0.4531368,
            size.height * 0.6991686,
          )
          ..cubicTo(
            size.width * 0.4538927,
            size.height * 0.6980348,
            size.width * 0.4527589,
            size.height * 0.6972789,
            size.width * 0.4520030,
            size.height * 0.6972789,
          )
          ..cubicTo(
            size.width * 0.4489796,
            size.height * 0.6961451,
            size.width * 0.4459562,
            size.height * 0.6972789,
            size.width * 0.4433107,
            size.height * 0.6965231,
          )
          ..lineTo(size.width * 0.4357521, size.height * 0.6961451)
          ..close()
          ..moveTo(size.width * 0.3408919, size.height * 0.6999244)
          ..arcToPoint(
            Offset(size.width * 0.3250189, size.height * 0.7052154),
            radius: Radius.elliptical(
              size.width * 0.03401361,
              size.height * 0.03401361,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..lineTo(size.width * 0.3208617, size.height * 0.7108844)
          ..cubicTo(
            size.width * 0.3465608,
            size.height * 0.7146636,
            size.width * 0.3522298,
            size.height * 0.6999244,
            size.width * 0.3408919,
            size.height * 0.6999244,
          )
          ..close()
          ..moveTo(size.width * 0.8435374, size.height * 0.7195767)
          ..cubicTo(
            size.width * 0.8420257,
            size.height * 0.7195767,
            size.width * 0.8405140,
            size.height * 0.7199546,
            size.width * 0.8397581,
            size.height * 0.7210884,
          )
          ..lineTo(size.width * 0.8344671, size.height * 0.7248677)
          ..cubicTo(
            size.width * 0.8359788,
            size.height * 0.7271353,
            size.width * 0.8374906,
            size.height * 0.7297808,
            size.width * 0.8397581,
            size.height * 0.7312925,
          )
          ..cubicTo(
            size.width * 0.8416478,
            size.height * 0.7328042,
            size.width * 0.8446712,
            size.height * 0.7324263,
            size.width * 0.8473167,
            size.height * 0.7324263,
          )
          ..cubicTo(
            size.width * 0.8488284,
            size.height * 0.7324263,
            size.width * 0.8510960,
            size.height * 0.7324263,
            size.width * 0.8526077,
            size.height * 0.7309146,
          )
          ..cubicTo(
            size.width * 0.8541194,
            size.height * 0.7286470,
            size.width * 0.8533636,
            size.height * 0.7260015,
            size.width * 0.8522298,
            size.height * 0.7241119,
          )
          ..arcToPoint(
            Offset(size.width * 0.8431595, size.height * 0.7195767),
            radius: Radius.elliptical(
              size.width * 0.01020408,
              size.height * 0.01020408,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..close()
          ..moveTo(size.width * 0.2883598, size.height * 0.7237339)
          ..cubicTo(
            size.width * 0.2853364,
            size.height * 0.7237339,
            size.width * 0.2808012,
            size.height * 0.7244898,
            size.width * 0.2743764,
            size.height * 0.7256236,
          )
          ..lineTo(size.width * 0.2660620, size.height * 0.7343159)
          ..cubicTo(
            size.width * 0.2834467,
            size.height * 0.7331822,
            size.width * 0.3012094,
            size.height * 0.7237339,
            size.width * 0.2883598,
            size.height * 0.7237339,
          )
          ..close()
          ..moveTo(size.width * 0.8907785, size.height * 0.7241119)
          ..lineTo(size.width * 0.8892668, size.height * 0.7241119)
          ..lineTo(size.width * 0.8869992, size.height * 0.7278912)
          ..cubicTo(
            size.width * 0.8881330,
            size.height * 0.7312925,
            size.width * 0.8904006,
            size.height * 0.7331822,
            size.width * 0.8926682,
            size.height * 0.7350718,
          )
          ..cubicTo(
            size.width * 0.8945578,
            size.height * 0.7369615,
            size.width * 0.8964475,
            size.height * 0.7388511,
            size.width * 0.8990930,
            size.height * 0.7403628,
          )
          ..cubicTo(
            size.width * 0.9006047,
            size.height * 0.7411187,
            size.width * 0.9028723,
            size.height * 0.7422525,
            size.width * 0.9043840,
            size.height * 0.7418745,
          )
          ..cubicTo(
            size.width * 0.9058957,
            size.height * 0.7411187,
            size.width * 0.9058957,
            size.height * 0.7392290,
            size.width * 0.9062736,
            size.height * 0.7380952,
          )
          ..cubicTo(
            size.width * 0.9062736,
            size.height * 0.7339380,
            size.width * 0.9047619,
            size.height * 0.7294029,
            size.width * 0.9009826,
            size.height * 0.7271353,
          )
          ..cubicTo(
            size.width * 0.8987150,
            size.height * 0.7256236,
            size.width * 0.8956916,
            size.height * 0.7248677,
            size.width * 0.8926682,
            size.height * 0.7244898,
          )
          ..lineTo(size.width * 0.8907785, size.height * 0.7244898)
          ..close()
          ..moveTo(size.width * 0.2078609, size.height * 0.7373394)
          ..cubicTo(
            size.width * 0.2029478,
            size.height * 0.7388511,
            size.width * 0.1976568,
            size.height * 0.7388511,
            size.width * 0.1931217,
            size.height * 0.7414966,
          )
          ..cubicTo(
            size.width * 0.1908541,
            size.height * 0.7430083,
            size.width * 0.1893424,
            size.height * 0.7464097,
            size.width * 0.1912320,
            size.height * 0.7486772,
          )
          ..cubicTo(
            size.width * 0.1931217,
            size.height * 0.7509448,
            size.width * 0.1965231,
            size.height * 0.7513228,
            size.width * 0.1991686,
            size.height * 0.7517007,
          )
          ..cubicTo(
            size.width * 0.2048375,
            size.height * 0.7517007,
            size.width * 0.2105064,
            size.height * 0.7517007,
            size.width * 0.2154195,
            size.height * 0.7490552,
          )
          ..arcToPoint(
            Offset(size.width * 0.2214664, size.height * 0.7452759),
            radius: Radius.elliptical(
              size.width * 0.02645503,
              size.height * 0.02645503,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.2226002,
            size.height * 0.7445200,
            size.width * 0.2237339,
            size.height * 0.7422525,
            size.width * 0.2222222,
            size.height * 0.7407407,
          )
          ..cubicTo(
            size.width * 0.2203326,
            size.height * 0.7388511,
            size.width * 0.2173091,
            size.height * 0.7380952,
            size.width * 0.2146636,
            size.height * 0.7384732,
          )
          ..cubicTo(
            size.width * 0.2135299,
            size.height * 0.7384732,
            size.width * 0.2123961,
            size.height * 0.7392290,
            size.width * 0.2116402,
            size.height * 0.7399849,
          )
          ..close()
          ..moveTo(size.width * 0.1583522, size.height * 0.7392290)
          ..cubicTo(
            size.width * 0.1572184,
            size.height * 0.7392290,
            size.width * 0.1564626,
            size.height * 0.7392290,
            size.width * 0.1553288,
            size.height * 0.7399849,
          )
          ..cubicTo(
            size.width * 0.1545729,
            size.height * 0.7403628,
            size.width * 0.1541950,
            size.height * 0.7411187,
            size.width * 0.1541950,
            size.height * 0.7422525,
          )
          ..lineTo(size.width * 0.1466364, size.height * 0.7422525)
          ..cubicTo(
            size.width * 0.1436130,
            size.height * 0.7441421,
            size.width * 0.1405896,
            size.height * 0.7460317,
            size.width * 0.1379441,
            size.height * 0.7490552,
          )
          ..cubicTo(
            size.width * 0.1364324,
            size.height * 0.7505669,
            size.width * 0.1341648,
            size.height * 0.7528345,
            size.width * 0.1341648,
            size.height * 0.7551020,
          )
          ..cubicTo(
            size.width * 0.1349206,
            size.height * 0.7573696,
            size.width * 0.1371882,
            size.height * 0.7577475,
            size.width * 0.1390779,
            size.height * 0.7577475,
          )
          ..cubicTo(
            size.width * 0.1451247,
            size.height * 0.7577475,
            size.width * 0.1504157,
            size.height * 0.7554800,
            size.width * 0.1557067,
            size.height * 0.7520786,
          )
          ..cubicTo(
            size.width * 0.1579743,
            size.height * 0.7505669,
            size.width * 0.1594860,
            size.height * 0.7482993,
            size.width * 0.1617536,
            size.height * 0.7464097,
          )
          ..cubicTo(
            size.width * 0.1628874,
            size.height * 0.7448980,
            size.width * 0.1647770,
            size.height * 0.7426304,
            size.width * 0.1628874,
            size.height * 0.7407407,
          )
          ..arcToPoint(
            Offset(size.width * 0.1583522, size.height * 0.7392290),
            radius: Radius.elliptical(
              size.width * 0.007558579,
              size.height * 0.007558579,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..close()
          ..moveTo(size.width * 0.8764172, size.height * 0.7505669)
          ..lineTo(size.width * 0.8726379, size.height * 0.7532124)
          ..cubicTo(
            size.width * 0.8737717,
            size.height * 0.7569917,
            size.width * 0.8733938,
            size.height * 0.7615268,
            size.width * 0.8756614,
            size.height * 0.7645503,
          )
          ..lineTo(size.width * 0.8794407, size.height * 0.7694633)
          ..cubicTo(
            size.width * 0.8809524,
            size.height * 0.7705971,
            size.width * 0.8832200,
            size.height * 0.7717309,
            size.width * 0.8851096,
            size.height * 0.7705971,
          )
          ..cubicTo(
            size.width * 0.8862434,
            size.height * 0.7694633,
            size.width * 0.8866213,
            size.height * 0.7675737,
            size.width * 0.8862434,
            size.height * 0.7660620,
          )
          ..cubicTo(
            size.width * 0.8862434,
            size.height * 0.7630385,
            size.width * 0.8847317,
            size.height * 0.7600151,
            size.width * 0.8832200,
            size.height * 0.7573696,
          )
          ..cubicTo(
            size.width * 0.8824641,
            size.height * 0.7547241,
            size.width * 0.8809524,
            size.height * 0.7520786,
            size.width * 0.8783069,
            size.height * 0.7513228,
          )
          ..arcToPoint(
            Offset(size.width * 0.8764172, size.height * 0.7509448),
            radius: Radius.elliptical(
              size.width * 0.007558579,
              size.height * 0.007558579,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..close()
          ..moveTo(size.width * 0.1190476, size.height * 0.7709751)
          ..cubicTo(
            size.width * 0.1190476,
            size.height * 0.7709751,
            size.width * 0.1190476,
            size.height * 0.7709751,
            size.width * 0.1190476,
            size.height * 0.7709751,
          )
          ..cubicTo(
            size.width * 0.1171580,
            size.height * 0.7709751,
            size.width * 0.1156463,
            size.height * 0.7713530,
            size.width * 0.1145125,
            size.height * 0.7721088,
          )
          ..lineTo(size.width * 0.1141345, size.height * 0.7728647)
          ..lineTo(size.width * 0.1111111, size.height * 0.7739985)
          ..cubicTo(
            size.width * 0.1092215,
            size.height * 0.7762661,
            size.width * 0.1073318,
            size.height * 0.7785336,
            size.width * 0.1065760,
            size.height * 0.7815571,
          )
          ..cubicTo(
            size.width * 0.1061980,
            size.height * 0.7834467,
            size.width * 0.1065760,
            size.height * 0.7853364,
            size.width * 0.1080877,
            size.height * 0.7860922,
          )
          ..cubicTo(
            size.width * 0.1095994,
            size.height * 0.7868481,
            size.width * 0.1114890,
            size.height * 0.7860922,
            size.width * 0.1130008,
            size.height * 0.7853364,
          )
          ..cubicTo(
            size.width * 0.1156463,
            size.height * 0.7834467,
            size.width * 0.1182918,
            size.height * 0.7815571,
            size.width * 0.1205593,
            size.height * 0.7785336,
          )
          ..cubicTo(
            size.width * 0.1213152,
            size.height * 0.7766440,
            size.width * 0.1220711,
            size.height * 0.7747543,
            size.width * 0.1216931,
            size.height * 0.7728647,
          )
          ..cubicTo(
            size.width * 0.1216931,
            size.height * 0.7713530,
            size.width * 0.1201814,
            size.height * 0.7709751,
            size.width * 0.1190476,
            size.height * 0.7709751,
          )
          ..close()
          ..moveTo(size.width * 0.9213908, size.height * 0.7739985)
          ..lineTo(size.width * 0.9172336, size.height * 0.7758881)
          ..cubicTo(
            size.width * 0.9142101,
            size.height * 0.7808012,
            size.width * 0.9126984,
            size.height * 0.7868481,
            size.width * 0.9123205,
            size.height * 0.7925170,
          )
          ..cubicTo(
            size.width * 0.9123205,
            size.height * 0.7940287,
            size.width * 0.9111867,
            size.height * 0.7962963,
            size.width * 0.9123205,
            size.height * 0.7974301,
          )
          ..cubicTo(
            size.width * 0.9138322,
            size.height * 0.7981859,
            size.width * 0.9157218,
            size.height * 0.7974301,
            size.width * 0.9168556,
            size.height * 0.7970522,
          )
          ..arcToPoint(
            Offset(size.width * 0.9263039, size.height * 0.7845805),
            radius: Radius.elliptical(
              size.width * 0.01511716,
              size.height * 0.01511716,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.9263039,
            size.height * 0.7808012,
            size.width * 0.9259259,
            size.height * 0.7770219,
            size.width * 0.9229025,
            size.height * 0.7743764,
          )
          ..arcToPoint(
            Offset(size.width * 0.9213908, size.height * 0.7743764),
            radius: Radius.elliptical(
              size.width * 0.002267574,
              size.height * 0.002267574,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..close()
          ..moveTo(size.width * 0.1511716, size.height * 0.7902494)
          ..lineTo(size.width * 0.1451247, size.height * 0.8027211)
          ..cubicTo(
            size.width * 0.1466364,
            size.height * 0.8061224,
            size.width * 0.1485261,
            size.height * 0.8099017,
            size.width * 0.1519274,
            size.height * 0.8117914,
          )
          ..cubicTo(
            size.width * 0.1553288,
            size.height * 0.8133031,
            size.width * 0.1594860,
            size.height * 0.8140590,
            size.width * 0.1625094,
            size.height * 0.8121693,
          )
          ..cubicTo(
            size.width * 0.1643991,
            size.height * 0.8114135,
            size.width * 0.1651550,
            size.height * 0.8091459,
            size.width * 0.1651550,
            size.height * 0.8072562,
          )
          ..cubicTo(
            size.width * 0.1643991,
            size.height * 0.8015873,
            size.width * 0.1625094,
            size.height * 0.7959184,
            size.width * 0.1575964,
            size.height * 0.7928949,
          )
          ..arcToPoint(
            Offset(size.width * 0.1511716, size.height * 0.7902494),
            radius: Radius.elliptical(
              size.width * 0.01511716,
              size.height * 0.01511716,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..close()
          ..moveTo(size.width * 0.8805745, size.height * 0.8008314)
          ..lineTo(size.width * 0.8779289, size.height * 0.8012094)
          ..arcToPoint(
            Offset(size.width * 0.8643235, size.height * 0.8087680),
            radius: Radius.elliptical(
              size.width * 0.03665911,
              size.height * 0.03665911,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.8635676,
            size.height * 0.8099017,
            size.width * 0.8643235,
            size.height * 0.8110355,
            size.width * 0.8650794,
            size.height * 0.8110355,
          )
          ..cubicTo(
            size.width * 0.8673469,
            size.height * 0.8114135,
            size.width * 0.8699924,
            size.height * 0.8117914,
            size.width * 0.8722600,
            size.height * 0.8110355,
          )
          ..cubicTo(
            size.width * 0.8752834,
            size.height * 0.8102797,
            size.width * 0.8779289,
            size.height * 0.8087680,
            size.width * 0.8798186,
            size.height * 0.8065004,
          )
          ..cubicTo(
            size.width * 0.8809524,
            size.height * 0.8053666,
            size.width * 0.8817082,
            size.height * 0.8042328,
            size.width * 0.8813303,
            size.height * 0.8027211,
          )
          ..cubicTo(
            size.width * 0.8813303,
            size.height * 0.8019652,
            size.width * 0.8805745,
            size.height * 0.8012094,
            size.width * 0.8809524,
            size.height * 0.8008314,
          )
          ..close()
          ..moveTo(size.width * 0.8030990, size.height * 0.8216175)
          ..lineTo(size.width * 0.7985639, size.height * 0.8227513)
          ..arcToPoint(
            Offset(size.width * 0.7910053, size.height * 0.8276644),
            radius: Radius.elliptical(
              size.width * 0.02267574,
              size.height * 0.02267574,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.7902494,
            size.height * 0.8287982,
            size.width * 0.7910053,
            size.height * 0.8303099,
            size.width * 0.7921391,
            size.height * 0.8306878,
          )
          ..cubicTo(
            size.width * 0.7947846,
            size.height * 0.8321995,
            size.width * 0.7974301,
            size.height * 0.8321995,
            size.width * 0.8004535,
            size.height * 0.8318216,
          )
          ..cubicTo(
            size.width * 0.8046107,
            size.height * 0.8318216,
            size.width * 0.8087680,
            size.height * 0.8303099,
            size.width * 0.8129252,
            size.height * 0.8295540,
          )
          ..cubicTo(
            size.width * 0.8140590,
            size.height * 0.8291761,
            size.width * 0.8155707,
            size.height * 0.8280423,
            size.width * 0.8136810,
            size.height * 0.8272865,
          )
          ..lineTo(size.width * 0.8046107, size.height * 0.8216175)
          ..lineTo(size.width * 0.8030990, size.height * 0.8216175)
          ..close()
          ..moveTo(size.width * 0.8499622, size.height * 0.8280423)
          ..cubicTo(
            size.width * 0.8473167,
            size.height * 0.8284203,
            size.width * 0.8450491,
            size.height * 0.8295540,
            size.width * 0.8427816,
            size.height * 0.8310658,
          )
          ..cubicTo(
            size.width * 0.8405140,
            size.height * 0.8321995,
            size.width * 0.8382464,
            size.height * 0.8340892,
            size.width * 0.8374906,
            size.height * 0.8363568,
          )
          ..cubicTo(
            size.width * 0.8367347,
            size.height * 0.8374906,
            size.width * 0.8374906,
            size.height * 0.8393802,
            size.width * 0.8386243,
            size.height * 0.8397581,
          )
          ..cubicTo(
            size.width * 0.8408919,
            size.height * 0.8401361,
            size.width * 0.8435374,
            size.height * 0.8397581,
            size.width * 0.8458050,
            size.height * 0.8393802,
          )
          ..cubicTo(
            size.width * 0.8480726,
            size.height * 0.8386243,
            size.width * 0.8507181,
            size.height * 0.8382464,
            size.width * 0.8526077,
            size.height * 0.8367347,
          )
          ..cubicTo(
            size.width * 0.8544974,
            size.height * 0.8356009,
            size.width * 0.8563870,
            size.height * 0.8340892,
            size.width * 0.8575208,
            size.height * 0.8321995,
          )
          ..cubicTo(
            size.width * 0.8582766,
            size.height * 0.8306878,
            size.width * 0.8563870,
            size.height * 0.8303099,
            size.width * 0.8552532,
            size.height * 0.8299320,
          )
          ..lineTo(size.width * 0.8533636, size.height * 0.8299320)
          ..close()
          ..moveTo(size.width * 0.1375661, size.height * 0.8291761)
          ..cubicTo(
            size.width * 0.1364324,
            size.height * 0.8291761,
            size.width * 0.1356765,
            size.height * 0.8291761,
            size.width * 0.1345427,
            size.height * 0.8299320,
          )
          ..cubicTo(
            size.width * 0.1341648,
            size.height * 0.8299320,
            size.width * 0.1334089,
            size.height * 0.8306878,
            size.width * 0.1334089,
            size.height * 0.8314437,
          )
          ..lineTo(size.width * 0.1303855, size.height * 0.8352230)
          ..cubicTo(
            size.width * 0.1296296,
            size.height * 0.8374906,
            size.width * 0.1315193,
            size.height * 0.8397581,
            size.width * 0.1334089,
            size.height * 0.8412698,
          )
          ..lineTo(size.width * 0.1379441, size.height * 0.8450491)
          ..arcToPoint(
            Offset(size.width * 0.1455026, size.height * 0.8480726),
            radius: Radius.elliptical(
              size.width * 0.01133787,
              size.height * 0.01133787,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.1481481,
            size.height * 0.8480726,
            size.width * 0.1511716,
            size.height * 0.8469388,
            size.width * 0.1530612,
            size.height * 0.8450491,
          )
          ..cubicTo(
            size.width * 0.1541950,
            size.height * 0.8431595,
            size.width * 0.1530612,
            size.height * 0.8412698,
            size.width * 0.1523054,
            size.height * 0.8393802,
          )
          ..cubicTo(
            size.width * 0.1496599,
            size.height * 0.8356009,
            size.width * 0.1458806,
            size.height * 0.8329554,
            size.width * 0.1421013,
            size.height * 0.8303099,
          )
          ..cubicTo(
            size.width * 0.1409675,
            size.height * 0.8295540,
            size.width * 0.1390779,
            size.height * 0.8291761,
            size.width * 0.1375661,
            size.height * 0.8291761,
          )
          ..close()
          ..moveTo(size.width * 0.6749811, size.height * 0.8363568)
          ..lineTo(size.width * 0.6742252, size.height * 0.8363568)
          ..cubicTo(
            size.width * 0.6708239,
            size.height * 0.8363568,
            size.width * 0.6674225,
            size.height * 0.8363568,
            size.width * 0.6643991,
            size.height * 0.8378685,
          )
          ..lineTo(size.width * 0.6598639, size.height * 0.8405140)
          ..cubicTo(
            size.width * 0.6606198,
            size.height * 0.8416478,
            size.width * 0.6621315,
            size.height * 0.8424036,
            size.width * 0.6636432,
            size.height * 0.8427816,
          )
          ..lineTo(size.width * 0.6712018, size.height * 0.8446712)
          ..cubicTo(
            size.width * 0.6749811,
            size.height * 0.8458050,
            size.width * 0.6798942,
            size.height * 0.8461829,
            size.width * 0.6836735,
            size.height * 0.8442933,
          )
          ..cubicTo(
            size.width * 0.6851852,
            size.height * 0.8431595,
            size.width * 0.6870748,
            size.height * 0.8420257,
            size.width * 0.6866969,
            size.height * 0.8405140,
          )
          ..cubicTo(
            size.width * 0.6866969,
            size.height * 0.8386243,
            size.width * 0.6848073,
            size.height * 0.8378685,
            size.width * 0.6829176,
            size.height * 0.8374906,
          )
          ..cubicTo(
            size.width * 0.6806500,
            size.height * 0.8367347,
            size.width * 0.6776266,
            size.height * 0.8363568,
            size.width * 0.6749811,
            size.height * 0.8363568,
          )
          ..close()
          ..moveTo(size.width * 0.2003023, size.height * 0.8401361)
          ..cubicTo(
            size.width * 0.1984127,
            size.height * 0.8401361,
            size.width * 0.1965231,
            size.height * 0.8401361,
            size.width * 0.1946334,
            size.height * 0.8412698,
          )
          ..cubicTo(
            size.width * 0.1938776,
            size.height * 0.8416478,
            size.width * 0.1916100,
            size.height * 0.8424036,
            size.width * 0.1931217,
            size.height * 0.8431595,
          )
          ..lineTo(size.width * 0.1931217, size.height * 0.8442933)
          ..cubicTo(
            size.width * 0.1931217,
            size.height * 0.8465608,
            size.width * 0.1953893,
            size.height * 0.8480726,
            size.width * 0.1969010,
            size.height * 0.8488284,
          )
          ..cubicTo(
            size.width * 0.2006803,
            size.height * 0.8503401,
            size.width * 0.2044596,
            size.height * 0.8510960,
            size.width * 0.2082389,
            size.height * 0.8507181,
          )
          ..cubicTo(
            size.width * 0.2101285,
            size.height * 0.8503401,
            size.width * 0.2120181,
            size.height * 0.8495843,
            size.width * 0.2127740,
            size.height * 0.8480726,
          )
          ..cubicTo(
            size.width * 0.2135299,
            size.height * 0.8458050,
            size.width * 0.2123961,
            size.height * 0.8439153,
            size.width * 0.2105064,
            size.height * 0.8427816,
          )
          ..cubicTo(
            size.width * 0.2074830,
            size.height * 0.8408919,
            size.width * 0.2040816,
            size.height * 0.8401361,
            size.width * 0.2003023,
            size.height * 0.8401361,
          )
          ..close()
          ..moveTo(size.width * 0.5816327, size.height * 0.8439153)
          ..cubicTo(
            size.width * 0.5782313,
            size.height * 0.8439153,
            size.width * 0.5752079,
            size.height * 0.8446712,
            size.width * 0.5721844,
            size.height * 0.8450491,
          )
          ..cubicTo(
            size.width * 0.5691610,
            size.height * 0.8458050,
            size.width * 0.5661376,
            size.height * 0.8465608,
            size.width * 0.5646259,
            size.height * 0.8495843,
          )
          ..lineTo(size.width * 0.5661376, size.height * 0.8507181)
          ..lineTo(size.width * 0.5714286, size.height * 0.8522298)
          ..cubicTo(
            size.width * 0.5752079,
            size.height * 0.8533636,
            size.width * 0.5789872,
            size.height * 0.8537415,
            size.width * 0.5827664,
            size.height * 0.8533636,
          )
          ..arcToPoint(
            Offset(size.width * 0.5903250, size.height * 0.8514739),
            radius: Radius.elliptical(
              size.width * 0.02267574,
              size.height * 0.02267574,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.5918367,
            size.height * 0.8507181,
            size.width * 0.5933485,
            size.height * 0.8492063,
            size.width * 0.5922147,
            size.height * 0.8476946,
          )
          ..cubicTo(
            size.width * 0.5910809,
            size.height * 0.8461829,
            size.width * 0.5891912,
            size.height * 0.8454271,
            size.width * 0.5873016,
            size.height * 0.8446712,
          )
          ..cubicTo(
            size.width * 0.5854119,
            size.height * 0.8439153,
            size.width * 0.5835223,
            size.height * 0.8439153,
            size.width * 0.5816327,
            size.height * 0.8439153,
          )
          ..close()
          ..moveTo(size.width * 0.7403628, size.height * 0.8492063)
          ..cubicTo(
            size.width * 0.7384732,
            size.height * 0.8492063,
            size.width * 0.7365835,
            size.height * 0.8499622,
            size.width * 0.7346939,
            size.height * 0.8507181,
          )
          ..cubicTo(
            size.width * 0.7324263,
            size.height * 0.8510960,
            size.width * 0.7309146,
            size.height * 0.8544974,
            size.width * 0.7328042,
            size.height * 0.8567649,
          )
          ..cubicTo(
            size.width * 0.7339380,
            size.height * 0.8578987,
            size.width * 0.7358277,
            size.height * 0.8578987,
            size.width * 0.7373394,
            size.height * 0.8582766,
          )
          ..cubicTo(
            size.width * 0.7426304,
            size.height * 0.8590325,
            size.width * 0.7482993,
            size.height * 0.8594104,
            size.width * 0.7524565,
            size.height * 0.8571429,
          )
          ..cubicTo(
            size.width * 0.7547241,
            size.height * 0.8563870,
            size.width * 0.7562358,
            size.height * 0.8552532,
            size.width * 0.7577475,
            size.height * 0.8533636,
          )
          ..cubicTo(
            size.width * 0.7585034,
            size.height * 0.8518519,
            size.width * 0.7566138,
            size.height * 0.8510960,
            size.width * 0.7554800,
            size.height * 0.8507181,
          )
          ..lineTo(size.width * 0.7543462, size.height * 0.8507181)
          ..lineTo(size.width * 0.7418745, size.height * 0.8492063)
          ..lineTo(size.width * 0.7403628, size.height * 0.8492063)
          ..close()
          ..moveTo(size.width * 0.3287982, size.height * 0.8552532)
          ..lineTo(size.width * 0.3208617, size.height * 0.8560091)
          ..cubicTo(
            size.width * 0.3159486,
            size.height * 0.8567649,
            size.width * 0.3117914,
            size.height * 0.8586546,
            size.width * 0.3087680,
            size.height * 0.8620559,
          )
          ..lineTo(size.width * 0.3087680, size.height * 0.8665911)
          ..lineTo(size.width * 0.3140590, size.height * 0.8665911)
          ..cubicTo(
            size.width * 0.3208617,
            size.height * 0.8650794,
            size.width * 0.3276644,
            size.height * 0.8647014,
            size.width * 0.3340892,
            size.height * 0.8624339,
          )
          ..cubicTo(
            size.width * 0.3356009,
            size.height * 0.8616780,
            size.width * 0.3378685,
            size.height * 0.8609221,
            size.width * 0.3378685,
            size.height * 0.8590325,
          )
          ..cubicTo(
            size.width * 0.3382464,
            size.height * 0.8571429,
            size.width * 0.3359788,
            size.height * 0.8560091,
            size.width * 0.3340892,
            size.height * 0.8556311,
          )
          ..lineTo(size.width * 0.3287982, size.height * 0.8556311)
          ..close()
          ..moveTo(size.width * 0.3083900, size.height * 0.8665911)
          ..lineTo(size.width * 0.3083900, size.height * 0.8665911)
          ..close()
          ..moveTo(size.width * 0.4546485, size.height * 0.8601663)
          ..cubicTo(
            size.width * 0.4527589,
            size.height * 0.8601663,
            size.width * 0.4508692,
            size.height * 0.8601663,
            size.width * 0.4489796,
            size.height * 0.8609221,
          )
          ..cubicTo(
            size.width * 0.4463341,
            size.height * 0.8616780,
            size.width * 0.4436886,
            size.height * 0.8631897,
            size.width * 0.4433107,
            size.height * 0.8658352,
          )
          ..lineTo(size.width * 0.4444444, size.height * 0.8684807)
          ..lineTo(size.width * 0.4493575, size.height * 0.8688587)
          ..cubicTo(
            size.width * 0.4542706,
            size.height * 0.8696145,
            size.width * 0.4591837,
            size.height * 0.8696145,
            size.width * 0.4640967,
            size.height * 0.8688587,
          )
          ..cubicTo(
            size.width * 0.4659864,
            size.height * 0.8688587,
            size.width * 0.4678760,
            size.height * 0.8681028,
            size.width * 0.4693878,
            size.height * 0.8662132,
          )
          ..cubicTo(
            size.width * 0.4701436,
            size.height * 0.8650794,
            size.width * 0.4708995,
            size.height * 0.8631897,
            size.width * 0.4693878,
            size.height * 0.8624339,
          )
          ..cubicTo(
            size.width * 0.4671202,
            size.height * 0.8613001,
            size.width * 0.4644747,
            size.height * 0.8613001,
            size.width * 0.4618292,
            size.height * 0.8609221,
          )
          ..lineTo(size.width * 0.4542706, size.height * 0.8601663)
          ..close()
          ..moveTo(size.width * 0.2301587, size.height * 0.8654573)
          ..lineTo(size.width * 0.2290249, size.height * 0.8654573)
          ..cubicTo(
            size.width * 0.2260015,
            size.height * 0.8654573,
            size.width * 0.2233560,
            size.height * 0.8665911,
            size.width * 0.2207105,
            size.height * 0.8677249,
          )
          ..cubicTo(
            size.width * 0.2199546,
            size.height * 0.8677249,
            size.width * 0.2191988,
            size.height * 0.8681028,
            size.width * 0.2207105,
            size.height * 0.8677249,
          )
          ..lineTo(size.width * 0.2169312, size.height * 0.8722600)
          ..cubicTo(
            size.width * 0.2184429,
            size.height * 0.8749055,
            size.width * 0.2214664,
            size.height * 0.8760393,
            size.width * 0.2241119,
            size.height * 0.8760393,
          )
          ..cubicTo(
            size.width * 0.2297808,
            size.height * 0.8779289,
            size.width * 0.2358277,
            size.height * 0.8786848,
            size.width * 0.2414966,
            size.height * 0.8771731,
          )
          ..cubicTo(
            size.width * 0.2437642,
            size.height * 0.8767952,
            size.width * 0.2460317,
            size.height * 0.8764172,
            size.width * 0.2467876,
            size.height * 0.8745276,
          )
          ..cubicTo(
            size.width * 0.2479214,
            size.height * 0.8726379,
            size.width * 0.2460317,
            size.height * 0.8711262,
            size.width * 0.2448980,
            size.height * 0.8699924,
          )
          ..cubicTo(
            size.width * 0.2411187,
            size.height * 0.8662132,
            size.width * 0.2354497,
            size.height * 0.8654573,
            size.width * 0.2297808,
            size.height * 0.8654573,
          )
          ..close()
          ..moveTo(size.width * 0.6326531, size.height * 0.8730159)
          ..lineTo(size.width * 0.6239607, size.height * 0.8741497)
          ..cubicTo(
            size.width * 0.6201814,
            size.height * 0.8749055,
            size.width * 0.6160242,
            size.height * 0.8760393,
            size.width * 0.6126228,
            size.height * 0.8790627,
          )
          ..lineTo(size.width * 0.6137566, size.height * 0.8828420)
          ..lineTo(size.width * 0.6190476, size.height * 0.8839758)
          ..lineTo(size.width * 0.6292517, size.height * 0.8843537)
          ..cubicTo(
            size.width * 0.6337868,
            size.height * 0.8843537,
            size.width * 0.6386999,
            size.height * 0.8839758,
            size.width * 0.6417234,
            size.height * 0.8805745,
          )
          ..cubicTo(
            size.width * 0.6428571,
            size.height * 0.8798186,
            size.width * 0.6439909,
            size.height * 0.8783069,
            size.width * 0.6436130,
            size.height * 0.8767952,
          )
          ..cubicTo(
            size.width * 0.6428571,
            size.height * 0.8749055,
            size.width * 0.6402116,
            size.height * 0.8749055,
            size.width * 0.6386999,
            size.height * 0.8741497,
          )
          ..cubicTo(
            size.width * 0.6368103,
            size.height * 0.8733938,
            size.width * 0.6349206,
            size.height * 0.8733938,
            size.width * 0.6326531,
            size.height * 0.8733938,
          )
          ..close()
          ..moveTo(size.width * 0.6137566, size.height * 0.8832200)
          ..cubicTo(
            size.width * 0.6137566,
            size.height * 0.8832200,
            size.width * 0.6137566,
            size.height * 0.8832200,
            size.width * 0.6137566,
            size.height * 0.8832200,
          )
          ..lineTo(size.width * 0.6137566, size.height * 0.8832200)
          ..close()
          ..moveTo(size.width * 0.6791383, size.height * 0.8783069)
          ..lineTo(size.width * 0.6798942, size.height * 0.8794407)
          ..lineTo(size.width * 0.6791383, size.height * 0.8783069)
          ..close()
          ..moveTo(size.width * 0.6798942, size.height * 0.8794407)
          ..cubicTo(
            size.width * 0.6814059,
            size.height * 0.8813303,
            size.width * 0.6825397,
            size.height * 0.8835979,
            size.width * 0.6844293,
            size.height * 0.8851096,
          )
          ..lineTo(size.width * 0.6851852, size.height * 0.8858655)
          ..close()
          ..moveTo(size.width * 0.6689342, size.height * 0.8801965)
          ..lineTo(size.width * 0.6746032, size.height * 0.8858655)
          ..lineTo(size.width * 0.6689342, size.height * 0.8801965)
          ..close()
          ..moveTo(size.width * 0.3556311, size.height * 0.8801965)
          ..cubicTo(
            size.width * 0.3529856,
            size.height * 0.8801965,
            size.width * 0.3503401,
            size.height * 0.8805745,
            size.width * 0.3480726,
            size.height * 0.8820862,
          )
          ..cubicTo(
            size.width * 0.3473167,
            size.height * 0.8828420,
            size.width * 0.3461829,
            size.height * 0.8835979,
            size.width * 0.3458050,
            size.height * 0.8847317,
          )
          ..lineTo(size.width * 0.3427816, size.height * 0.8862434)
          ..arcToPoint(
            Offset(size.width * 0.3616780, size.height * 0.8938020),
            radius: Radius.elliptical(
              size.width * 0.03590325,
              size.height * 0.03590325,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.3654573,
            size.height * 0.8945578,
            size.width * 0.3692366,
            size.height * 0.8956916,
            size.width * 0.3730159,
            size.height * 0.8938020,
          )
          ..cubicTo(
            size.width * 0.3745276,
            size.height * 0.8926682,
            size.width * 0.3775510,
            size.height * 0.8915344,
            size.width * 0.3771731,
            size.height * 0.8892668,
          )
          ..cubicTo(
            size.width * 0.3771731,
            size.height * 0.8869992,
            size.width * 0.3749055,
            size.height * 0.8854875,
            size.width * 0.3733938,
            size.height * 0.8847317,
          )
          ..arcToPoint(
            Offset(size.width * 0.3556311, size.height * 0.8801965),
            radius: Radius.elliptical(
              size.width * 0.03476946,
              size.height * 0.03476946,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..close()
          ..moveTo(size.width * 0.4962207, size.height * 0.8832200)
          ..lineTo(size.width * 0.4913076, size.height * 0.8835979)
          ..cubicTo(
            size.width * 0.4894180,
            size.height * 0.8839758,
            size.width * 0.4871504,
            size.height * 0.8854875,
            size.width * 0.4867725,
            size.height * 0.8877551,
          )
          ..lineTo(size.width * 0.4875283, size.height * 0.8896447)
          ..lineTo(size.width * 0.4871504, size.height * 0.8900227)
          ..cubicTo(
            size.width * 0.4867725,
            size.height * 0.8915344,
            size.width * 0.4894180,
            size.height * 0.8919123,
            size.width * 0.4909297,
            size.height * 0.8926682,
          )
          ..arcToPoint(
            Offset(size.width * 0.5045351, size.height * 0.8964475),
            radius: Radius.elliptical(
              size.width * 0.03401361,
              size.height * 0.03401361,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.5079365,
            size.height * 0.8964475,
            size.width * 0.5117158,
            size.height * 0.8964475,
            size.width * 0.5143613,
            size.height * 0.8945578,
          )
          ..cubicTo(
            size.width * 0.5158730,
            size.height * 0.8934240,
            size.width * 0.5173847,
            size.height * 0.8907785,
            size.width * 0.5154951,
            size.height * 0.8892668,
          )
          ..cubicTo(
            size.width * 0.5128496,
            size.height * 0.8873772,
            size.width * 0.5098262,
            size.height * 0.8862434,
            size.width * 0.5064248,
            size.height * 0.8851096,
          )
          ..cubicTo(
            size.width * 0.5034014,
            size.height * 0.8839758,
            size.width * 0.4996221,
            size.height * 0.8832200,
            size.width * 0.4962207,
            size.height * 0.8832200,
          )
          ..close()
          ..moveTo(size.width * 0.6746032, size.height * 0.8858655)
          ..lineTo(size.width * 0.6749811, size.height * 0.8866213)
          ..close();

    final Paint paint0Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = deerTracks.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path0, paint0Stroke);

    final Path path_1 =
        Path()
          ..moveTo(size.width * 0.3605442, size.height * 0.4489796)
          ..cubicTo(
            size.width * 0.3594104,
            size.height * 0.4667423,
            size.width * 0.3439153,
            size.height * 0.4690098,
            size.width * 0.3367347,
            size.height * 0.4708995,
          )
          ..cubicTo(
            size.width * 0.3227513,
            size.height * 0.4232804,
            size.width * 0.3053666,
            size.height * 0.4395314,
            size.width * 0.3193500,
            size.height * 0.4765684,
          )
          ..cubicTo(
            size.width * 0.3072562,
            size.height * 0.4811036,
            size.width * 0.2800454,
            size.height * 0.4882842,
            size.width * 0.2702192,
            size.height * 0.4916856,
          )
          ..cubicTo(
            size.width * 0.2653061,
            size.height * 0.4848828,
            size.width * 0.2426304,
            size.height * 0.4622071,
            size.width * 0.2195767,
            size.height * 0.4656085,
          )
          ..cubicTo(
            size.width * 0.2044596,
            size.height * 0.4640967,
            size.width * 0.1836735,
            size.height * 0.4648526,
            size.width * 0.1855631,
            size.height * 0.4754346,
          )
          ..cubicTo(
            size.width * 0.1965231,
            size.height * 0.4863946,
            size.width * 0.1825397,
            size.height * 0.4962207,
            size.width * 0.1885865,
            size.height * 0.4965986,
          )
          ..cubicTo(
            size.width * 0.1613757,
            size.height * 0.5086924,
            size.width * 0.1545729,
            size.height * 0.4523810,
            size.width * 0.1405896,
            size.height * 0.4523810,
          )
          ..cubicTo(
            size.width * 0.1315193,
            size.height * 0.4572940,
            size.width * 0.1462585,
            size.height * 0.4973545,
            size.width * 0.1311413,
            size.height * 0.4807256,
          )
          ..cubicTo(
            size.width * 0.1164021,
            size.height * 0.4769463,
            size.width * 0.1148904,
            size.height * 0.4331066,
            size.width * 0.09977324,
            size.height * 0.4452003,
          )
          ..cubicTo(
            size.width * 0.09599395,
            size.height * 0.4656085,
            size.width * 0.1095994,
            size.height * 0.4867725,
            size.width * 0.1239607,
            size.height * 0.5003779,
          )
          ..cubicTo(
            size.width * 0.1409675,
            size.height * 0.5162509,
            size.width * 0.1678005,
            size.height * 0.5060469,
            size.width * 0.1844293,
            size.height * 0.5192744,
          )
          ..cubicTo(
            size.width * 0.1825397,
            size.height * 0.5347695,
            size.width * 0.2014361,
            size.height * 0.5495087,
            size.width * 0.1908541,
            size.height * 0.5650038,
          )
          ..cubicTo(
            size.width * 0.1870748,
            size.height * 0.5740741,
            size.width * 0.1825397,
            size.height * 0.5831444,
            size.width * 0.1961451,
            size.height * 0.5831444,
          )
          ..cubicTo(
            size.width * 0.2082389,
            size.height * 0.5914588,
            size.width * 0.2278912,
            size.height * 0.5922147,
            size.width * 0.2377173,
            size.height * 0.5967498,
          )
          ..cubicTo(
            size.width * 0.2460317,
            size.height * 0.6107332,
            size.width * 0.2728647,
            size.height * 0.6148904,
            size.width * 0.2626606,
            size.height * 0.6360544,
          )
          ..lineTo(size.width * 0.2539683, size.height * 0.7324263)
          ..cubicTo(
            size.width * 0.2743764,
            size.height * 0.7384732,
            size.width * 0.2811791,
            size.height * 0.7150416,
            size.width * 0.2834467,
            size.height * 0.6999244,
          )
          ..cubicTo(
            size.width * 0.2860922,
            size.height * 0.6900983,
            size.width * 0.2879819,
            size.height * 0.6651550,
            size.width * 0.2966742,
            size.height * 0.6662887,
          )
          ..cubicTo(
            size.width * 0.3053666,
            size.height * 0.6787604,
            size.width * 0.3042328,
            size.height * 0.7154195,
            size.width * 0.3257748,
            size.height * 0.7067271,
          )
          ..cubicTo(
            size.width * 0.3446712,
            size.height * 0.6972789,
            size.width * 0.3253968,
            size.height * 0.6757370,
            size.width * 0.3257748,
            size.height * 0.6602419,
          )
          ..lineTo(size.width * 0.3125472, size.height * 0.6024187)
          ..lineTo(size.width * 0.4070295, size.height * 0.6024187)
          ..cubicTo(
            size.width * 0.4085412,
            size.height * 0.6364324,
            size.width * 0.4089191,
            size.height * 0.6734694,
            size.width * 0.4104308,
            size.height * 0.7071051,
          )
          ..cubicTo(
            size.width * 0.4323507,
            size.height * 0.7142857,
            size.width * 0.4436886,
            size.height * 0.6874528,
            size.width * 0.4410431,
            size.height * 0.6693122,
          )
          ..lineTo(size.width * 0.4470899, size.height * 0.6277400)
          ..cubicTo(
            size.width * 0.4569161,
            size.height * 0.6466364,
            size.width * 0.4557823,
            size.height * 0.6712018,
            size.width * 0.4720333,
            size.height * 0.6863190,
          )
          ..cubicTo(
            size.width * 0.4939531,
            size.height * 0.6832955,
            size.width * 0.4890401,
            size.height * 0.6693122,
            size.width * 0.4833711,
            size.height * 0.6428571,
          )
          ..cubicTo(
            size.width * 0.4803477,
            size.height * 0.6050642,
            size.width * 0.4708995,
            size.height * 0.5684051,
            size.width * 0.4618292,
            size.height * 0.5321240,
          )
          ..cubicTo(
            size.width * 0.4792139,
            size.height * 0.5192744,
            size.width * 0.4811036,
            size.height * 0.4943311,
            size.width * 0.4693878,
            size.height * 0.4773243,
          )
          ..cubicTo(
            size.width * 0.4576720,
            size.height * 0.4546485,
            size.width * 0.4455782,
            size.height * 0.4848828,
            size.width * 0.4467120,
            size.height * 0.4977324,
          )
          ..cubicTo(
            size.width * 0.4489796,
            size.height * 0.5211640,
            size.width * 0.4202570,
            size.height * 0.5000000,
            size.width * 0.4070295,
            size.height * 0.5011338,
          )
          ..cubicTo(
            size.width * 0.3941799,
            size.height * 0.4973545,
            size.width * 0.3556311,
            size.height * 0.4890401,
            size.width * 0.3537415,
            size.height * 0.4848828,
          )
          ..cubicTo(
            size.width * 0.3813303,
            size.height * 0.4716553,
            size.width * 0.3854875,
            size.height * 0.4648526,
            size.width * 0.3771731,
            size.height * 0.4402872,
          )
          ..cubicTo(
            size.width * 0.3654573,
            size.height * 0.3873772,
            size.width * 0.3439153,
            size.height * 0.4021164,
            size.width * 0.3605442,
            size.height * 0.4489796,
          )
          ..close();

    final Paint paint1Fill =
        Paint()
          ..style = PaintingStyle.fill
          ..color = deerSkin.withAlpha(255);
    canvas.drawPath(path_1, paint1Fill);

    final Path path_2 =
        Path()
          ..moveTo(size.width * 0.3624339, size.height * 0.4818594)
          ..lineTo(size.width * 0.3492063, size.height * 0.4882842)
          ..cubicTo(
            size.width * 0.3616780,
            size.height * 0.4886621,
            size.width * 0.3775510,
            size.height * 0.5090703,
            size.width * 0.3760393,
            size.height * 0.5192744,
          )
          ..cubicTo(
            size.width * 0.3548753,
            size.height * 0.5222978,
            size.width * 0.3325775,
            size.height * 0.5283447,
            size.width * 0.3178382,
            size.height * 0.5241875,
          )
          ..lineTo(size.width * 0.3114135, size.height * 0.5003779)
          ..cubicTo(
            size.width * 0.3076342,
            size.height * 0.5011338,
            size.width * 0.2944067,
            size.height * 0.4992441,
            size.width * 0.2981859,
            size.height * 0.5064248,
          )
          ..lineTo(size.width * 0.3057445, size.height * 0.5253212)
          ..arcToPoint(
            Offset(size.width * 0.2970522, size.height * 0.5423280),
            radius: Radius.elliptical(
              size.width * 0.01360544,
              size.height * 0.01360544,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..cubicTo(
            size.width * 0.3004535,
            size.height * 0.5748299,
            size.width * 0.2898715,
            size.height * 0.6345427,
            size.width * 0.3393802,
            size.height * 0.6194255,
          )
          ..lineTo(size.width * 0.4168556, size.height * 0.6054422)
          ..lineTo(size.width * 0.4259259, size.height * 0.5952381)
          ..cubicTo(
            size.width * 0.4229025,
            size.height * 0.5718065,
            size.width * 0.4236584,
            size.height * 0.5623583,
            size.width * 0.4202570,
            size.height * 0.5385488,
          )
          ..cubicTo(
            size.width * 0.4179894,
            size.height * 0.5306122,
            size.width * 0.4115646,
            size.height * 0.5166289,
            size.width * 0.4036281,
            size.height * 0.5185185,
          )
          ..cubicTo(
            size.width * 0.3998488,
            size.height * 0.5177627,
            size.width * 0.3956916,
            size.height * 0.5177627,
            size.width * 0.3915344,
            size.height * 0.5177627,
          )
          ..cubicTo(
            size.width * 0.3885110,
            size.height * 0.5068027,
            size.width * 0.3862434,
            size.height * 0.4920635,
            size.width * 0.3794407,
            size.height * 0.4882842,
          )
          ..cubicTo(
            size.width * 0.3771731,
            size.height * 0.4867725,
            size.width * 0.3643235,
            size.height * 0.4837491,
            size.width * 0.3624339,
            size.height * 0.4818594,
          )
          ..close();

    final Paint paint2Fill =
        Paint()
          ..style = PaintingStyle.fill
          ..color = mailBag.withAlpha(255);
    canvas.drawPath(path_2, paint2Fill);

    final Path path3 =
        Path()
          ..moveTo(size.width * 0.2872260, size.height * 0.8212396)
          ..cubicTo(
            size.width * 0.2917611,
            size.height * 0.8193500,
            size.width * 0.2966742,
            size.height * 0.8189720,
            size.width * 0.3015873,
            size.height * 0.8201058,
          )
          ..lineTo(size.width * 0.3091459, size.height * 0.8219955)
          ..moveTo(size.width * 0.3212396, size.height * 0.8072562)
          ..arcToPoint(
            Offset(size.width * 0.3696145, size.height * 0.8174603),
            radius: Radius.elliptical(
              size.width * 0.09070295,
              size.height * 0.09070295,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: true,
          )
          ..moveTo(size.width * 0.3624339, size.height * 0.8034769)
          ..cubicTo(
            size.width * 0.3673469,
            size.height * 0.8049887,
            size.width * 0.3722600,
            size.height * 0.8065004,
            size.width * 0.3764172,
            size.height * 0.8099017,
          )
          ..lineTo(size.width * 0.3813303, size.height * 0.8136810);

    final Paint paint3Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = deerTracks.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path3, paint3Stroke);

    final Path path4 =
        Path()
          ..moveTo(size.width * 0.2437642, size.height * 0.6077098)
          ..arcToPoint(
            Offset(size.width * 0.2634165, size.height * 0.6167800),
            radius: Radius.elliptical(
              size.width * 0.02947846,
              size.height * 0.02947846,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          );

    final Paint paint4Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path4, paint4Stroke);

    final Path path5 =
        Path()
          ..moveTo(size.width * 0.2653061, size.height * 0.6046863)
          ..cubicTo(
            size.width * 0.2603930,
            size.height * 0.6455026,
            size.width * 0.2551020,
            size.height * 0.6878307,
            size.width * 0.2524565,
            size.height * 0.7282691,
          )
          ..moveTo(size.width * 0.2464097, size.height * 0.7312925)
          ..cubicTo(
            size.width * 0.2569917,
            size.height * 0.7369615,
            size.width * 0.2671958,
            size.height * 0.7339380,
            size.width * 0.2773998,
            size.height * 0.7305367,
          )
          ..moveTo(size.width * 0.3053666, size.height * 0.6043084)
          ..cubicTo(
            size.width * 0.2978080,
            size.height * 0.6356765,
            size.width * 0.2928949,
            size.height * 0.6972789,
            size.width * 0.2751323,
            size.height * 0.7244898,
          )
          ..moveTo(size.width * 0.2974301, size.height * 0.6621315)
          ..cubicTo(
            size.width * 0.3004535,
            size.height * 0.6734694,
            size.width * 0.3034769,
            size.height * 0.6851852,
            size.width * 0.3087680,
            size.height * 0.6961451,
          )
          ..moveTo(size.width * 0.3117914, size.height * 0.7040816)
          ..lineTo(size.width * 0.3136810, size.height * 0.7040816)
          ..moveTo(size.width * 0.3121693, size.height * 0.7112623)
          ..cubicTo(
            size.width * 0.3182162,
            size.height * 0.7120181,
            size.width * 0.3219955,
            size.height * 0.7093726,
            size.width * 0.3280423,
            size.height * 0.7082389,
          )
          ..moveTo(size.width * 0.3185941, size.height * 0.6224490)
          ..cubicTo(
            size.width * 0.3201058,
            size.height * 0.6269841,
            size.width * 0.3204837,
            size.height * 0.6318972,
            size.width * 0.3216175,
            size.height * 0.6364324,
          )
          ..cubicTo(
            size.width * 0.3253968,
            size.height * 0.6523054,
            size.width * 0.3284203,
            size.height * 0.6678005,
            size.width * 0.3306878,
            size.height * 0.6836735,
          )
          ..lineTo(size.width * 0.3321995, size.height * 0.7014361);

    final Paint paint5Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path5, paint5Stroke);

    final Path path6 =
        Path()
          ..moveTo(size.width * 0.2362056, size.height * 0.5933485)
          ..cubicTo(
            size.width * 0.2467876,
            size.height * 0.6050642,
            size.width * 0.2675737,
            size.height * 0.6073318,
            size.width * 0.2815571,
            size.height * 0.6009070,
          )
          ..moveTo(size.width * 0.2165533, size.height * 0.5899471)
          ..cubicTo(
            size.width * 0.2392290,
            size.height * 0.5967498,
            size.width * 0.2543462,
            size.height * 0.5793651,
            size.width * 0.2641723,
            size.height * 0.5612245,
          )
          ..moveTo(size.width * 0.2033258, size.height * 0.5835223)
          ..cubicTo(
            size.width * 0.2071051,
            size.height * 0.5884354,
            size.width * 0.2120181,
            size.height * 0.5891912,
            size.width * 0.2169312,
            size.height * 0.5861678,
          )
          ..moveTo(size.width * 0.1965231, size.height * 0.5529101)
          ..cubicTo(
            size.width * 0.1965231,
            size.height * 0.5551776,
            size.width * 0.1840514,
            size.height * 0.5680272,
            size.width * 0.1870748,
            size.height * 0.5774754,
          )
          ..moveTo(size.width * 0.1987906, size.height * 0.5234316)
          ..cubicTo(
            size.width * 0.1987906,
            size.height * 0.5287226,
            size.width * 0.2037037,
            size.height * 0.5415722,
            size.width * 0.2089947,
            size.height * 0.5479970,
          )
          ..moveTo(size.width * 0.2256236, size.height * 0.5245654)
          ..arcToPoint(
            Offset(size.width * 0.2354497, size.height * 0.5483749),
            radius: Radius.elliptical(
              size.width * 0.05668934,
              size.height * 0.05668934,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..moveTo(size.width * 0.1904762, size.height * 0.4947090)
          ..cubicTo(
            size.width * 0.1764928,
            size.height * 0.5136054,
            size.width * 0.1836735,
            size.height * 0.5393046,
            size.width * 0.1965231,
            size.height * 0.5521542,
          );

    final Paint paint6Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path6, paint6Stroke);

    final Path path7 =
        Path()
          ..moveTo(size.width * 0.09826153, size.height * 0.4595616)
          ..cubicTo(
            size.width * 0.1046863,
            size.height * 0.4935752,
            size.width * 0.1337868,
            size.height * 0.5117158,
            size.width * 0.1825397,
            size.height * 0.5124717,
          );

    final Paint paint7Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path7, paint7Stroke);

    final Path path8 =
        Path()
          ..moveTo(size.width * 0.09788360, size.height * 0.4546485)
          ..cubicTo(
            size.width * 0.09297052,
            size.height * 0.4421769,
            size.width * 0.1092215,
            size.height * 0.4334845,
            size.width * 0.1152683,
            size.height * 0.4527589,
          )
          ..cubicTo(
            size.width * 0.1182918,
            size.height * 0.4625850,
            size.width * 0.1228269,
            size.height * 0.4724112,
            size.width * 0.1269841,
            size.height * 0.4788360,
          )
          ..moveTo(size.width * 0.1292517, size.height * 0.4811036)
          ..cubicTo(
            size.width * 0.1341648,
            size.height * 0.4845049,
            size.width * 0.1398337,
            size.height * 0.4863946,
            size.width * 0.1447468,
            size.height * 0.4886621,
          )
          ..moveTo(size.width * 0.1462585, size.height * 0.4894180)
          ..cubicTo(
            size.width * 0.1424792,
            size.height * 0.4818594,
            size.width * 0.1371882,
            size.height * 0.4701436,
            size.width * 0.1352986,
            size.height * 0.4622071,
          )
          ..cubicTo(
            size.width * 0.1334089,
            size.height * 0.4531368,
            size.width * 0.1451247,
            size.height * 0.4459562,
            size.width * 0.1504157,
            size.height * 0.4584278,
          )
          ..moveTo(size.width * 0.1670446, size.height * 0.4935752)
          ..cubicTo(
            size.width * 0.1632653,
            size.height * 0.4826153,
            size.width * 0.1557067,
            size.height * 0.4678760,
            size.width * 0.1507937,
            size.height * 0.4580499,
          );

    final Paint paint8Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path8, paint8Stroke);

    final Path path9 =
        Path()
          ..moveTo(size.width * 0.1957672, size.height * 0.4950869)
          ..cubicTo(
            size.width * 0.1719577,
            size.height * 0.4977324,
            size.width * 0.1938776,
            size.height * 0.4818594,
            size.width * 0.2071051,
            size.height * 0.4829932,
          )
          ..cubicTo(
            size.width * 0.2021920,
            size.height * 0.4818594,
            size.width * 0.1882086,
            size.height * 0.4829932,
            size.width * 0.1851852,
            size.height * 0.4773243,
          )
          ..cubicTo(
            size.width * 0.1814059,
            size.height * 0.4697657,
            size.width * 0.2116402,
            size.height * 0.4671202,
            size.width * 0.2161754,
            size.height * 0.4663643,
          )
          ..cubicTo(
            size.width * 0.2422525,
            size.height * 0.4629630,
            size.width * 0.2630385,
            size.height * 0.4754346,
            size.width * 0.2690854,
            size.height * 0.4905518,
          );

    final Paint paint9Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path9, paint9Stroke);

    final Path path10 =
        Path()
          ..moveTo(size.width * 0.2694633, size.height * 0.4935752)
          ..cubicTo(
            size.width * 0.2872260,
            size.height * 0.4897959,
            size.width * 0.2989418,
            size.height * 0.4860166,
            size.width * 0.3163265,
            size.height * 0.4799698,
          )
          ..moveTo(size.width * 0.2751323, size.height * 0.5105820)
          ..cubicTo(
            size.width * 0.2970522,
            size.height * 0.5041572,
            size.width * 0.3817082,
            size.height * 0.4863946,
            size.width * 0.3809524,
            size.height * 0.4538927,
          )
          ..moveTo(size.width * 0.3790627, size.height * 0.4459562)
          ..cubicTo(
            size.width * 0.3809524,
            size.height * 0.4444444,
            size.width * 0.3805745,
            size.height * 0.4452003,
            size.width * 0.3820862,
            size.height * 0.4433107,
          )
          ..moveTo(size.width * 0.3193500, size.height * 0.4773243)
          ..cubicTo(
            size.width * 0.3163265,
            size.height * 0.4705215,
            size.width * 0.3163265,
            size.height * 0.4629630,
            size.width * 0.3129252,
            size.height * 0.4561602,
          )
          ..moveTo(size.width * 0.3401361, size.height * 0.4705215)
          ..cubicTo(
            size.width * 0.3469388,
            size.height * 0.4671202,
            size.width * 0.3590325,
            size.height * 0.4606954,
            size.width * 0.3578987,
            size.height * 0.4489796,
          )
          ..moveTo(size.width * 0.3371126, size.height * 0.4693878)
          ..cubicTo(
            size.width * 0.3333333,
            size.height * 0.4603175,
            size.width * 0.3276644,
            size.height * 0.4327286,
            size.width * 0.3163265,
            size.height * 0.4399093,
          )
          ..cubicTo(
            size.width * 0.3106576,
            size.height * 0.4433107,
            size.width * 0.3110355,
            size.height * 0.4478458,
            size.width * 0.3117914,
            size.height * 0.4531368,
          )
          ..moveTo(size.width * 0.4100529, size.height * 0.7093726)
          ..cubicTo(
            size.width * 0.4149660,
            size.height * 0.7105064,
            size.width * 0.4229025,
            size.height * 0.7093726,
            size.width * 0.4244142,
            size.height * 0.7082389,
          )
          ..moveTo(size.width * 0.4327286, size.height * 0.7048375)
          ..lineTo(size.width * 0.4289494, size.height * 0.7010582)
          ..moveTo(size.width * 0.4108088, size.height * 0.7010582)
          ..cubicTo(
            size.width * 0.4092971,
            size.height * 0.6708239,
            size.width * 0.4115646,
            size.height * 0.6405896,
            size.width * 0.4108088,
            size.height * 0.6103553,
          )
          ..moveTo(size.width * 0.4357521, size.height * 0.6965231)
          ..cubicTo(
            size.width * 0.4410431,
            size.height * 0.6560847,
            size.width * 0.4508692,
            size.height * 0.6141345,
            size.width * 0.4527589,
            size.height * 0.5729403,
          )
          ..moveTo(size.width * 0.4508692, size.height * 0.5672714)
          ..cubicTo(
            size.width * 0.4546485,
            size.height * 0.5702948,
            size.width * 0.4523810,
            size.height * 0.5680272,
            size.width * 0.4569161,
            size.height * 0.5748299,
          )
          ..moveTo(size.width * 0.4656085, size.height * 0.6855631)
          ..lineTo(size.width * 0.4693878, size.height * 0.6817838);

    final Paint paint10Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path10, paint10Stroke);

    final Path path11 =
        Path()
          ..moveTo(size.width * 0.4648526, size.height * 0.6753590)
          ..cubicTo(
            size.width * 0.4603175,
            size.height * 0.6579743,
            size.width * 0.4520030,
            size.height * 0.6417234,
            size.width * 0.4452003,
            size.height * 0.6254724,
          )
          ..moveTo(size.width * 0.4739229, size.height * 0.6878307)
          ..arcToPoint(
            Offset(size.width * 0.4863946, size.height * 0.6832955),
            radius: Radius.elliptical(
              size.width * 0.04913076,
              size.height * 0.04913076,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..moveTo(size.width * 0.4882842, size.height * 0.6746032)
          ..arcToPoint(
            Offset(size.width * 0.4606954, size.height * 0.5362812),
            radius: Radius.elliptical(
              size.width * 0.8752834,
              size.height * 0.8752834,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: false,
          )
          ..moveTo(size.width * 0.4622071, size.height * 0.5328798)
          ..cubicTo(
            size.width * 0.4863946,
            size.height * 0.5166289,
            size.width * 0.4735450,
            size.height * 0.4822373,
            size.width * 0.4546485,
            size.height * 0.4686319,
          );

    final Paint paint11Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path11, paint11Stroke);

    final Path path12 =
        Path()
          ..moveTo(size.width * 0.4512472, size.height * 0.4761905)
          ..cubicTo(
            size.width * 0.4531368,
            size.height * 0.4803477,
            size.width * 0.4572940,
            size.height * 0.4863946,
            size.width * 0.4588057,
            size.height * 0.4894180,
          )
          ..moveTo(size.width * 0.4501134, size.height * 0.4829932)
          ..cubicTo(
            size.width * 0.4425548,
            size.height * 0.4913076,
            size.width * 0.4399093,
            size.height * 0.5113379,
            size.width * 0.4512472,
            size.height * 0.5173847,
          )
          ..moveTo(size.width * 0.3900227, size.height * 0.5000000)
          ..cubicTo(
            size.width * 0.4070295,
            size.height * 0.5011338,
            size.width * 0.4270597,
            size.height * 0.5022676,
            size.width * 0.4433107,
            size.height * 0.5083144,
          );

    final Paint paint12Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path12, paint12Stroke);

    final Path path13 =
        Path()
          ..moveTo(size.width * 0.3065004, size.height * 0.6084656)
          ..cubicTo(
            size.width * 0.3072562,
            size.height * 0.6133787,
            size.width * 0.3091459,
            size.height * 0.6179138,
            size.width * 0.3140590,
            size.height * 0.6194255,
          )
          ..cubicTo(
            size.width * 0.3201058,
            size.height * 0.6224490,
            size.width * 0.3941799,
            size.height * 0.6130008,
            size.width * 0.4160998,
            size.height * 0.6069539,
          )
          ..moveTo(size.width * 0.4225246, size.height * 0.5990174)
          ..cubicTo(
            size.width * 0.4213908,
            size.height * 0.5975057,
            size.width * 0.4202570,
            size.height * 0.5959940,
            size.width * 0.4187453,
            size.height * 0.5952381,
          )
          ..moveTo(size.width * 0.4270597, size.height * 0.5910809)
          ..cubicTo(
            size.width * 0.4270597,
            size.height * 0.5850340,
            size.width * 0.4198791,
            size.height * 0.5393046,
            size.width * 0.4195011,
            size.height * 0.5328798,
          )
          ..cubicTo(
            size.width * 0.4183673,
            size.height * 0.5234316,
            size.width * 0.4157218,
            size.height * 0.5158730,
            size.width * 0.4032502,
            size.height * 0.5177627,
          )
          ..moveTo(size.width * 0.3926682, size.height * 0.5721844)
          ..cubicTo(
            size.width * 0.3990930,
            size.height * 0.5767196,
            size.width * 0.4092971,
            size.height * 0.5831444,
            size.width * 0.4138322,
            size.height * 0.5884354,
          );

    final Paint paint13Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path13, paint13Stroke);

    final Path path14 =
        Path()
          ..moveTo(size.width * 0.4104308, size.height * 0.5226757)
          ..cubicTo(
            size.width * 0.3998488,
            size.height * 0.5377929,
            size.width * 0.3847317,
            size.height * 0.5740741,
            size.width * 0.3707483,
            size.height * 0.5755858,
          )
          ..cubicTo(
            size.width * 0.3556311,
            size.height * 0.5767196,
            size.width * 0.3163265,
            size.height * 0.5468632,
            size.width * 0.3038549,
            size.height * 0.5389267,
          )
          ..moveTo(size.width * 0.3182162, size.height * 0.6111111)
          ..cubicTo(
            size.width * 0.3235072,
            size.height * 0.6027967,
            size.width * 0.3306878,
            size.height * 0.5963719,
            size.width * 0.3356009,
            size.height * 0.5876795,
          )
          ..moveTo(size.width * 0.3408919, size.height * 0.5801209)
          ..cubicTo(
            size.width * 0.3431595,
            size.height * 0.5767196,
            size.width * 0.3454271,
            size.height * 0.5729403,
            size.width * 0.3469388,
            size.height * 0.5687831,
          );

    final Paint paint14Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path14, paint14Stroke);

    final Path path15 =
        Path()
          ..moveTo(size.width * 0.3046107, size.height * 0.6009070)
          ..cubicTo(
            size.width * 0.3034769,
            size.height * 0.5903250,
            size.width * 0.2955404,
            size.height * 0.5529101,
            size.width * 0.2955404,
            size.height * 0.5427060,
          )
          ..cubicTo(
            size.width * 0.2955404,
            size.height * 0.5328798,
            size.width * 0.2978080,
            size.height * 0.5275888,
            size.width * 0.3219955,
            size.height * 0.5264550,
          )
          ..moveTo(size.width * 0.3303099, size.height * 0.5253212)
          ..cubicTo(
            size.width * 0.3514739,
            size.height * 0.5215420,
            size.width * 0.3733938,
            size.height * 0.5196523,
            size.width * 0.3934240,
            size.height * 0.5188964,
          )
          ..moveTo(size.width * 0.3518519, size.height * 0.4935752)
          ..cubicTo(
            size.width * 0.3662132,
            size.height * 0.4860166,
            size.width * 0.3749055,
            size.height * 0.5079365,
            size.width * 0.3756614,
            size.height * 0.5166289,
          )
          ..moveTo(size.width * 0.3631897, size.height * 0.4818594)
          ..cubicTo(
            size.width * 0.3813303,
            size.height * 0.4829932,
            size.width * 0.3907785,
            size.height * 0.5034014,
            size.width * 0.3896447,
            size.height * 0.5170068,
          );

    final Paint paint15Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path15, paint15Stroke);

    final Path path16 =
        Path()
          ..moveTo(size.width * 0.3049887, size.height * 0.5291005)
          ..cubicTo(
            size.width * 0.3034769,
            size.height * 0.5222978,
            size.width * 0.3004535,
            size.height * 0.5154951,
            size.width * 0.2981859,
            size.height * 0.5086924,
          )
          ..moveTo(size.width * 0.3212396, size.height * 0.5268330)
          ..cubicTo(
            size.width * 0.3185941,
            size.height * 0.5192744,
            size.width * 0.3167045,
            size.height * 0.5117158,
            size.width * 0.3129252,
            size.height * 0.5049131,
          )
          ..moveTo(size.width * 0.1678005, size.height * 0.4950869)
          ..lineTo(size.width * 0.1749811, size.height * 0.4965986)
          ..moveTo(size.width * 0.2683296, size.height * 0.5226757)
          ..cubicTo(
            size.width * 0.2910053,
            size.height * 0.5464853,
            size.width * 0.2944067,
            size.height * 0.5162509,
            size.width * 0.2728647,
            size.height * 0.5102041,
          );

    final Paint paint16Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path16, paint16Stroke);

    final Path path17 =
        Path()
          ..moveTo(size.width * 0.1927438, size.height * 0.5820106)
          ..cubicTo(
            size.width * 0.1980348,
            size.height * 0.5839002,
            size.width * 0.2033258,
            size.height * 0.5823885,
            size.width * 0.2101285,
            size.height * 0.5782313,
          );

    final Paint paint17Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path17, paint17Stroke);

    final Paint paint17Fill =
        Paint()
          ..style = PaintingStyle.fill
          ..color = contourColor.withAlpha(255);
    canvas.drawPath(path17, paint17Fill);

    final Path path18 =
        Path()
          ..moveTo(size.width * 0.3764172, size.height * 0.4365079)
          ..cubicTo(
            size.width * 0.3730159,
            size.height * 0.4270597,
            size.width * 0.3718821,
            size.height * 0.4040060,
            size.width * 0.3571429,
            size.height * 0.4085412,
          )
          ..cubicTo(
            size.width * 0.3469388,
            size.height * 0.4119426,
            size.width * 0.3563870,
            size.height * 0.4349962,
            size.width * 0.3571429,
            size.height * 0.4402872,
          );

    final Paint paint18Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path18, paint18Stroke);

    final Path path19 =
        Path()
          ..moveTo(size.width * 0.1530612, size.height * 0.4104308)
          ..cubicTo(
            size.width * 0.1477702,
            size.height * 0.4085412,
            size.width * 0.1447468,
            size.height * 0.4028723,
            size.width * 0.1455026,
            size.height * 0.3972033,
          )
          ..cubicTo(
            size.width * 0.1458806,
            size.height * 0.3919123,
            size.width * 0.1485261,
            size.height * 0.3866213,
            size.width * 0.1530612,
            size.height * 0.3839758,
          )
          ..cubicTo(
            size.width * 0.1568405,
            size.height * 0.3817082,
            size.width * 0.1617536,
            size.height * 0.3809524,
            size.width * 0.1655329,
            size.height * 0.3828420,
          )
          ..cubicTo(
            size.width * 0.1700680,
            size.height * 0.3847317,
            size.width * 0.1742252,
            size.height * 0.3881330,
            size.width * 0.1757370,
            size.height * 0.3926682,
          )
          ..arcToPoint(
            Offset(size.width * 0.1734694, size.height * 0.4096750),
            radius: Radius.elliptical(
              size.width * 0.01889645,
              size.height * 0.01889645,
            ),
            rotation: 0,
            largeArc: false,
            clockwise: true,
          )
          ..cubicTo(
            size.width * 0.1712018,
            size.height * 0.4134543,
            size.width * 0.1659108,
            size.height * 0.4142101,
            size.width * 0.1651550,
            size.height * 0.4187453,
          )
          ..cubicTo(
            size.width * 0.1643991,
            size.height * 0.4232804,
            size.width * 0.1689342,
            size.height * 0.4270597,
            size.width * 0.1708239,
            size.height * 0.4308390,
          )
          ..moveTo(size.width * 0.1757370, size.height * 0.4383976)
          ..cubicTo(
            size.width * 0.1757370,
            size.height * 0.4387755,
            size.width * 0.1761149,
            size.height * 0.4383976,
            size.width * 0.1761149,
            size.height * 0.4383976,
          )
          ..lineTo(size.width * 0.1761149, size.height * 0.4387755);

    final Paint paint19Stroke =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.007558579
          ..color = contourColor.withAlpha(255)
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path19, paint19Stroke);
  }

  @override
  bool shouldRepaint(covariant final StrayDeerPainter oldDelegate) =>
      colorPalette != oldDelegate.colorPalette;
}
