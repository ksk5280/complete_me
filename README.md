# Complete Me

## Turing School: Module 1, Project 4

### Overview

The requirement of this project was to build an autocomplete program using a trie data structure. 
The name comes from the idea of a Re-trie-val
tree, and it's useful for storing and then fetching paths through
arbitrary (often textual) data.

A Trie is somewhat similar to the binary trees you may have seen before,
but whereas each node in a binary tree points to up to 2 subtrees,
nodes within our retrieval tries will point to `N` subtrees, where `N`
is the size of the alphabet we want to complete within.

Thus for a simple latin-alphabet text trie, each node will potentially
have 26 children, one for each character that could potentially follow
the text entered thus far.

What we end up with is a broadly-branched tree where paths from the
root to the leaves represent "words" within the dictionary.


## Trie interactions

The autocomplete trie can fulfill each of the interactions below.

We start with:

```ruby
trie = CompleteMe.new
```

The trie is created from nodes. Each node has:

* A) A link to the next nodes if there are any. The link is in the form of a hash.
* B) A word attribute which is nil if no words are stored in this node.
* C) A weight that increases each time a particular word is selected.

The trie also has the following methods:

### `insert`

The `insert` method adds a new word starting from the root node, in the form of linked nodes corresponding to each letter in the word.

```ruby
trie.insert("pi")
trie.insert("pizza")
trie.insert("pizzeria")
trie.insert("pizzicato")
```
For all the later methods defined here, assume that we've run these four inserts.

### `count`

The `count` method returns the number of words present in the trie.

```ruby
trie.count
# => 4
```

### `suggest`

The `suggest` method suggests words in the trie based on a given substring. The words are returned in an array.

```ruby
trie.suggest("piz")
# => ["pizza", "pizzeria", "pizzicato"]
```

### `select`

The `select` method adds weight to a selected word so that it will be returned higher in the `suggest` word array:

```ruby
trie.select("piz", "pizzicato")
trie.suggest("piz")
# => ["pizzicato", "pizzeria", "pizza"]
```

### `delete`

The `delete` method deletes a word from the trie.

If the deleted word is a leaf node (i.e. a node at the end of the tree), it is completely removed from the tree
and any of its parents for which it was the only child are also removed. For intermediate nodes, only the word is deleted, but the node remains.



### `populate`

The `populate` method allows for the trie to be populated with a newline-separated list of words. 

```ruby
trie.populate(word_file)
```
