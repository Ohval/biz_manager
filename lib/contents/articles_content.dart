import 'package:biz_manager_app/provider/data_provider.dart';
import 'package:provider/provider.dart';

import '../components/article_form.dart';
import 'package:flutter/material.dart';
import '../components/show_dialog_modal.dart';

class ArticlesContent extends StatefulWidget {
  const ArticlesContent({super.key});

  @override
  State<ArticlesContent> createState() => _ArticlesContentState();
}

class _ArticlesContentState extends State<ArticlesContent> {
  @override
  Widget build(BuildContext context) {
    // Données d'articles factices pour la démonstration
    final List<Map<String, dynamic>> articlesData = [
      ...context.watch<DataProvider>().articlesData,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Articles',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tous les articles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A5568),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showModal(context, ArticleForm(), 'Ajouter un nouvel article');
              },
              icon: const Icon(Icons.add_box),
              label: const Text('Ajouter un article'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C51BF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 40, // Espacement des colonnes
                  dataRowMaxHeight: 100,
                  headingRowColor: WidgetStateProperty.resolveWith(
                    (states) => const Color(0xFFEDF2F7),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Nom de l\'article',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Catégorie',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Prix',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Stock',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A5568),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  rows: articlesData.map((article) {
                    String statusText;
                    Color statusBgColor;
                    Color statusTextColor;

                    if (article['stock'] == 0) {
                      statusText = 'Rupture';
                      statusBgColor = const Color(0xFFF8D7DA);
                      statusTextColor = const Color(0xFF721C24);
                    } else if (article['stock'] <= 10) {
                      statusText = 'Faible';
                      statusBgColor = const Color(0xFFFFF3CD);
                      statusTextColor = const Color(0xFF856404);
                    } else {
                      statusText = 'En stock';
                      statusBgColor = const Color(0xFFD4EDDA);
                      statusTextColor = const Color(0xFF155724);
                    }

                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            article['name'],
                            style: const TextStyle(
                              color: Color(0xFF2D3748),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            article['category'],
                            style: const TextStyle(
                              color: Color(0xFF2D3748),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            '\$${article['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFF2D3748),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: statusBgColor,
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                color: statusTextColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xFF4C51BF),
                                ),
                                onPressed: () {
                                  // Action d'édition
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color(0xFFDC2626),
                                ),
                                onPressed: () {
                                  // Action de suppression
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
