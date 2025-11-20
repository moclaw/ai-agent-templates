# Supabase Integration Guide

This guide covers integrating Supabase with your application and working with Claude.

## Setup

### Install Supabase Client

```bash
npm install @supabase/supabase-js
```

### Initialize Client

```javascript
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseKey);
```

## Authentication

### Sign Up

```javascript
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'secure-password'
});
```

### Sign In

```javascript
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'secure-password'
});
```

### Sign Out

```javascript
const { error } = await supabase.auth.signOut();
```

### OAuth

```javascript
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'google'
});
```

## Database Operations

### Insert

```javascript
const { data, error } = await supabase
  .from('users')
  .insert([
    { name: 'John Doe', email: 'john@example.com' }
  ]);
```

### Select

```javascript
const { data, error } = await supabase
  .from('users')
  .select('*')
  .eq('id', userId);
```

### Update

```javascript
const { data, error } = await supabase
  .from('users')
  .update({ name: 'Jane Doe' })
  .eq('id', userId);
```

### Delete

```javascript
const { data, error} = await supabase
  .from('users')
  .delete()
  .eq('id', userId);
```

## Real-time Subscriptions

```javascript
const channel = supabase
  .channel('public:users')
  .on(
    'postgres_changes',
    { event: '*', schema: 'public', table: 'users' },
    (payload) => {
      console.log('Change received!', payload);
    }
  )
  .subscribe();
```

## Storage

### Upload File

```javascript
const { data, error } = await supabase.storage
  .from('avatars')
  .upload('public/avatar.png', file);
```

### Download File

```javascript
const { data, error } = await supabase.storage
  .from('avatars')
  .download('public/avatar.png');
```

### Get Public URL

```javascript
const { data } = supabase.storage
  .from('avatars')
  .getPublicUrl('public/avatar.png');
```

## Edge Functions

```typescript
// supabase/functions/hello/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';

serve(async (req) => {
  const { name } = await req.json();
  
  return new Response(
    JSON.stringify({ message: `Hello ${name}!` }),
    { headers: { 'Content-Type': 'application/json' } }
  );
});
```

## Row Level Security

```sql
-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only see their own data
CREATE POLICY "Users can view their own data"
  ON users FOR SELECT
  USING (auth.uid() = id);

-- Policy: Users can only update their own data
CREATE POLICY "Users can update their own data"
  ON users FOR UPDATE
  USING (auth.uid() = id);
```

## Best Practices

### Error Handling

```javascript
async function getUser(userId) {
  try {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', userId)
      .single();

    if (error) throw error;
    return data;
  } catch (error) {
    console.error('Error fetching user:', error);
    throw error;
  }
}
```

### Type Safety

```typescript
import { Database } from './types/supabase';

const supabase = createClient<Database>(
  supabaseUrl,
  supabaseKey
);

// Now you have full TypeScript support
const { data } = await supabase
  .from('users')
  .select('*');
// data is typed as User[]
```

### Connection Pooling

```javascript
import { createClient } from '@supabase/supabase-js';

export const supabase = createClient(
  supabaseUrl,
  supabaseKey,
  {
    db: {
      schema: 'public',
    },
    auth: {
      autoRefreshToken: true,
      persistSession: true,
      detectSessionInUrl: true
    }
  }
);
```

## Claude Integration

### When asking Claude:

```
Create a Supabase function to:
- Fetch user profile
- Include related posts
- Handle errors
- Add TypeScript types
```

```
Write RLS policies for a blog app where:
- Users can create their own posts
- Users can read all published posts
- Only post authors can edit their posts
- Admins can do everything
```

## Testing

```javascript
import { createClient } from '@supabase/supabase-js';

// Use test database
const supabase = createClient(
  process.env.TEST_SUPABASE_URL,
  process.env.TEST_SUPABASE_KEY
);

describe('User operations', () => {
  it('creates a user', async () => {
    const { data, error } = await supabase
      .from('users')
      .insert({ name: 'Test User' });
    
    expect(error).toBeNull();
    expect(data).toBeDefined();
  });
});
```

## Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase JavaScript Client](https://supabase.com/docs/reference/javascript)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)

## See Also

- Database schema in `specs/`
- API examples in `examples/`
- Authentication patterns
