import 'package:biz_manager_app/components/sidebar_item.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: const Color(0xFF1A202C), // Bleu-gris foncé
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          // Logo/Nom de l'application
          Padding(
            padding: const EdgeInsets.only(
              bottom: 40.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.store,
                  color: Color(0xFF60A5FA),
                  size: 28,
                ), // Bleu plus clair
                const SizedBox(width: 8),
                Builder(
                  builder: (context) {
                    return MediaQuery.of(context).size.width > 768
                        ? const Text(
                            'ShopFlow',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE2E8F0),
                            ),
                          )
                        : const SizedBox.shrink(); // Masquer le texte sur mobile
                  },
                ),
              ],
            ),
          ),
          // Éléments de navigation
          SidebarItem(
            icon: Icons.dashboard,
            title: 'Tableau de bord',
            targetId: 'dashboard',
          ),
          SidebarItem(
            icon: Icons.inventory,
            title: 'Articles',
            targetId: 'articles',
          ),
          SidebarItem(
            icon: Icons.point_of_sale,
            title: 'Ventes',
            targetId: 'sales',
          ),
          SidebarItem(
            icon: Icons.bar_chart,
            title: 'Rapports',
            targetId: 'reports',
          ),
          const Spacer(), // Prend tout l'espace disponible
          SidebarItem(
            icon: Icons.settings,
            title: 'Paramètres',
            targetId: 'settings',
          ),
        ],
      ),
    );
  }
}
