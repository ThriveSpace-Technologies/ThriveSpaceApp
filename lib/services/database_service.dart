import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  static final SupabaseClient _supabase = Supabase.instance.client;
  
  // User Profile Operations
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('user_id', userId)
          .single();
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> createUserProfile({
    required String userId,
    required Map<String, dynamic> profileData,
  }) async {
    try {
      await _supabase.from('profiles').insert({
        'user_id': userId,
        ...profileData,
      });
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> profileData,
  }) async {
    try {
      await _supabase
          .from('profiles')
          .update(profileData)
          .eq('user_id', userId);
    } catch (e) {
      rethrow;
    }
  }
  
  // Posts Operations
  Future<List<Map<String, dynamic>>> getPosts({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _supabase
          .from('posts')
          .select('''
            *,
            profiles:user_id (
              username,
              avatar_url,
              full_name
            )
          ''')
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> createPost({
    required String userId,
    required String content,
    String? imageUrl,
    String? postType,
  }) async {
    try {
      await _supabase.from('posts').insert({
        'user_id': userId,
        'content': content,
        'image_url': imageUrl,
        'post_type': postType,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> likePost({
    required String userId,
    required String postId,
  }) async {
    try {
      await _supabase.from('post_likes').insert({
        'user_id': userId,
        'post_id': postId,
      });
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> unlikePost({
    required String userId,
    required String postId,
  }) async {
    try {
      await _supabase
          .from('post_likes')
          .delete()
          .eq('user_id', userId)
          .eq('post_id', postId);
    } catch (e) {
      rethrow;
    }
  }
  
  // Messages Operations
  Future<List<Map<String, dynamic>>> getConversations({
    required String userId,
  }) async {
    try {
      final response = await _supabase
          .from('conversations')
          .select('''
            *,
            participant1:user1_id (
              username,
              avatar_url,
              full_name
            ),
            participant2:user2_id (
              username,
              avatar_url,
              full_name
            ),
            last_message:messages (
              content,
              created_at,
              sender_id
            )
          ''')
          .or('user1_id.eq.$userId,user2_id.eq.$userId')
          .order('updated_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }
  
  Future<List<Map<String, dynamic>>> getMessages({
    required String conversationId,
    int limit = 50,
  }) async {
    try {
      final response = await _supabase
          .from('messages')
          .select('''
            *,
            sender:sender_id (
              username,
              avatar_url,
              full_name
            )
          ''')
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: false)
          .limit(limit);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
  }) async {
    try {
      await _supabase.from('messages').insert({
        'conversation_id': conversationId,
        'sender_id': senderId,
        'content': content,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }
  
  // Notifications Operations
  Future<List<Map<String, dynamic>>> getNotifications({
    required String userId,
    int limit = 20,
  }) async {
    try {
      final response = await _supabase
          .from('notifications')
          .select('''
            *,
            sender:sender_id (
              username,
              avatar_url,
              full_name
            )
          ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(limit);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> markNotificationAsRead({
    required String notificationId,
  }) async {
    try {
      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);
    } catch (e) {
      rethrow;
    }
  }
  
  // Real-time subscriptions
  RealtimeChannel subscribeToMessages({
    required String conversationId,
    required Function(Map<String, dynamic>) onMessage,
  }) {
    return _supabase
        .channel('messages:$conversationId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'conversation_id',
            value: conversationId,
          ),
          callback: (payload) {
            onMessage(payload.newRecord);
          },
        )
        .subscribe();
  }
  
  RealtimeChannel subscribeToNotifications({
    required String userId,
    required Function(Map<String, dynamic>) onNotification,
  }) {
    return _supabase
        .channel('notifications:$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'notifications',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            onNotification(payload.newRecord);
          },
        )
        .subscribe();
  }
}