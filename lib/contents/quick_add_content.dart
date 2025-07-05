import 'package:biz_manager_app/components/quick_add_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/article_form.dart';
import '../components/show_dialog_modal.dart';
import '../provider/state_provider.dart';

// Contenu de la modale "Ajout Rapide"

class QuickAddContent extends StatelessWidget {
  const QuickAddContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Que souhaitez-vous ajouter rapidement ?',
          style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            QuickAddButton(
              icon: Icons.add_box,
              text: 'Nouvel Article',
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la modale rapide
                context.read<StateProvider>().showSection('articles');
                showModal(context, ArticleForm(), 'Ajouter un nouvel article');
              },
            ),
            QuickAddButton(
              icon: Icons.point_of_sale,
              text: 'Nouvelle Vente',
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la modale rapide
                context.read<StateProvider>().showSection('sales');
              },
            ),
          ],
        ),
      ],
    );
  }
}
