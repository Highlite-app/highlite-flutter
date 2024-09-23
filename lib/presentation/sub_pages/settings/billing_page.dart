import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

import '../../widgets/drawer/content/content_subpage.dart';

const _paymentItems = [
  PaymentItem(
    label: 'In-Store Pickup',
    amount: '0.99',
    status: PaymentItemStatus.final_price,
    type: PaymentItemType.total,
  )
];

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  // final Pay _payClient = Pay({
  //   PayProvider.apple_pay: PaymentConfiguration.fromJsonString(''),
  //   PayProvider.google_pay: PaymentConfiguration.fromJsonString(''),
  // });
  // Map<String, dynamic>? paymentIntent;

  void onApplePayResult(Map<String, dynamic> paymentResult) {
    // Handle the payment result here
    print('Apple Pay result: $paymentResult');
  }

  void onGooglePayResult(Map<String, dynamic> paymentResult) {
    // Handle the payment result here
    print('Google Pay result: $paymentResult');
  }

  @override
  Widget build(BuildContext context) {
    return ContentContainer(title: "Billing", children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ApplePayButton(
          paymentConfiguration: PaymentConfiguration.fromJsonString('''
                {
                  "provider": "apple_pay",
                  "data": {
                    "merchantIdentifier": "merchant.com.your.merchant.id",
                    "displayName": "Example Merchant",
                    "merchantCapabilities": ["3DS", "debit", "credit"],
                    "supportedNetworks": ["amex", "visa", "masterCard"],
                    "countryCode": "US",
                    "currencyCode": "USD"
                  }
                }
                '''),
          paymentItems: _paymentItems,
          style: ApplePayButtonStyle.whiteOutline,
          width: double.infinity,
          height: 42,
          cornerRadius: 12,
          type: ApplePayButtonType.buy,
          onPaymentResult: (result) {
            print('Apple Pay result: $result');
          },
          loadingIndicator: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: GooglePayButton(
          paymentConfiguration: PaymentConfiguration.fromJsonString('''
                {
                  "provider": "google_pay",
                  "data": {
                    "environment": "TEST",
                    "apiVersion": 2,
                    "apiVersionMinor": 0,
                    "merchantInfo": {
                      "merchantName": "Example Merchant"
                    },
                    "allowedPaymentMethods": [
                      {
                        "type": "CARD",
                        "parameters": {
                          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
                          "allowedCardNetworks": ["AMEX", "DISCOVER", "JCB", "MASTERCARD", "VISA"]
                        },
                        "tokenizationSpecification": {
                          "type": "PAYMENT_GATEWAY",
                          "parameters": {
                            "gateway": "example",
                            "gatewayMerchantId": "exampleGatewayMerchantId"
                          }
                        }
                      }
                    ],
                    "transactionInfo": {
                      "totalPriceStatus": "FINAL",
                      "totalPrice": "1.00",
                      "currencyCode": "USD"
                    }
                  }
                }
                '''),
          paymentItems: _paymentItems,
          type: GooglePayButtonType.buy,
          onPaymentResult: (result) {
            debugPrint('Google Pay result: $result');
          },
          width: double.infinity,
          loadingIndicator: const Center(
            child: CircularProgressIndicator(),
          ),
          onError: (error) {
            debugPrint('Google Pay error: $error');
          },
          childOnError: const Text('Google Pay button issue'),
        ),
      ),
    ]);
  }
}
