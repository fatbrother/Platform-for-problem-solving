import 'package:pops/services/database.dart';
import 'package:pops/models/tag_model.dart';

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

  static List<TagsModel> queryAllTags() {
    return trieTree.queryAll();
  }

  static TagsModel? queryTag(String tag) {
    return trieTree.search(tag);
  }

  static List<TagsModel> querySimilarTags(String tag) {
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

  static void deleteTag(String tag) async {
    TagsModel tmp = trieTree.search(tag)!;
    try {
      await DB.deleteRow('tags', tmp.id);
    } catch (e) {
      rethrow;
    }
    trieTree.delete(tmp.name);
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
