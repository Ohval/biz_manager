import 'package:biz_manager_app/contents/articles_content.dart';
import 'package:biz_manager_app/widgets/sidebar.dart';
import 'package:biz_manager_app/contents/dash_board_content.dart';
import 'package:biz_manager_app/provider/data_provider.dart';
import 'package:biz_manager_app/widgets/header.dart';
import 'package:biz_manager_app/contents/report_content.dart';
import 'package:biz_manager_app/contents/sales_content.dart';
import 'package:biz_manager_app/contents/settings_content.dart';
import 'provider/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => StateProvider()),
      ],
      child: const ShopManagementApp(),
    ),
  );
}

class ShopManagementApp extends StatelessWidget {
  const ShopManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopFlow - Articles & Ventes',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Couleur primaire indigo
        fontFamily:
            'Inter', // Assurez-vous que la police 'Inter' est ajoutée à votre pubspec.yaml
        scaffoldBackgroundColor: const Color(
          0xFFF0F4F8,
        ), // Arrière-plan doux et clair
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Barre latérale
          Sidebar(),
          // Zone de contenu principale
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Barre d'en-tête
                  Header(),
                  // Contenu dynamique
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(32.0),
                      child: Builder(
                        builder: (context) {
                          switch (context
                              .watch<StateProvider>()
                              .selectedSection) {
                            case 'dashboard':
                              return DashBoardContent();
                            case 'articles':
                              return ArticlesContent();
                            case 'sales':
                              return SalesContent();
                            case 'reports':
                              return ReportContent();
                            case 'settings':
                              return SettingsContent();
                            default:
                              return DashBoardContent();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
