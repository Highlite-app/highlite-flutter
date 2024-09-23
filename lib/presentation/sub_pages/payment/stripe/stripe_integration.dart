// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../../core/environment/base_environment.dart';
// import '../../../widgets/utils/logger.dart';
//
// class StripeIntegration {
//   static Future<bool> pay(String amount) async {
//     Stripe.publishableKey = '';
//     Stripe.merchantIdentifier = "merchant.highlite.app";
//     Stripe.stripeAccountId = "acct_1O80ZyC8Mvnj5xJC";
//     try {
//       Map<String, dynamic>? paymentIntent =
//           await createPaymentIntent(amount, 'USD');
//       var gpay = const PaymentSheetGooglePay(
//         merchantCountryCode: "US",
//         currencyCode: "USD",
//         testEnv: false,
//       );
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret:
//               paymentIntent!['client_secret'], //Gotten from payment intent
//           style: ThemeMode.light,
//           appearance: const PaymentSheetAppearance(
//             shapes: PaymentSheetShape(
//               borderRadius: 12,
//               borderWidth: 0.5,
//               shadow: PaymentSheetShadowParams(color: Colors.black),
//             ),
//             primaryButton: PaymentSheetPrimaryButtonAppearance(
//               shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
//               colors: PaymentSheetPrimaryButtonTheme(
//                 light: PaymentSheetPrimaryButtonThemeColors(
//                   background: Color.fromARGB(255, 231, 235, 30),
//                   text: Color.fromARGB(255, 235, 92, 30),
//                   border: Color.fromARGB(255, 235, 92, 30),
//                 ),
//               ),
//             ),
//           ),
//           merchantDisplayName: 'Highlite',
//           googlePay: gpay,
//           allowsDelayedPaymentMethods: true,
//           applePay: const PaymentSheetApplePay(merchantCountryCode: "US"),
//         ),
//       );
//       final response = await Stripe.instance.presentPaymentSheet();
//       if (response != null) {
//         logger.logEvent(response.toJson().toString());
//       }
//       return Future.value(true);
//     } catch (err) {
//       logger.logEvent(err.toString());
//       return Future.value(false);
//     }
//   }
//
//   static createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         // 'payment_method_types[]': 'alipay',
//         'currency': currency,
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${BaseEnvironment.base_url}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
// }
