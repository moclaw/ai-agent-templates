# Universal Code Standards and Best Practices

This document defines code standards and best practices for all projects in this organization.

## General Principles

### Code Quality

1. **Readability First**: Code is read more than written
2. **Consistency**: Follow established patterns
3. **Simplicity**: Prefer simple over clever
4. **Maintainability**: Think about future developers

### SOLID Principles

- **S**ingle Responsibility Principle
- **O**pen/Closed Principle
- **L**iskov Substitution Principle
- **I**nterface Segregation Principle
- **D**ependency Inversion Principle

## Naming Conventions

### Variables and Functions

```javascript
// camelCase for variables and functions
const userCount = 10;
function getUserById(id) {}

// PascalCase for classes and components
class UserService {}
const UserProfile = () => {};

// UPPER_CASE for constants
const API_BASE_URL = 'https://api.example.com';
const MAX_RETRY_ATTEMPTS = 3;

// Prefix booleans with is/has/should
const isActive = true;
const hasPermission = false;
const shouldUpdate = true;
```

### Files and Directories

```
// kebab-case for files
user-profile.ts
api-client.ts

// PascalCase for component files
UserProfile.tsx
LoginForm.tsx

// lowercase for directories
components/
utils/
services/
```

## Code Organization

### File Structure

```javascript
// 1. Imports (external first, then internal)
import React from 'react';
import { View } from 'react-native';

import { UserService } from '../services';
import { formatDate } from '../utils';

// 2. Types/Interfaces
interface UserProps {
  id: string;
  name: string;
}

// 3. Constants
const MAX_USERS = 100;

// 4. Component/Function
export function UserList({ users }: Props) {
  // ...
}

// 5. Exports (if not inline)
export { UserList };
```

### Function Length

- Keep functions small (< 50 lines)
- Extract complex logic into separate functions
- One function, one responsibility

```javascript
// Bad: Too many responsibilities
function processUser(user) {
  // validate
  // transform
  // save
  // notify
  // log
}

// Good: Single responsibility
function validateUser(user) {}
function transformUser(user) {}
function saveUser(user) {}
```

## Comments and Documentation

### When to Comment

```javascript
// Good: Explain WHY
// Using setTimeout to debounce API calls
// and prevent rate limiting (max 10 req/sec)
setTimeout(() => fetchData(), 100);

// Bad: Explain WHAT (code already says this)
// Increment counter by 1
counter++;

// Good: Complex business logic
// Discount calculation:
// - 10% for orders > $100
// - 15% for orders > $500
// - 20% for VIP customers
function calculateDiscount(order, customer) {}
```

### JSDoc for Public APIs

```javascript
/**
 * Fetches user data from the API
 * @param {string} userId - The user's unique identifier
 * @param {Object} options - Optional configuration
 * @param {boolean} options.includeProfile - Include profile data
 * @returns {Promise<User>} User object
 * @throws {Error} If user not found
 */
async function getUser(userId, options = {}) {}
```

## Error Handling

### Always Handle Errors

```javascript
// Bad: Silent failure
try {
  await saveData();
} catch (e) {}

// Good: Log and handle
try {
  await saveData();
} catch (error) {
  console.error('Failed to save data:', error);
  showErrorMessage('Could not save. Please try again.');
  reportError(error);
}
```

### Use Specific Error Types

```javascript
class ValidationError extends Error {
  constructor(field, message) {
    super(message);
    this.name = 'ValidationError';
    this.field = field;
  }
}

class NetworkError extends Error {
  constructor(status, message) {
    super(message);
    this.name = 'NetworkError';
    this.status = status;
  }
}
```

## Testing

### Test Coverage

- Minimum 80% coverage
- 100% for critical paths
- Test edge cases and errors

### Test Structure

```javascript
describe('UserService', () => {
  describe('getUser', () => {
    it('returns user when found', async () => {
      // Arrange
      const userId = '123';
      const expected = { id: '123', name: 'John' };
      
      // Act
      const result = await UserService.getUser(userId);
      
      // Assert
      expect(result).toEqual(expected);
    });

    it('throws error when user not found', async () => {
      // Arrange
      const userId = 'invalid';
      
      // Act & Assert
      await expect(
        UserService.getUser(userId)
      ).rejects.toThrow('User not found');
    });
  });
});
```

## Performance

### Optimization Guidelines

1. **Measure First**: Profile before optimizing
2. **Avoid Premature Optimization**: Make it work, then make it fast
3. **Cache When Appropriate**: Don't re-compute unnecessarily
4. **Lazy Load**: Load resources when needed

### Common Patterns

```javascript
// Memoization
const memoize = (fn) => {
  const cache = new Map();
  return (...args) => {
    const key = JSON.stringify(args);
    if (cache.has(key)) return cache.get(key);
    const result = fn(...args);
    cache.set(key, result);
    return result;
  };
};

// Debouncing
const debounce = (fn, delay) => {
  let timeout;
  return (...args) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => fn(...args), delay);
  };
};

// Throttling
const throttle = (fn, limit) => {
  let inThrottle;
  return (...args) => {
    if (!inThrottle) {
      fn(...args);
      inThrottle = true;
      setTimeout(() => (inThrottle = false), limit);
    }
  };
};
```

## Security

### Input Validation

```javascript
// Always validate user input
function createUser(data) {
  const schema = z.object({
    email: z.string().email(),
    password: z.string().min(8),
    age: z.number().min(18)
  });
  
  const validated = schema.parse(data);
  return saveUser(validated);
}
```

### Sensitive Data

```javascript
// Never log sensitive data
console.log({ userId, email }); // OK
console.log({ password, token }); // NEVER

// Sanitize outputs
function sanitizeUser(user) {
  const { password, token, ...safe } = user;
  return safe;
}
```

### SQL Injection Prevention

```javascript
// Bad: String concatenation
const query = `SELECT * FROM users WHERE id = ${userId}`;

// Good: Parameterized queries
const query = 'SELECT * FROM users WHERE id = ?';
db.execute(query, [userId]);
```

## Git Commit Messages

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

### Examples

```
feat(auth): add JWT token refresh

Implemented automatic token refresh 5 minutes before expiration.
Added retry logic for failed refresh attempts.

Closes #123
```

```
fix(api): resolve race condition in user creation

Added mutex lock to prevent duplicate user creation
when multiple requests arrive simultaneously.

Fixes #456
```

## Code Review Checklist

- [ ] Code follows standards
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] No commented-out code
- [ ] No console.logs in production code
- [ ] Error handling present
- [ ] Security considerations addressed
- [ ] Performance acceptable
- [ ] Accessible (if UI)
- [ ] Mobile responsive (if web)

## Resources

- [Clean Code by Robert Martin](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)
- [Refactoring by Martin Fowler](https://refactoring.com/)
- [You Don't Know JS](https://github.com/getify/You-Dont-Know-JS)

## Enforcement

- Automated linting (ESLint, Prettier)
- Pre-commit hooks
- CI/CD checks
- Code review requirements
- Regular audits

## Updates

This document is living and should be updated as:
- New patterns emerge
- Technologies change
- Team grows
- Lessons learned

Last updated: 2025-11-20
