import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Victorro',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  var currentUrl = "https://android.victorro.id/";
  @override
  void initState() {
    // TODO: implement initStatesuper.initState();
    controller..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            String originalUrl = request.url;
            Uri uri = Uri.parse(originalUrl);
            String pathAfterBaseUrl = uri.path;

            if (request.url.startsWith('https://android.victorro.id/')) {
              var theBaseWeb = Uri.https('catalstudio.com',pathAfterBaseUrl);
              if (await canLaunchUrl(theBaseWeb)) {
                // await launchUrl(theBaseWeb);
                setState(() {
                  currentUrl = request.url;
                });
              } else {
                throw 'Could not launch $theBaseWeb';
              }
              return NavigationDecision.navigate;
            }
            else if (request.url.startsWith('https://wa.me/')) {
              String originalUrl = request.url;
              Uri uri = Uri.parse(originalUrl);
              String pathAfterBaseUrl = uri.path;
              var theBaseWeb = Uri.https('wa.me',pathAfterBaseUrl);

              Uri whatsappUri = Uri.parse(request.url);

              // Uri(scheme: 'https', path: 'send', queryParameters: {
              //   'phone': '+6288899990000', // Replace with the phone number
              //   'text': 'Hello, this is a WhatsApp message!', // Replace with your message
              // });
              if (await canLaunchUrl(whatsappUri)) {
                await launchUrl(whatsappUri);
              } else {
                throw 'Could not launch $whatsappUri';
              }
              return NavigationDecision.navigate;
            } else if (request.url.startsWith('whatsapp')) {
              String originalUrl = request.url;
              Uri uri = Uri.parse(originalUrl);
              String pathAfterBaseUrl = uri.path;

              Uri whatsappUri =
              // Uri.parse(request.url);

              Uri(scheme: 'whatsapp', path: 'send', queryParameters: {
                'phone': '+6282218695302',
                'type' : 'phone_number',
                'text': '', // Replace with your message
              });
              if (await canLaunchUrl(whatsappUri)) {
                await launchUrl(whatsappUri);
              } else {
                throw 'Could not launch $whatsappUri';
              }
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
            // if (request.url.startsWith('whatsapp:')) {
            //   Uri whatsappUri = Uri(scheme: 'whatsapp', path: 'send', queryParameters: {
            //     'phone': '+6288899990000', // Replace with the phone number
            //     'text': 'Hello, this is a WhatsApp message!', // Replace with your message
            //   });
            //     if (await canLaunchUrl(whatsappUri)) {
            //       await launchUrl(whatsappUri);
            //   } else {
            //     throw 'Could not launch $whatsappUri';
            //   }
            //   return NavigationDecision.navigate;
            // }
            // return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://android.victorro.id/'));
  }
  var controller = WebViewController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(await controller.canGoBack()){
          controller.goBack();
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(title: const Text('Flutter Simple Example')),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
