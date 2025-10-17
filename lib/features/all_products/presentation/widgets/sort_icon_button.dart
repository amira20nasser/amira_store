import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SortIconButton extends StatelessWidget {
  const SortIconButton({super.key, required this.onSortSelected});

  final void Function(String sortBy, String order) onSortSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.sort),
      onPressed: () => _showSortOptions(context),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sort Products',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Divider(),
              _SortOptionTile(
                title: 'Price: Low to High',
                icon: FontAwesomeIcons.arrowDown19,
                onTap: () {
                  context.pop();
                  onSortSelected('price', 'asc');
                },
              ),
              _SortOptionTile(
                title: 'Price: High to Low',
                icon: FontAwesomeIcons.arrowDown91,
                onTap: () {
                  context.pop();
                  onSortSelected('price', 'desc');
                },
              ),
              _SortOptionTile(
                title: 'Newest',
                icon: FontAwesomeIcons.clock,
                onTap: () {
                  context.pop();
                  onSortSelected('createdAt', 'desc');
                },
              ),
              _SortOptionTile(
                title: 'Rating',
                icon: FontAwesomeIcons.star,
                onTap: () {
                  context.pop();
                  onSortSelected('rating', 'desc');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SortOptionTile extends StatelessWidget {
  const _SortOptionTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: Theme.of(context).primaryColor),
      title: Text(title),
      onTap: onTap,
    );
  }
}
