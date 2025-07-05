import 'package:flutter/material.dart';

import '../contents/quick_add_content.dart';
import '../components/show_dialog_modal.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Barre de recherche
          Expanded(
            flex: MediaQuery.of(context).size.width > 768 ? 1 : 0,
            child: MediaQuery.of(context).size.width > 768
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Rechercher articles, ventes...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          SizedBox(width: MediaQuery.of(context).size.width > 768 ? 24 : 0),
          // Icônes d'action et profil utilisateur
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Color(0xFF64748B),
                  size: 24,
                ),
                onPressed: () {
                  // Action pour les notifications
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Color(0xFF64748B),
                  size: 24,
                ),
                onPressed: () {
                  showModal(context, QuickAddContent(), 'Ajout Rapide');
                },
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF4C51BF),
                child: const Text(
                  'AD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Builder(
                builder: (context) {
                  return MediaQuery.of(context).size.width > 768
                      ? const Text(
                          'Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2D3748),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
