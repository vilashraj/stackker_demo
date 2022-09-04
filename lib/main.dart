import 'package:stackker_demo/utils/app_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize translation service
  await appTranslationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTranslationService.text('key_app_name')!,
      darkTheme: AppTheme.darkThemeData,
      theme: AppTheme.lightThemeData,
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}


