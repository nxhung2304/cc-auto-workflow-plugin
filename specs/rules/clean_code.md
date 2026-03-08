# Clean Code Rules

> Language-agnostic principles. Apply to every project regardless of stack.
> Language-specific rules (Rails, Flutter, etc.) supplement this file — they do not replace it.

---

## Naming & Readability

### Use intention-revealing names

A name should tell you **what it is**, **what it does**, and **why it exists** — without needing a comment to explain it.

Bad
```
int d; // elapsed time in days
bool flag;
list data;
```

Good
```
int elapsedDays;
bool isUserLoggedIn;
list<Order> pendingOrders;
```

### Use pronounceable names

If you can't say it out loud, it's harder to discuss in code review.

Bad
```
yyyymmdd
cstmrRcrd
```

Good
```
birthDate
customerRecord
```

### Use searchable names

Single letters and bare numbers are hard to grep. Reserve single letters only for short loop counters.

Bad
```
sleep(86400)
for i in r
```

Good
```
SECONDS_PER_DAY = 86400
sleep(SECONDS_PER_DAY)
```

### Don't add noise or redundant context

If the class is `User`, you don't need `UserName`, `UserEmail` — just `name`, `email`.

Bad
```
class User {
  userName
  userEmail
  userAge
}
```

Good
```
class User {
  name
  email
  age
}
```

### Avoid mental mapping

Don't make the reader translate a name into what it actually means.

Bad
```
list.forEach((e) => e.process())
```

Good
```
orders.forEach((order) => order.process())
```

---

## Functions / Methods

### Do one thing

A function should do **one thing**, do it **well**, and do it **only**.
If you can extract a meaningful sub-function, the original function is doing more than one thing.

Bad
```
function processOrder(order) {
  validateOrder(order)
  order.discount = order.total > 100 ? order.total * 0.1 : 0
  saveToDatabase(order)
  sendConfirmationEmail(order.user)
}
```

Good
```
function processOrder(order) {
  validateOrder(order)
  applyDiscount(order)
  saveOrder(order)
  notifyUser(order.user)
}
```

### Keep functions small

Functions should rarely exceed 20 lines. If it's getting long, extract.

### Use descriptive function names

The name should say **what** it does, not **how**.

Bad
```
handle()
process()
doStuff()
```

Good
```
sendWelcomeEmail()
calculateMonthlyRevenue()
archiveExpiredSessions()
```

### Prefer fewer arguments

The ideal number of arguments is zero. One is fine. Two is acceptable. Three or more needs justification — consider passing an object instead.

Bad
```
createUser(name, email, age, role, isActive, avatarUrl)
```

Good
```
createUser(userParams)
```

### Prefer early return over deep nesting

Early returns make the happy path obvious and reduce cognitive load.

Bad
```
function getDiscount(user) {
  if (user != null) {
    if (user.isActive) {
      if (user.isPremium) {
        return 0.2
      }
    }
  }
  return 0
}
```

Good
```
function getDiscount(user) {
  if (user == null) return 0
  if (!user.isActive) return 0
  if (!user.isPremium) return 0
  return 0.2
}
```

### Don't use flag arguments

A boolean argument is a sign the function does more than one thing. Split it.

Bad
```
renderUser(user, isAdmin: true)
```

Good
```
renderAdminUser(user)
renderRegularUser(user)
```

### Avoid side effects

A function should do what its name says — nothing more. Hidden side effects are a major source of bugs.

Bad
```
// Name implies only validation, but it also modifies the user
function validateUser(user) {
  if (user.email == null) throw Error("missing email")
  user.lastValidatedAt = now()  // hidden side effect
}
```

Good
```
function validateUser(user) {
  if (user.email == null) throw Error("missing email")
}

function recordValidation(user) {
  user.lastValidatedAt = now()
}
```

---

## Comments

### Don't comment bad code — rewrite it

A comment explaining confusing code is a signal to clean up the code, not add documentation.

Bad
```
// check if user has been active in the last 30 days
if (user.lastActiveAt > now() - 2592000)
```

Good
```
THIRTY_DAYS_IN_SECONDS = 2592000

function isRecentlyActive(user) {
  return user.lastActiveAt > now() - THIRTY_DAYS_IN_SECONDS
}
```

### Explain **why**, not **what**

Code already says what it does. Comments should explain intent, trade-offs, or context that code cannot.

Bad
```
// increment i
i++

// get user by id
user = getUser(id)
```

Good
```
// Using polling instead of websockets here because the client
// does not support persistent connections in this environment.
startPolling(intervalMs: 5000)
```

### Don't leave commented-out code

Dead code creates noise and confusion. If it might be needed later, version control has it.

Bad
```
// user.sendEmail()
// user.notify()
user.archive()
```

Good
```
user.archive()
```

### Keep comments up to date

An outdated comment is worse than no comment — it actively misleads.

Bad
```
// Returns the first 10 users
function getUsers() {
  return User.all()  // was changed to return all, comment not updated
}
```

Good
```
function getAllUsers() {
  return User.all()
}
```

### Use TODO comments sparingly and consistently

When a TODO is necessary, make it actionable and trackable.

Good
```
// TODO: replace with proper pagination once API v2 is available
return User.all()
```

---

## Error Handling

### Never silently swallow exceptions

Silent failures hide bugs and make systems unpredictable. Always handle or explicitly re-raise.

Bad
```
try {
  processOrder(order)
} catch (e) {}
```

Good
```
try {
  processOrder(order)
} catch (e) {
  logger.error("Failed to process order", orderId: order.id, error: e)
  throw OrderProcessingException(cause: e)
}
```

### Don't use error codes — use exceptions

Error codes force every caller to check return values. Exceptions make the failure path explicit.

Bad
```
result = saveUser(user)
if (result == -1) {
  // handle error
}
```

Good
```
try {
  saveUser(user)
} catch (e: DatabaseException) {
  // handle error
}
```

### Use typed / specific exceptions

Catching a broad base exception hides what actually went wrong. Throw and catch the most specific type possible.

Bad
```
throw Exception("something went wrong")

catch (Exception e) { ... }
```

Good
```
throw RecordNotFoundException(userId: id)

catch (RecordNotFoundException e) { ... }
```

### Keep error handling separate from business logic

Mixing error handling with logic makes both harder to read.

Bad
```
function processOrder(order) {
  try {
    if (order.items.isEmpty) throw EmptyOrderException()
    total = order.items.sum((item) => item.price)
    if (total < 0) throw InvalidTotalException()
    saveOrder(order)
  } catch (e) {
    logger.error(e)
    notify(order.user)
  }
}
```

Good
```
function processOrder(order) {
  validateOrder(order)
  saveOrder(order)
}

// caller handles errors
try {
  processOrder(order)
} catch (e) {
  logger.error(e)
  notify(order.user)
}
```

### Fail fast

Validate inputs at the boundary — don't let bad data propagate deep into the system.

Bad
```
function createInvoice(order) {
  // ... 50 lines later ...
  if (order.userId == null) throw Error("missing user")
}
```

Good
```
function createInvoice(order) {
  if (order.userId == null) throw MissingUserException()
  // proceed with valid data
}
```

---

## AI Coding Instructions

When generating code in any language:
- Follow all rules defined in this document
- Use intention-revealing names — never abbreviations or single letters outside loops
- Keep functions small and focused on one responsibility
- Prefer early return over nested conditionals
- Never swallow exceptions silently
- Write comments to explain **why**, not **what**
- Remove all commented-out code
- Use typed/specific exceptions — avoid generic error types
- Fail fast: validate inputs at the entry point
