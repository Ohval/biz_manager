import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/state_provider.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String targetId;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.targetId,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive =
        context.watch<StateProvider>().selectedSection == targetId;
    return GestureDetector(
      onTap: () => context.read<StateProvider>().showSection(targetId),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF4C51BF)
              : Colors.transparent, // Bleu profond pour l'actif
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF4C51BF).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        transform: isActive
            ? Matrix4.translationValues(3, 0, 0)
            : Matrix4.identity(),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : const Color(0xFFE2E8F0),
              size: 20,
            ),
            const SizedBox(width: 16),
            Builder(
              builder: (context) {
                return MediaQuery.of(context).size.width > 768
                    ? Text(
                        title,
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : const Color(0xFFE2E8F0),
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 16,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
