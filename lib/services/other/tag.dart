import 'package:pops/services/database.dart';
import 'package:pops/models/tag_model.dart';

// control the database of the problem with problemsModels
class TagsDatabase {
  static final TrieTree _trieTree = TrieTree();
  static final TagsDatabase instance = TagsDatabase();

  void init() async {
    try {
      final List<Map<String, dynamic>> tags =
          await DB.getTable('tags');
      
      for (final Map<String, dynamic> tag in tags) {
        _trieTree.insert(TagsModel.fromMap(tag));
      }
    } catch (e) {
      rethrow;
    }
  }

  TagsModel query(String tag) {
    var tmp = _trieTree.search(tag);
    if (tmp == null) {
      throw Exception('Tag not found');
    }
    return tmp;
  }

  List<TagsModel> querySimilar(String tag) {
    return _trieTree.startsWith(tag);
  }

  Future<void> update(TagsModel tag) async {
    try {
      TagsModel tmp = TagsModel.fromMap(await DB.getRow('tags', tag.id));
      DB.updateRow('tags', tag.id, tag.toMap());
      if (tmp.id != tag.id) {
        _trieTree.insert(tag);
      } else {
        _trieTree.delete(tmp.name);
        _trieTree.insert(tag);
      }
    }
    catch (e) {
      rethrow;
    }
  }

  void add(TagsModel tag) async {
    try {
      String id = await DB.addRow('tags', tag.toMap());
      tag.id = id;
      _trieTree.insert(tag);
    } catch (e) {
      rethrow;
    }
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
      String c = tag.name[i];
      if (!current.children.containsKey(c)) {
        current.children[c] = TrieNode();
      }
      current = current.children[c]!;
    }
    current.tag = tag;
  }

  TagsModel? search(String word) {
    TrieNode current = root;
    for (int i = 0; i < word.length; i++) {
      String c = word[i];
      if (!current.children.containsKey(c)) {
        return null;
      }
      current = current.children[c]!;
    }
    return current.tag;
  }

  List<TagsModel> queryAll()  {
    List<TagsModel> tags = [];
    _queryAll(root, tags);
    return tags;
  }

  void _queryAll(TrieNode node, List<TagsModel> tags) {
    if (node.tag != null) {
      tags.add(node.tag!);
    }
    for (final String key in node.children.keys) {
      _queryAll(node.children[key]!, tags);
    }
  }

  List<TagsModel> startsWith(String prefix)  {
    TrieNode current = root;
    for (int i = 0; i < prefix.length; i++) {
      String c = prefix[i];
      if (!current.children.containsKey(c)) {
        return [];
      }
      current = current.children[c]!;
    }
    List<TagsModel> tags = [];
    _queryAll(current, tags);
    return tags;
  }

  void delete(String word) {
    _delete(root, word, 0);
  }

  bool _delete(TrieNode node, String word, int index) {
    if (index == word.length) {
      if (node.children.isNotEmpty) {
        node.tag = null;
        return false;
      } else {
        return true;
      }
    }
    String c = word[index];
    if (!node.children.containsKey(c)) {
      return false;
    }
    bool shouldDeleteCurrentNode = _delete(node.children[c]!, word, index + 1);

    if (shouldDeleteCurrentNode) {
      node.children.remove(c);
      return node.children.isEmpty;
    }
    return false;
  }
}
