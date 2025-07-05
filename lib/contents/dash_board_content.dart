import 'package:flutter/material.dart';

class DashBoardContent extends StatelessWidget {
  const DashBoardContent({super.key});

  // Widget pour une carte de métrique
  Widget _buildMetricCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 36, // Taille de police plus grande
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour un élément d'activité/alerte
  Widget _buildActivityItem(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Color(0xFF2D3748)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour une carte d'information (activité ou faible stock)
  Widget _buildInfoCard(String title, List<Widget> items) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tableau de bord du magasin',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 32), // Plus d'espace
          // Cartes de métriques
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3; // 3 colonnes pour les grands écrans
              if (constraints.maxWidth < 768) {
                crossAxisCount = 1; // 1 colonne sur mobile
              } else if (constraints.maxWidth < 1024) {
                crossAxisCount = 2; // 2 colonnes sur tablette
              }
              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMetricCard('Ventes du jour', '\$1,250', Colors.green),
                  _buildMetricCard('Articles en stock', '540', Colors.indigo),
                  _buildMetricCard('Alertes faible stock', '5', Colors.red),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          // Ventes récentes et articles en faible stock
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 1024) {
                // 1 colonne sur les écrans plus petits que large
                return Column(
                  children: [
                    _buildInfoCard('Ventes récentes', [
                      _buildActivityItem(
                        Icons.receipt,
                        'Vente #00123 - \$75.00 (3 articles)',
                        Colors.blue,
                      ),
                      _buildActivityItem(
                        Icons.receipt,
                        'Vente #00122 - \$25.50 (1 article)',
                        Colors.blue,
                      ),
                      _buildActivityItem(
                        Icons.receipt,
                        'Vente #00121 - \$120.00 (5 articles)',
                        Colors.blue,
                      ),
                    ]),
                    const SizedBox(height: 24),
                    _buildInfoCard('Articles en faible stock', [
                      _buildActivityItem(
                        Icons.warning,
                        'T-shirt Coton Bleu (Stock: 8)',
                        Colors.orange,
                      ),
                      _buildActivityItem(
                        Icons.warning,
                        'Casque Audio X (Stock: 3)',
                        Colors.orange,
                      ),
                      _buildActivityItem(
                        Icons.warning,
                        'Cahier A4 Ligné (Stock: 12)',
                        Colors.orange,
                      ),
                    ]),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInfoCard('Ventes récentes', [
                        _buildActivityItem(
                          Icons.receipt,
                          'Vente #00123 - \$75.00 (3 articles)',
                          Colors.blue,
                        ),
                        _buildActivityItem(
                          Icons.receipt,
                          'Vente #00122 - \$25.50 (1 article)',
                          Colors.blue,
                        ),
                        _buildActivityItem(
                          Icons.receipt,
                          'Vente #00121 - \$120.00 (5 articles)',
                          Colors.blue,
                        ),
                      ]),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildInfoCard('Articles en faible stock', [
                        _buildActivityItem(
                          Icons.warning,
                          'T-shirt Coton Bleu (Stock: 8)',
                          Colors.orange,
                        ),
                        _buildActivityItem(
                          Icons.warning,
                          'Casque Audio X (Stock: 3)',
                          Colors.orange,
                        ),
                        _buildActivityItem(
                          Icons.warning,
                          'Cahier A4 Ligné (Stock: 12)',
                          Colors.orange,
                        ),
                      ]),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
