import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'idea_provider.dart';
import '../../core/utils/date_formatter.dart';

class IdeasScreen extends ConsumerStatefulWidget {
  const IdeasScreen({super.key});

  @override
  ConsumerState<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends ConsumerState<IdeasScreen> {
  bool showNewIdea = false;
  String? _editingIdeaId;
  final TextEditingController _contentController = TextEditingController();
  String _selectedCategory = 'Général';
  final List<String> _categories = [
    'Général',
    'Personnage',
    'Lieu',
    'Phrase',
    'Idée Brute',
    'Ambiance'
  ];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_contentController.text.isNotEmpty) {
      if (_editingIdeaId != null) {
        // Mode Modification
        ref.read(ideaProvider.notifier).updateIdea(
              _editingIdeaId!,
              _contentController.text,
              _selectedCategory,
            );
      } else {
        // Mode Ajout
        ref.read(ideaProvider.notifier).addIdea(
              _contentController.text,
              _selectedCategory,
              [],
            );
      }
      _contentController.clear();
      setState(() {
        showNewIdea = false;
        _editingIdeaId = null;
        _selectedCategory = 'Général';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coffre mis à jour ! 💎')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ideas = ref.watch(ideaProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Le Coffre à Idées",
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(showNewIdea ? Icons.close : Icons.add, color: Colors.orange),
            onPressed: () => setState(() => showNewIdea = !showNewIdea),
          ),
        ],
      ),
      body: Column(
        children: [
          if (showNewIdea) _buildNewIdeaForm(),
          Expanded(
            child: ideas.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: ideas.length,
                    itemBuilder: (context, index) {
                      final idea = ideas[index];
                      return _IdeaCard(
                        content: idea.content,
                        category: idea.category,
                        date: formatStoryDate(idea.createdAt),
                        onDelete: () => ref.read(ideaProvider.notifier).deleteIdea(idea.id),
                        onEdit: () {
                          setState(() {
                            showNewIdea = true;
                            _editingIdeaId = idea.id;
                            _contentController.text = idea.content;
                            _selectedCategory = idea.category;
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final randomIdea = ref.read(ideaProvider.notifier).pickRandom();
          if (randomIdea != null) {
            _showRandomIdeaDialog(randomIdea.content, randomIdea.category);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Le coffre est vide ! Ajoute des idées d\'abord.')),
            );
          }
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.casino, color: Colors.white),
      ),
    );
  }

  Widget _buildNewIdeaForm() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _editingIdeaId != null ? "Modifier l'idée :" : "Nouvelle pépite :",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _contentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Écris ton idée ici...",
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (val) => setState(() => _selectedCategory = val!),
            decoration: const InputDecoration(labelText: "Catégorie"),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
              child: Text(_editingIdeaId != null ? "METTRE À JOUR" : "AJOUTER AU COFFRE"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "Ton coffre est vide pour l'instant.",
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          Text(
            "Ajoute ta première idée !",
            style: TextStyle(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  void _showRandomIdeaDialog(String content, String category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.casino, color: Colors.orange),
            const SizedBox(width: 8),
            Text("Pige : $category"),
          ],
        ),
        content: Text(content, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Merci !")),
        ],
      ),
    );
  }
}

class _IdeaCard extends StatelessWidget {
  final String content;
  final String category;
  final String date;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const _IdeaCard({
    required this.content,
    required this.category,
    required this.date,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    Color categoryColor = Colors.grey;
    if (category == 'Personnage') categoryColor = Colors.blue;
    if (category == 'Lieu') categoryColor = Colors.green;
    if (category == 'Phrase') categoryColor = Colors.purple;
    if (category == 'Idée Brute') categoryColor = Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: categoryColor, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: categoryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(category, style: TextStyle(color: categoryColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.blue),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 15, color: Color(0xFF374151))),
          const SizedBox(height: 12),
          Text(date, style: TextStyle(fontSize: 11, color: Colors.grey[400])),
        ],
      ),
    );
  }
}
