import 'package:biz_manager_app/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleForm extends StatefulWidget {
  const ArticleForm({super.key});

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Nom de l\'article',
            hintText: 'Ex: T-shirt Coton Bleu',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            fillColor: const Color(0xFFF8FAFC),
            filled: true,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: categoryController,
          decoration: InputDecoration(
            labelText: 'Catégorie',
            hintText: 'Ex: Vêtements, Électronique',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            fillColor: const Color(0xFFF8FAFC),
            filled: true,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Prix',
                  hintText: 'Ex: 19.99',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  fillColor: const Color(0xFFF8FAFC),
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: stockController,
                decoration: InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Ex: 50',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  fillColor: const Color(0xFFF8FAFC),
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Description (Optionnel)',
            hintText: 'Description détaillée de l\'article',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            fillColor: const Color(0xFFF8FAFC),
            filled: true,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.read<DataProvider>().addArticle({
                  'name': nameController.text,
                  'category': categoryController.text,
                  'price': double.tryParse(priceController.text) ?? 0.0,
                  'stock': int.tryParse(stockController.text) ?? 0,
                });
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save),
              label: const Text('Enregistrer l\'article'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C51BF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4A5568),
                backgroundColor: const Color(0xFFE2E8F0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Annuler'),
            ),
          ],
        ),
      ],
    );
  }
}
