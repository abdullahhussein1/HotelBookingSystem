// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:metroom/app/constants/app.credentials.dart';
// import 'package:metroom/core/notifiers/authentication.notifier.dart';
// import 'package:provider/provider.dart';

// class PaymentNotifier extends ChangeNotifier {
//   final stripe = Stripe();

//   String? payResponse;
//   bool? paymentStatus;

//   Future<void> initializeStripe() async {
//     // Move your Stripe publishable key to a secure environment variable
//     await stripe.init(publishableKey: stripePublishableKey);
//   }

//   Future<bool> checkMeOut({
//     required BuildContext context,
//     required int amount,
//   }) async {
//     AuthenticationNotifer authenticationNotifer =
//         Provider.of<AuthenticationNotifier>(context, listen: false);

//     await initializeStripe();

//     final paymentIntentResult = await stripe.paymentIntents.create(
//       PaymentIntentCreateParams(
//         currency: 'usd', // Update with your desired currency code
//         amount: amount * 100, // Convert amount to cents as Stripe uses cents
//         paymentMethodTypes: ['card'],
//         customer: authenticationNotifer.userId, // Optional: Set customer ID
//       ),
//     );

//     if (paymentIntentResult.error != null) {
//       payResponse = paymentIntentResult.error.message;
//       paymentStatus = false;
//       notifyListeners();
//       return false;
//     }

//     final paymentSheetResult = await stripe.paymentSheet.present(
//       PaymentSheetPresentationParams(
//         clientSecret: paymentIntentResult.paymentIntent.clientSecret,
//         confirmationMethod: ConfirmationMethod.automatic,
//         customerId: authenticationNotifer.userId, // Optional: Set customer ID
//         customerEphemeralKeySecret: paymentIntentResult.paymentIntent.ephemeralKey?.secret,
//         paymentIntentClientSecret: paymentIntentResult.paymentIntent.clientSecret,
//         // ... other customization options (refer to documentation)
//       ),
//     );

//     switch (paymentSheetResult.status) {
//       case PaymentSheetResultStatus.success:
//         payResponse = paymentSheetResult.paymentIntentId;
//         paymentStatus = true;
//         break;
//       case PaymentSheetResultStatus.canceled:
//         payResponse = 'Payment cancelled';
//         paymentStatus = false;
//         break;
//       case PaymentSheetResultStatus.failed:
//         payResponse = paymentSheetResult.errorMessage;
//         paymentStatus = false;
//         break;
//     }

//     notifyListeners();
//     return paymentStatus!;
//   }
// }
