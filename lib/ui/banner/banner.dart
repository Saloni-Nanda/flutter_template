import 'package:flutter/material.dart';

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.white,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  color: Colors.blue,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book With Confidence',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Enjoy these exclusive benefits',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Benefits Grid - Adjusted to prevent overflow
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 3.2, // Adjusted ratio
            children: [
              _buildBenefitItem(
                icon: Icons.calendar_today_rounded,
                subtitle: 'Flexible Booking',
                color: Colors.green,
              ),
              _buildBenefitItem(
                icon: Icons.swap_horiz_rounded,
                subtitle: 'Cancel Anytime',
                color: Colors.orange,
              ),
              _buildBenefitItem(
                icon: Icons.payments_rounded,
                subtitle: 'Pay at Hotel',
                color: Colors.purple,
              ),
              _buildBenefitItem(
                icon: Icons.price_check_rounded,
                subtitle: 'Low Price Guaranteed',
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem({
    required IconData icon,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}