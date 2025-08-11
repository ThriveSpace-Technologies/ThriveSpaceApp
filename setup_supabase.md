# Supabase Setup Guide

## 1. Create a Supabase Project

1. Go to [https://supabase.com](https://supabase.com) and sign up/sign in
2. Click "New Project"
3. Choose your organization
4. Enter project name: "ThriveSpace"
5. Generate a secure password
6. Choose your region
7. Click "Create new project"

## 2. Get Your Project Credentials

1. In your Supabase dashboard, go to Settings > API
2. Copy your **Project URL** and **anon/public key**
3. Update your `.env` file with these values:

```env
SUPABASE_URL=your_actual_project_url_here
SUPABASE_ANON_KEY=your_actual_anon_key_here
```

## 3. Set Up Database Tables

Run these SQL commands in your Supabase SQL editor:

### Create Profiles Table
```sql
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE,
  username TEXT UNIQUE,
  full_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  age INTEGER,
  height REAL,
  weight REAL,
  fitness_level TEXT,
  goals TEXT[],
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  
  PRIMARY KEY (id)
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
```

### Create Posts Table
```sql
CREATE TABLE public.posts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  image_url TEXT,
  post_type TEXT DEFAULT 'general',
  likes_count INTEGER DEFAULT 0,
  comments_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;
```

### Create Conversations Table
```sql
CREATE TABLE public.conversations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user1_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  user2_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  
  UNIQUE(user1_id, user2_id)
);

ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;
```

### Create Messages Table
```sql
CREATE TABLE public.messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  conversation_id UUID REFERENCES public.conversations ON DELETE CASCADE NOT NULL,
  sender_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  content TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
```

### Create Notifications Table
```sql
CREATE TABLE public.notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  sender_id UUID REFERENCES auth.users ON DELETE CASCADE,
  type TEXT NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
```

### Create Post Likes Table
```sql
CREATE TABLE public.post_likes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
  post_id UUID REFERENCES public.posts ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  
  UNIQUE(user_id, post_id)
);

ALTER TABLE public.post_likes ENABLE ROW LEVEL SECURITY;
```

## 4. Set Up Row Level Security (RLS) Policies

Run these policies in your Supabase SQL editor:

### Profiles Policies
```sql
-- Users can view all profiles
CREATE POLICY "Public profiles are viewable by everyone." ON public.profiles
  FOR SELECT USING (true);

-- Users can insert their own profile
CREATE POLICY "Users can insert their own profile." ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Users can update their own profile
CREATE POLICY "Users can update own profile." ON public.profiles
  FOR UPDATE USING (auth.uid() = user_id);
```

### Posts Policies
```sql
-- Anyone can view posts
CREATE POLICY "Posts are viewable by everyone." ON public.posts
  FOR SELECT USING (true);

-- Users can insert their own posts
CREATE POLICY "Users can insert their own posts." ON public.posts
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Users can update their own posts
CREATE POLICY "Users can update their own posts." ON public.posts
  FOR UPDATE USING (auth.uid() = user_id);

-- Users can delete their own posts
CREATE POLICY "Users can delete their own posts." ON public.posts
  FOR DELETE USING (auth.uid() = user_id);
```

### Messages Policies
```sql
-- Users can view messages in conversations they're part of
CREATE POLICY "Users can view their own messages." ON public.messages
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.conversations 
      WHERE conversations.id = messages.conversation_id 
      AND (conversations.user1_id = auth.uid() OR conversations.user2_id = auth.uid())
    )
  );

-- Users can insert messages in conversations they're part of
CREATE POLICY "Users can insert messages in their conversations." ON public.messages
  FOR INSERT WITH CHECK (
    auth.uid() = sender_id AND
    EXISTS (
      SELECT 1 FROM public.conversations 
      WHERE conversations.id = conversation_id 
      AND (conversations.user1_id = auth.uid() OR conversations.user2_id = auth.uid())
    )
  );
```

## 5. Enable Realtime (Optional)

In your Supabase dashboard:
1. Go to Settings > API
2. Scroll to "Realtime API"
3. Add the tables you want to enable realtime for:
   - `messages`
   - `notifications`
   - `posts`

## 6. Test Your Setup

1. Run `flutter pub get` to install dependencies
2. Update your `.env` file with actual Supabase credentials
3. Run your app: `flutter run`
4. Try signing up with a new account
5. Check your Supabase dashboard to see if the user was created

## Next Steps

- Implement profile creation after signup
- Add real-time chat functionality
- Set up push notifications
- Add file upload for profile pictures and post images
- Implement proper error handling and loading states