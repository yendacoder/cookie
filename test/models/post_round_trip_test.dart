import 'package:cookie/models/post.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Minimal required fields only — every nullable is absent.
Map<String, dynamic> _minimalPostJson({String id = 'p1'}) => {
  'id': id,
  'type': 'text',
  'publicId': 'pub-$id',
  'userId': 'user-1',
  'username': 'testuser',
  'userGroup': 'normal',
  'userDeleted': false,
  'isPinned': false,
  'isPinnedSite': false,
  'communityId': 'comm-1',
  'communityName': 'testcomm',
  'title': 'Hello',
  'locked': false,
  'upvotes': 5,
  'downvotes': 2,
  'hotness': 0,
  'createdAt': '2024-06-01T12:00:00.000Z',
  'lastActivityAt': '2024-06-01T12:00:00.000Z',
  'deleted': false,
  'deletedContent': false,
  'noComments': 3,
  'isAuthorMuted': false,
  'isCommunityMuted': false,
};

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('Post.fromJson — required fields', () {
    test('parses id, type and title', () {
      final post = Post.fromJson(_minimalPostJson(id: 'abc'));
      expect(post.id, 'abc');
      expect(post.type, 'text');
      expect(post.title, 'Hello');
    });

    test('parses vote counts', () {
      final json = _minimalPostJson()
        ..['upvotes'] = 42
        ..['downvotes'] = 7;
      final post = Post.fromJson(json);
      expect(post.upvotes, 42);
      expect(post.downvotes, 7);
    });

    test('parses createdAt as DateTime', () {
      final post = Post.fromJson(_minimalPostJson());
      expect(post.createdAt, DateTime.utc(2024, 6, 1, 12));
    });

    test('noComments parses correctly', () {
      final post = Post.fromJson(_minimalPostJson());
      expect(post.noComments, 3);
    });

    test('defaults images to empty list when absent', () {
      final post = Post.fromJson(_minimalPostJson());
      expect(post.images, isEmpty);
    });
  });

  group('Post.fromJson — nullable vote fields', () {
    test('userVoted is null when absent', () {
      final post = Post.fromJson(_minimalPostJson());
      expect(post.userVoted, isNull);
    });

    test('userVotedUp is null when absent', () {
      final post = Post.fromJson(_minimalPostJson());
      expect(post.userVotedUp, isNull);
    });

    test('parses userVoted=true and userVotedUp=true', () {
      final json = _minimalPostJson()
        ..['userVoted'] = true
        ..['userVotedUp'] = true;
      final post = Post.fromJson(json);
      expect(post.userVoted, isTrue);
      expect(post.userVotedUp, isTrue);
    });

    test('parses userVoted=true and userVotedUp=false for downvote', () {
      final json = _minimalPostJson()
        ..['userVoted'] = true
        ..['userVotedUp'] = false;
      final post = Post.fromJson(json);
      expect(post.userVoted, isTrue);
      expect(post.userVotedUp, isFalse);
    });
  });

  group('Post.fromJson — optional body and link', () {
    test('body is null when absent', () {
      final post = Post.fromJson(_minimalPostJson());
      expect(post.body, isNull);
    });

    test('body parses when present', () {
      final json = _minimalPostJson()..['body'] = 'Some text';
      final post = Post.fromJson(json);
      expect(post.body, 'Some text');
    });

    test('link is null when absent', () {
      final post = Post.fromJson(_minimalPostJson());
      expect(post.link, isNull);
    });

    test('parses PostLink when present', () {
      final json = _minimalPostJson()
        ..['type'] = 'link'
        ..['link'] = {'url': 'https://example.com', 'hostname': 'example.com'};
      final post = Post.fromJson(json);
      expect(post.link?.url, 'https://example.com');
      expect(post.link?.hostname, 'example.com');
    });
  });

  group('Post.fromJson — flags', () {
    test('isPinned parses correctly', () {
      final json = _minimalPostJson()..['isPinned'] = true;
      expect(Post.fromJson(json).isPinned, isTrue);
    });

    test('locked parses correctly', () {
      final json = _minimalPostJson()..['locked'] = true;
      expect(Post.fromJson(json).locked, isTrue);
    });

    test('deleted parses correctly', () {
      final json = _minimalPostJson()..['deleted'] = true;
      expect(Post.fromJson(json).deleted, isTrue);
    });
  });
}
