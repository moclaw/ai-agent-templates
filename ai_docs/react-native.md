# React Native Development with Claude

This guide covers React Native development best practices when working with Claude.

## Project Structure

```
react-native-app/
├── src/
│   ├── components/     # Reusable components
│   ├── screens/        # Screen components
│   ├── navigation/     # Navigation configuration
│   ├── services/       # API and business logic
│   ├── hooks/          # Custom hooks
│   ├── utils/          # Utility functions
│   ├── constants/      # Constants and config
│   └── types/          # TypeScript types
├── assets/             # Images, fonts
├── __tests__/          # Tests
└── App.tsx             # Root component
```

## Best Practices

### Components

```tsx
// Good component structure
import React, { memo } from 'react';
import { View, Text, StyleSheet } from 'react-native';

interface UserCardProps {
  name: string;
  email: string;
  onPress: () => void;
}

export const UserCard = memo<UserCardProps>(({ name, email, onPress }) => {
  return (
    <View style={styles.container}>
      <Text style={styles.name}>{name}</Text>
      <Text style={styles.email}>{email}</Text>
    </View>
  );
});

const styles = StyleSheet.create({
  container: {
    padding: 16,
    backgroundColor: '#fff',
  },
  name: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  email: {
    fontSize: 14,
    color: '#666',
  },
});
```

### Hooks

```tsx
// Custom hook example
import { useState, useEffect } from 'react';

export function useUser(userId: string) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchUser(userId)
      .then(setUser)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [userId]);

  return { user, loading, error };
}
```

### Navigation

```tsx
// React Navigation setup
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Profile" component={ProfileScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

### State Management

```tsx
// Context example
import React, { createContext, useContext, useState } from 'react';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);

  const login = async (email, password) => {
    const userData = await authService.login(email, password);
    setUser(userData);
  };

  const logout = () => {
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export const useAuth = () => useContext(AuthContext);
```

## Claude Integration

### When asking Claude for help:

```
Create a React Native screen component for user profile with:
- Profile image (TouchableOpacity to change)
- Name and email fields (editable)
- Save button
- Loading states
- Error handling
- TypeScript types
```

### Code Review

```
Review this React Native component for:
- Performance issues
- Memory leaks
- Accessibility
- Best practices
- TypeScript usage
```

### Debugging

```
This React Native app crashes when navigating to ProfileScreen.
Error: Cannot read property 'name' of undefined

[Paste relevant code]

Help me debug this issue.
```

## Testing

```tsx
import { render, fireEvent } from '@testing-library/react-native';
import { UserCard } from './UserCard';

describe('UserCard', () => {
  it('displays user information', () => {
    const { getByText } = render(
      <UserCard name="John Doe" email="john@example.com" onPress={() => {}} />
    );
    
    expect(getByText('John Doe')).toBeTruthy();
    expect(getByText('john@example.com')).toBeTruthy();
  });

  it('calls onPress when pressed', () => {
    const onPress = jest.fn();
    const { getByText } = render(
      <UserCard name="John Doe" email="john@example.com" onPress={onPress} />
    );
    
    fireEvent.press(getByText('John Doe'));
    expect(onPress).toHaveBeenCalled();
  });
});
```

## Performance

### Optimization Tips

1. Use `memo` for expensive components
2. Use `useMemo` and `useCallback` appropriately
3. Optimize FlatList with `getItemLayout`
4. Use `removeClippedSubviews` for long lists
5. Optimize images with proper sizing
6. Use Hermes engine
7. Enable RAM bundles

### Example

```tsx
import { FlatList, View } from 'react-native';

const OptimizedList = memo(() => {
  const renderItem = useCallback(({ item }) => (
    <ItemCard item={item} />
  ), []);

  const keyExtractor = useCallback((item) => item.id, []);

  return (
    <FlatList
      data={data}
      renderItem={renderItem}
      keyExtractor={keyExtractor}
      removeClippedSubviews
      maxToRenderPerBatch={10}
      windowSize={5}
      getItemLayout={(data, index) => ({
        length: ITEM_HEIGHT,
        offset: ITEM_HEIGHT * index,
        index,
      })}
    />
  );
});
```

## Resources

- [React Native Documentation](https://reactnative.dev/)
- [React Navigation](https://reactnavigation.org/)
- [React Native Paper](https://callstack.github.io/react-native-paper/)

## See Also

- Component examples in `examples/`
- Testing patterns in `tests/`
- `specs/code-standards.md` for coding standards
