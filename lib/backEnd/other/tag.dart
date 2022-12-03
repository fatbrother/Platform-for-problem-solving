import '../database.dart';

// control the database of the problem with problemsModels
class TagsDatabase {
  static TrieTree trieTree = TrieTree();

  static void init() async {
    try {
      final List<Map<String, dynamic>> tags =
          await DB.getTable('tags');
      
      for (final Map<String, dynamic> tag in tags) {
        trieTree.insert(TagsModel.fromMap(tag));
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<TagsModel>> queryAllTags() async {
    return await trieTree.queryAll();
  }

  static Future<TagsModel?> queryTag(String tag) async {
    return trieTree.search(tag);
  }

  static Future<List<TagsModel>> querySimilarTags(String tag) async {
    return trieTree.startsWith(tag);
  }

  static Future<void> updateTag(TagsModel tag) async {
    try {
      TagsModel tmp = TagsModel.fromMap(await DB.getRow('tags', tag.id));
      DB.updateRow('tags', tag.id, tag.toMap());
      if (tmp.id != tag.id) {
        trieTree.insert(tag);
      } else {
        trieTree.delete(tmp.name);
        trieTree.insert(tag);
      }
    }
    catch (e) {
      rethrow;
    }
  }

  static void deleteTag(TagsModel tag) async {
    try {
      await DB.deleteRow('tags', tag.id);
    } catch (e) {
      rethrow;
    }

    trieTree.delete(tag.name);
  }

  static void addTag(TagsModel tag) async {
    try {
      String id = await DB.addRow('tags', tag.toMap());
      tag.id = id;
      trieTree.insert(tag);
    } catch (e) {
      rethrow;
    }
  }
}

class TagsModel {
  String id;
  String name;
  List<String> problemsWithTag;

  TagsModel({
    required this.id,
    required this.name,
    this.problemsWithTag = const [],
  });

  static fromMap(Map<String, dynamic> data) {
    return TagsModel(
      // if data have 'id' then use it, else set it to 0
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      problemsWithTag: data['problemsWithTag'] == null
          ? []
          : data['problemsWithTag'].cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'problemsWithTag': problemsWithTag,
    };
  }
}

class TrieNode {
  Map<String, TrieNode> children = {};
  TagsModel? tag;
}

class TrieTree {
  TrieNode root = TrieNode();

  void insert(TagsModel tag) {
    TrieNode current = root;
    for (int i = 0; i < tag.name.length; i++) {
      final String char = tag.name[i];
      if (!current.children.containsKey(char)) {
        current.children[char] = TrieNode();
      }
      current = current.children[char]!;
    }
    current.tag = tag;
  }

  TagsModel? search(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      if (!node.children.containsKey(word[i])) {
        return null;
      }
      node = node.children[word[i]]!;
    }
    return node.tag;
  }

  List<TagsModel> startsWith(String prefix) {
    TrieNode node = root;
    for (int i = 0; i < prefix.length; i++) {
      if (!node.children.containsKey(prefix[i])) {
        return [];
      }
      node = node.children[prefix[i]]!;
    }
    return _getAllTagsBelow(node);
  }

  Future<List<TagsModel>> queryAll() async {
    return _getAllTagsBelow(root);
  }

  List<TagsModel> _getAllTagsBelow(TrieNode root) {
    List<TagsModel> result = [];
    if (root.tag != null) {
      result.add(root.tag!);
    }
    for (var key in root.children.keys) {
      result.addAll(_getAllTagsBelow(root.children[key]!));
    }

    return result;
  }

  void delete(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      if (!node.children.containsKey(word[i])) {
        return;
      }
      node = node.children[word[i]]!;
    }

    node.tag = null;
  }
}
