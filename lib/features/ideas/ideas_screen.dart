import 'package:flutter/material.dart';

class Idea {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final bool starred;
  final String createdAt;
  final List<Color> gradient;

  Idea({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.starred,
    required this.createdAt,
    required this.gradient,
  });

  Idea copyWith({bool? starred}) {
    return Idea(
      id: id,
      title: title,
      content: content,
      tags: tags,
      starred: starred ?? this.starred,
      createdAt: createdAt,
      gradient: gradient,
    );
  }
}

class IdeasScreen extends StatefulWidget {
  const IdeasScreen({super.key});

  @override
  State<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> {
  bool showNewIdea = false;

  List<Idea> ideas = [
    Idea(
      id: '1',
      title: 'Monde sous-marin dystopique',
      content:
          'Civilisation avancée sous l’océan après la montée des eaux. Technologie bio-luminescente.',
      tags: ['sci-fi', 'dystopie', 'océan'],
      starred: true,
      createdAt: 'Il y a 2h',
      gradient: [Colors.orange, Colors.deepOrange],
    ),
    Idea(
      id: '2',
      title: 'Antagoniste sympathique',
      content:
          'Un "méchant" qui a des raisons valables et touchantes. Le lecteur devrait hésiter entre le héros et lui.',
      tags: ['personnage', 'antagoniste'],
      starred: false,
      createdAt: 'Hier',
      gradient: [Colors.amber, Colors.orange],
    ),
  ];

  void toggleStar(String id) {
    setState(() {
      ideas = ideas
          .map(
            (idea) =>
                idea.id == id ? idea.copyWith(starred: !idea.starred) : idea,
          )
          .toList();
    });
  }

  void deleteIdea(String id) {
    setState(() {
      ideas.removeWhere((idea) => idea.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                border: const Border(
                  bottom: BorderSide(color: Colors.orangeAccent, width: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Mes Idées",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() => showNewIdea = !showNewIdea);
                    },
                  ),
                ],
              ),
            ),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Rechercher une idée...",
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            if (showNewIdea)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Titre de l'idée...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Développez votre idée...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  setState(() => showNewIdea = false),
                              child: const Text("Enregistrer"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  setState(() => showNewIdea = false),
                              child: const Text("Annuler"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 12),

            Expanded(
              child: ideas.isEmpty
                  ? const Center(child: Text("Aucune idée sauvegardée"))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: ideas.length,
                      itemBuilder: (context, index) {
                        final idea = ideas[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: idea.gradient,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.lightbulb,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          idea.starred
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: idea.starred
                                              ? Colors.amber
                                              : Colors.grey,
                                        ),
                                        onPressed: () => toggleStar(idea.id),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () => deleteIdea(idea.id),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                idea.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                idea.content,
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                children: idea.tags
                                    .map(
                                      (tag) => Chip(
                                        label: Text("#$tag"),
                                        backgroundColor: Colors.orange
                                            .withValues(alpha: 0.1),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                idea.createdAt,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
