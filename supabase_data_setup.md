# ThriveSpace Supabase Data Setup Guide

This guide will help you add sample data to your Supabase database to test your ThriveSpace app functionality.

## 📋 Prerequisites

1. **Supabase Project**: Created and database schema set up using `setup_supabase.md`
2. **Tables Created**: All tables from the setup guide should be created
3. **RLS Policies**: Row Level Security policies should be enabled

## 🚀 Step-by-Step Data Addition Process

### Step 1: Access Supabase SQL Editor

1. Go to your [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your ThriveSpace project
3. Navigate to **SQL Editor** in the left sidebar
4. Click **"New Query"** to create a new SQL query

### Step 2: Create Test Users (Auth + Profiles)

**Important**: You need to create users through Supabase Auth first, then add their profiles.

#### Method A: Create Users via Supabase Dashboard

1. Go to **Authentication** > **Users** in your Supabase dashboard
2. Click **"Add user"**
3. Add these test users one by one:

**User 1 - Coach Mike**
- Email: `mike.coach@thrivespace.com`
- Password: `FitnessCoach123!`
- Confirm Password: `FitnessCoach123!`

**User 2 - Anna Rodriguez**
- Email: `anna.fitness@thrivespace.com`
- Password: `FitnessLover123!`

**User 3 - David Kim**
- Email: `david.nutrition@thrivespace.com`
- Password: `NutritionPro123!`

**User 4 - Sarah Johnson**
- Email: `sarah.runner@thrivespace.com`
- Password: `RunnerLife123!`

**User 5 - Alex Chen**
- Email: `alex.yoga@thrivespace.com`
- Password: `YogaMaster123!`

#### Method B: Create Users via SQL (Advanced)

```sql
-- Insert test users into auth.users table
-- Note: This requires admin privileges and is more complex
-- It's easier to use the dashboard method above
```

### Step 3: Add User Profiles

After creating users via the dashboard, get their UUIDs and run this SQL:

```sql
-- First, let's see the created users to get their IDs
SELECT id, email FROM auth.users WHERE email LIKE '%thrivespace.com';
```

Copy the UUIDs from the results above and use them in the profile inserts below:

```sql
-- Replace the UUIDs below with the actual UUIDs from your auth.users query above
-- Insert User Profiles
INSERT INTO public.profiles (
    id, user_id, username, full_name, avatar_url, bio, age, height, weight, fitness_level, goals, created_at
) VALUES 
-- Coach Mike (Replace 'your-mike-uuid-here' with actual UUID)
(
    'your-mike-uuid-here', 
    'your-mike-uuid-here', 
    'coach_mike', 
    'Mike Thompson', 
    'assets/images/coaches/coach_mike.jpg',
    '🏋️‍♂️ Certified Personal Trainer | 10+ years experience | Strength & Conditioning Specialist',
    32,
    5.10,
    180,
    'expert',
    ARRAY['strength_training', 'muscle_building', 'coaching'],
    NOW()
),
-- Anna Rodriguez (Replace 'your-anna-uuid-here' with actual UUID)
(
    'your-anna-uuid-here', 
    'your-anna-uuid-here', 
    'anna_fitness', 
    'Anna Rodriguez', 
    'assets/images/profiles/profile_female_1.jpg',
    '💪 Fitness enthusiast | Marathon runner | Nutrition lover | Living my best healthy life!',
    28,
    5.5,
    130,
    'intermediate',
    ARRAY['weight_loss', 'endurance', 'healthy_lifestyle'],
    NOW()
),
-- David Kim (Replace 'your-david-uuid-here' with actual UUID)
(
    'your-david-uuid-here', 
    'your-david-uuid-here', 
    'david_nutrition', 
    'David Kim', 
    'assets/images/profiles/profile_male_1.jpg',
    '🥗 Registered Dietitian | Plant-based nutrition advocate | Helping you fuel your fitness journey',
    35,
    5.8,
    165,
    'intermediate',
    ARRAY['nutrition', 'healthy_eating', 'meal_planning'],
    NOW()
),
-- Sarah Johnson (Replace 'your-sarah-uuid-here' with actual UUID)
(
    'your-sarah-uuid-here', 
    'your-sarah-uuid-here', 
    'sarah_runner', 
    'Sarah Johnson', 
    'assets/images/profiles/profile_2.jpg',
    '🏃‍♀️ Trail runner | Half-marathon finisher | Outdoor adventure seeker | Run wild, live free!',
    26,
    5.4,
    125,
    'intermediate',
    ARRAY['running', 'endurance', 'outdoor_activities'],
    NOW()
),
-- Alex Chen (Replace 'your-alex-uuid-here' with actual UUID)
(
    'your-alex-uuid-here', 
    'your-alex-uuid-here', 
    'alex_yoga', 
    'Alex Chen', 
    'assets/images/profiles/profile_1.jpg',
    '🧘‍♂️ Certified Yoga Instructor | Mindfulness advocate | Helping you find balance in body and mind',
    30,
    5.9,
    155,
    'intermediate',
    ARRAY['yoga', 'flexibility', 'mindfulness', 'stress_relief'],
    NOW()
);
```

### Step 4: Add Sample Posts

Now let's add some engaging fitness posts from our users:

```sql
-- Insert Sample Posts
-- Note: Replace the user_id values with the actual UUIDs from your users
INSERT INTO public.posts (
    user_id, content, image_url, post_type, likes_count, comments_count, created_at
) VALUES 
-- Mike's Posts
(
    'your-mike-uuid-here',
    'Just finished an amazing strength training session! 💪 Remember: Progressive overload is the key to building muscle. Start with proper form, then gradually increase the weight. Who''s ready to crush their next workout?',
    'assets/images/posts/workout_deadlift.jpg',
    'workout',
    24,
    8,
    NOW() - INTERVAL '2 hours'
),
(
    'your-mike-uuid-here',
    'Monday Motivation! 🔥 Your body can do it. It''s your mind you need to convince. Every rep, every set, every drop of sweat is building a stronger version of yourself. What''s your why?',
    NULL,
    'motivation',
    45,
    12,
    NOW() - INTERVAL '1 day'
),

-- Anna's Posts  
(
    'your-anna-uuid-here',
    'Sunday meal prep complete! 🥗 This week''s menu: quinoa power bowls with roasted veggies, grilled chicken, and avocado. Proper nutrition fuels great workouts. What''s in your meal prep this week?',
    'assets/images/posts/nutrition_mealprep.jpg',
    'nutrition',
    38,
    15,
    NOW() - INTERVAL '1 hour'
),
(
    'your-anna-uuid-here',
    'New personal record on my morning run! 🏃‍♀️ 8 miles at 7:30 pace. The key? Consistency over perfection. Been building up my endurance slowly but surely. Who else loves that runner''s high?',
    'assets/images/posts/workout_cardio.jpg',
    'achievement',
    52,
    18,
    NOW() - INTERVAL '3 days'
),

-- David's Posts
(
    'your-david-uuid-here',
    'Nutrition Tip Tuesday! 🥤 Post-workout smoothie recipe that actually tastes amazing: 1 banana, 1 cup spinach, 1 scoop protein powder, almond milk, and a tbsp of almond butter. Your muscles will thank you!',
    'assets/images/posts/nutrition_shake.jpg',
    'nutrition',
    67,
    25,
    NOW() - INTERVAL '5 hours'
),
(
    'your-david-uuid-here',
    'Reminder: You don''t need to be perfect with your nutrition 100% of the time. The 80/20 rule works wonders - eat nutrient-dense foods 80% of the time, and allow yourself flexibility for the other 20%. Balance is key! 🌱',
    NULL,
    'advice',
    89,
    31,
    NOW() - INTERVAL '2 days'
),

-- Sarah's Posts
(
    'your-sarah-uuid-here',
    'Trail running therapy session complete! 🌲 There''s something magical about running through nature. Fresh air, beautiful scenery, and that sense of freedom. Where''s your favorite place to run?',
    'assets/images/posts/workout_cardio.jpg',
    'outdoor',
    43,
    14,
    NOW() - INTERVAL '4 hours'
),
(
    'your-sarah-uuid-here',
    'Rest day wisdom: Your muscles grow during recovery, not during the workout. Taking a day off isn''t being lazy - it''s being smart! Today I''m doing some gentle stretching and enjoying a good book. 📚',
    'assets/images/posts/workout_stretching.jpg',
    'recovery',
    56,
    9,
    NOW() - INTERVAL '6 days'
),

-- Alex's Posts
(
    'your-alex-uuid-here',
    'Morning yoga flow complete! 🧘‍♂️ Started my day with 30 minutes of mindful movement. Yoga isn''t just about flexibility - it''s about finding balance in your body, breath, and mind. Namaste! ✨',
    'assets/images/posts/workout_yoga.jpg',
    'yoga',
    71,
    22,
    NOW() - INTERVAL '30 minutes'
),
(
    'your-alex-uuid-here',
    'Mindfulness Monday reminder: Take 5 deep breaths right now. Inhale peace, exhale stress. Your mental health is just as important as your physical health. How are you taking care of your mind today? 🧠💙',
    NULL,
    'mindfulness',
    94,
    35,
    NOW() - INTERVAL '4 days'
);
```

### Step 5: Add Sample Conversations

Let's create some conversations between users:

```sql
-- Insert Sample Conversations
-- Note: Replace user IDs with actual UUIDs
INSERT INTO public.conversations (
    user1_id, user2_id, created_at, updated_at
) VALUES 
-- Conversation between You (current user) and Mike (coach)
-- Replace 'your-user-id' with your actual user ID and 'mike-uuid' with Mike's UUID
('your-user-id', 'your-mike-uuid-here', NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 minutes'),

-- Conversation between You and Anna
('your-user-id', 'your-anna-uuid-here', NOW() - INTERVAL '1 day', NOW() - INTERVAL '15 minutes'),

-- Conversation between You and David  
('your-user-id', 'your-david-uuid-here', NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 hours'),

-- Conversation between You and Sarah
('your-user-id', 'your-sarah-uuid-here', NOW() - INTERVAL '5 days', NOW() - INTERVAL '2 hours'),

-- Conversation between You and Alex
('your-user-id', 'your-alex-uuid-here', NOW() - INTERVAL '1 week', NOW() - INTERVAL '1 day');
```

### Step 6: Add Sample Messages

Now let's add messages to these conversations:

```sql
-- First, get the conversation IDs
SELECT id, user1_id, user2_id FROM public.conversations ORDER BY created_at DESC;
```

Use the conversation IDs from above in the messages below:

```sql
-- Insert Sample Messages
-- Replace conversation_id values with actual IDs from the query above
INSERT INTO public.messages (
    conversation_id, sender_id, content, created_at
) VALUES 
-- Messages with Coach Mike (replace 'conv-id-1' with actual conversation ID)
('conv-id-1', 'your-mike-uuid-here', 'Great job on today''s workout! Keep it up 💪', NOW() - INTERVAL '2 minutes'),
('conv-id-1', 'your-user-id', 'Thanks coach! I''m really feeling the progress', NOW() - INTERVAL '5 minutes'),
('conv-id-1', 'your-mike-uuid-here', 'I can see the improvement in your form. Ready for tomorrow''s session?', NOW() - INTERVAL '10 minutes'),

-- Messages with Anna (replace 'conv-id-2' with actual conversation ID)  
('conv-id-2', 'your-anna-uuid-here', 'Thanks for the nutrition tips! 🙏', NOW() - INTERVAL '15 minutes'),
('conv-id-2', 'your-user-id', 'You''re welcome! How did the meal prep go?', NOW() - INTERVAL '20 minutes'),
('conv-id-2', 'your-anna-uuid-here', 'Amazing! I feel so much more energized', NOW() - INTERVAL '25 minutes'),

-- Messages with David (replace 'conv-id-3' with actual conversation ID)
('conv-id-3', 'your-david-uuid-here', 'Your meal plan is ready for review', NOW() - INTERVAL '3 hours'),
('conv-id-3', 'your-user-id', 'Perfect timing! Can''t wait to check it out', NOW() - INTERVAL '3 hours 5 minutes'),

-- Messages with Sarah (replace 'conv-id-4' with actual conversation ID)
('conv-id-4', 'your-sarah-uuid-here', 'Sent a photo', NOW() - INTERVAL '2 hours'),
('conv-id-4', 'your-user-id', 'Wow! That trail looks incredible', NOW() - INTERVAL '2 hours 10 minutes'),

-- Messages with Alex (replace 'conv-id-5' with actual conversation ID)
('conv-id-5', 'your-alex-uuid-here', 'How was your first yoga session?', NOW() - INTERVAL '1 day'),
('conv-id-5', 'your-user-id', 'Challenging but amazing! My flexibility has improved', NOW() - INTERVAL '1 day 30 minutes');
```

### Step 7: Add Sample Notifications

Let's add some notifications to make the app feel alive:

```sql
-- Insert Sample Notifications  
-- Replace user_id and sender_id with actual UUIDs
INSERT INTO public.notifications (
    user_id, sender_id, type, title, message, is_read, created_at
) VALUES 
-- Notifications for the current user (replace 'your-user-id' with actual ID)
('your-user-id', 'your-mike-uuid-here', 'message', 'New message from Coach Mike', 'Great job on today''s workout! Keep it up 💪', false, NOW() - INTERVAL '2 minutes'),

('your-user-id', 'your-anna-uuid-here', 'like', 'Anna liked your post', 'Anna Rodriguez liked your workout post', false, NOW() - INTERVAL '1 hour'),

('your-user-id', 'your-david-uuid-here', 'comment', 'New comment on your post', 'David Kim commented: "Great form! Keep it up!"', false, NOW() - INTERVAL '3 hours'),

('your-user-id', 'your-sarah-uuid-here', 'follow', 'New follower', 'Sarah Johnson started following you', true, NOW() - INTERVAL '6 hours'),

('your-user-id', 'your-alex-uuid-here', 'achievement', 'Workout milestone', 'Congratulations! You''ve completed 10 workouts this month', true, NOW() - INTERVAL '1 day'),

('your-user-id', 'your-mike-uuid-here', 'reminder', 'Workout reminder', 'Your training session with Coach Mike starts in 1 hour', true, NOW() - INTERVAL '2 days'),

('your-user-id', 'your-anna-uuid-here', 'challenge', 'Weekly challenge', 'Anna invited you to join the "30-Day Running Challenge"', false, NOW() - INTERVAL '3 days');
```

### Step 8: Add Post Likes

Let's add some likes to posts to make them feel more engaging:

```sql
-- Insert Sample Post Likes using actual post and user IDs
INSERT INTO public.post_likes (
    user_id, post_id, created_at
) VALUES 
-- Mike's strength training post gets likes from Anna, David, and Sarah
('d163186a-bb01-4bb5-a39c-b9ebc059b9c9', 'b6e27a6d-0cb3-498e-817c-95fdbb930ad8', NOW() - INTERVAL '1 hour'),
('565da743-ae10-4d24-9ca7-52b180d6bee8', 'b6e27a6d-0cb3-498e-817c-95fdbb930ad8', NOW() - INTERVAL '2 hours'),
('d2d899b8-4738-4729-a7e8-270ac7f59621', 'b6e27a6d-0cb3-498e-817c-95fdbb930ad8', NOW() - INTERVAL '3 hours'),

-- Mike's Monday motivation post gets likes from Alex and Anna
('ff3a9f1b-d8a6-4e5f-ad02-7c0bb76b499e', 'b10baaf8-e124-4e8e-bcff-13e1664930e1', NOW() - INTERVAL '30 minutes'),
('d163186a-bb01-4bb5-a39c-b9ebc059b9c9', 'b10baaf8-e124-4e8e-bcff-13e1664930e1', NOW() - INTERVAL '45 minutes'),

-- Anna's meal prep post gets likes from Mike, David, and Sarah
('5f349cee-9a2f-48d6-8f51-20ef5f798b67', '5281c66c-d55f-4fb9-a8fc-7bd2f16698ab', NOW() - INTERVAL '2 hours'),
('565da743-ae10-4d24-9ca7-52b180d6bee8', '5281c66c-d55f-4fb9-a8fc-7bd2f16698ab', NOW() - INTERVAL '4 hours'),
('d2d899b8-4738-4729-a7e8-270ac7f59621', '5281c66c-d55f-4fb9-a8fc-7bd2f16698ab', NOW() - INTERVAL '5 hours'),

-- Anna's running PR post gets likes from Sarah, Alex, and Mike
('d2d899b8-4738-4729-a7e8-270ac7f59621', 'fd6dffbb-dfbf-47c9-bea9-564dfaca5a5c', NOW() - INTERVAL '1 hour'),
('ff3a9f1b-d8a6-4e5f-ad02-7c0bb76b499e', 'fd6dffbb-dfbf-47c9-bea9-564dfaca5a5c', NOW() - INTERVAL '2 hours'),
('5f349cee-9a2f-48d6-8f51-20ef5f798b67', 'fd6dffbb-dfbf-47c9-bea9-564dfaca5a5c', NOW() - INTERVAL '3 hours'),

-- David's smoothie recipe gets likes from Anna, Sarah, and Alex
('d163186a-bb01-4bb5-a39c-b9ebc059b9c9', '2816092a-574d-4d0c-aa08-0bfc2bae6260', NOW() - INTERVAL '90 minutes'),
('d2d899b8-4738-4729-a7e8-270ac7f59621', '2816092a-574d-4d0c-aa08-0bfc2bae6260', NOW() - INTERVAL '3 hours'),
('ff3a9f1b-d8a6-4e5f-ad02-7c0bb76b499e', '2816092a-574d-4d0c-aa08-0bfc2bae6260', NOW() - INTERVAL '4 hours'),

-- David's 80/20 rule post gets likes from Mike and Anna
('5f349cee-9a2f-48d6-8f51-20ef5f798b67', '64ca2a9b-8243-43b3-8371-8bc9c67b218d', NOW() - INTERVAL '1 day'),
('d163186a-bb01-4bb5-a39c-b9ebc059b9c9', '64ca2a9b-8243-43b3-8371-8bc9c67b218d', NOW() - INTERVAL '1 day 2 hours'),

-- Sarah's trail running post gets likes from Anna and Alex
('d163186a-bb01-4bb5-a39c-b9ebc059b9c9', 'b8553af2-1cd4-4676-9928-e1f4f6d0b48a', NOW() - INTERVAL '3 hours'),
('ff3a9f1b-d8a6-4e5f-ad02-7c0bb76b499e', 'b8553af2-1cd4-4676-9928-e1f4f6d0b48a', NOW() - INTERVAL '4 hours'),

-- Sarah's rest day wisdom gets likes from Alex and David
('ff3a9f1b-d8a6-4e5f-ad02-7c0bb76b499e', '37e756eb-718f-43e7-86cf-a2a7009832f6', NOW() - INTERVAL '5 days'),
('565da743-ae10-4d24-9ca7-52b180d6bee8', '37e756eb-718f-43e7-86cf-a2a7009832f6', NOW() - INTERVAL '5 days 2 hours'),

-- Alex's morning yoga post gets likes from Sarah, Anna, and David
('d2d899b8-4738-4729-a7e8-270ac7f59621', 'aa98c9e3-ac0e-452d-a7c4-738048f92737', NOW() - INTERVAL '25 minutes'),
('d163186a-bb01-4bb5-a39c-b9ebc059b9c9', 'aa98c9e3-ac0e-452d-a7c4-738048f92737', NOW() - INTERVAL '35 minutes'),
('565da743-ae10-4d24-9ca7-52b180d6bee8', 'aa98c9e3-ac0e-452d-a7c4-738048f92737', NOW() - INTERVAL '1 hour'),

-- Alex's mindfulness post gets likes from Mike, Anna, Sarah, and David
('5f349cee-9a2f-48d6-8f51-20ef5f798b67', '5ef77eea-60d4-46a2-b8b3-7464ef550575', NOW() - INTERVAL '3 days'),
('d163186a-bb01-4bb5-a39c-b9ebc059b9c9', '5ef77eea-60d4-46a2-b8b3-7464ef550575', NOW() - INTERVAL '3 days 1 hour'),
('d2d899b8-4738-4729-a7e8-270ac7f59621', '5ef77eea-60d4-46a2-b8b3-7464ef550575', NOW() - INTERVAL '3 days 2 hours'),
('565da743-ae10-4d24-9ca7-52b180d6bee8', '5ef77eea-60d4-46a2-b8b3-7464ef550575', NOW() - INTERVAL '3 days 3 hours');
```
