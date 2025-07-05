import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class SalesContent extends StatefulWidget {
  const SalesContent({super.key});

  @override
  State<SalesContent> createState() => _SalesContentState();
}

class _SalesContentState extends State<SalesContent> {
  List<Map<String, dynamic>> _cart = []; // Panier pour la vente actuelle
  // Carte "Enregistrer une nouvelle vente"v
  Widget _buildNewSaleCard(
    TextEditingController searchController,
    TextEditingController quantityController,
  ) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enregistrer une nouvelle vente',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Rechercher un article',
                  hintText: 'Nom de l\'article ou code-barres',
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
              ),
              const SizedBox(height: 16),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantité',
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
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  _addToCart(
                    searchController.text,
                    int.tryParse(quantityController.text) ?? 1,
                  );
                  searchController.clear();
                  quantityController.text = '1';
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Ajouter au panier'),
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
                  minimumSize: const Size.fromHeight(
                    50,
                  ), // Bouton pleine largeur
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Panier',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 16),
              // Liste du panier
              Column(
                children: _cart.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Map item = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item['name']} (x${item['quantity']})',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xFF2D3748),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _cart.removeAt(idx);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const Divider(height: 32, thickness: 1, color: Color(0xFFE2E8F0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  Text(
                    '\$${_cart.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity'])).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  _completeSale();
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Terminer la vente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF10B981,
                  ), // Vert pour terminer la vente
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Carte "Ventes récentes"
  Widget _buildRecentSalesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ventes récentes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 30,
                dataRowMaxHeight: 60,
                headingRowColor: WidgetStateProperty.resolveWith(
                  (states) => const Color(0xFFEDF2F7),
                ),
                columns: const [
                  DataColumn(
                    label: Text(
                      'ID Vente',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Statut',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(
                        Text(
                          '#00123',
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const DataCell(
                        Text(
                          '2025-07-01',
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const DataCell(
                        Text(
                          '\$75.00',
                          style: TextStyle(
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
                            color: const Color(0xFFD4EDDA),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            'Terminé',
                            style: TextStyle(
                              color: Color(0xFF155724),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            color: Color(0xFF4C51BF),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(
                        Text(
                          '#00122',
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const DataCell(
                        Text(
                          '2025-07-01',
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const DataCell(
                        Text(
                          '\$25.50',
                          style: TextStyle(
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
                            color: const Color(0xFFD4EDDA),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            'Terminé',
                            style: TextStyle(
                              color: Color(0xFF155724),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            color: Color(0xFF4C51BF),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Logique d'ajout au panier
  void _addToCart(String searchTerm, int quantity) {
    final foundArticle = context.watch<DataProvider>().articlesData.firstWhere(
      (article) =>
          article['name'].toLowerCase().contains(searchTerm.toLowerCase()),
      orElse: () => {},
    );

    if (foundArticle.isNotEmpty && foundArticle['stock'] >= quantity) {
      setState(() {
        _cart.add({...foundArticle, 'quantity': quantity});
        foundArticle['stock'] -= quantity; // Déduire du stock factice
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article non trouvé ou stock insuffisant.'),
        ),
      );
    }
  }

  // Logique de finalisation de la vente
  void _completeSale() {
    if (_cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Le panier est vide. Veuillez ajouter des articles pour terminer la vente.',
          ),
        ),
      );
      return;
    }
    final totalSale = _cart.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Vente terminée ! Total: \$${totalSale.toStringAsFixed(2)}',
        ),
      ),
    );
    setState(() {
      _cart = []; // Vider le panier
    });
    // Dans une vraie application, vous enregistreriez cette transaction dans une base de données
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController quantityController = TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ventes',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 1024) {
                // Colonnes simples sur les écrans plus petits que large
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildNewSaleCard(searchController, quantityController),
                      const SizedBox(height: 24),
                      _buildRecentSalesCard(),
                    ],
                  ),
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildNewSaleCard(
                        searchController,
                        quantityController,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(child: _buildRecentSalesCard()),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
