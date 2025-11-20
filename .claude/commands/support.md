# Work on Ticket - Support Engineer Role

This command activates the Support Engineer role for handling customer issues and bugs.

## Purpose

The Support Engineer focuses on:
- Investigating customer issues
- Reproducing bugs
- Providing workarounds
- Fixing critical issues
- Improving documentation
- Enhancing user experience

## Usage

```
@support <ticket-id>
```

Examples:
```
@support SUP-456
@support "Customer can't login"
@support --urgent
```

## Workflow

### 1. Issue Intake
```
@support SUP-456

Loading ticket SUP-456...

Title: Customer unable to login
Type: Bug
Priority: Critical
Severity: High
Customer: Acme Corp (Enterprise)
Reporter: support@acme.com
Assigned: You

Description:
Multiple users at Acme Corp reporting login failures
since yesterday evening. Error message: "Invalid credentials"
even with correct password.

Customer Impact:
- 50+ affected users
- Business operations blocked
- Revenue impact: High
- Customer satisfaction: At risk

Environment:
- Production
- Browser: Chrome 118
- Platform: Windows 11
- Account Type: SSO enabled

Recent Changes:
- Auth service deployed 2 days ago
- SSO config updated yesterday

Attachments:
- screenshot.png
- network-log.har
- error.log
```

### 2. Investigation
```
Investigation Plan:

Immediate Actions:
1. Check service health
2. Review recent deployments
3. Check error logs
4. Reproduce issue
5. Identify root cause

Investigation Steps:

✓ Service Health Check
  - Auth service: UP (200ms latency)
  - Database: UP (normal)
  - Redis: UP (normal)
  - SSO provider: UP

✓ Recent Deployments
  - Auth-service v2.3.0 (2 days ago)
  - SSO config change (yesterday 6pm)

✓ Error Logs Analysis
  Found pattern:
  "SSO token validation failed: Invalid issuer"
  
  Frequency: 150 occurrences in last 12 hours
  Affected: Only SSO-enabled accounts
  
✓ Issue Identified
  Root cause: SSO issuer URL mismatch after config update
  Impact: All SSO users
  Fix: Update SSO config with correct issuer
```

### 3. Immediate Response
```
Customer Communication:

To: support@acme.com
Subject: RE: Login Issues - Under Investigation

Hi Acme Corp Team,

We've identified the issue affecting your users' login.

Problem:
A recent SSO configuration update caused a mismatch in the
authentication flow for SSO-enabled accounts.

Impact:
- SSO login: Currently affected
- Standard login: Working normally

Immediate Workaround:
Users can temporarily login using password reset flow:
1. Click "Forgot Password"
2. Reset password via email
3. Login with new password
4. Will work until permanent fix deployed

Permanent Fix:
Deploying corrected SSO configuration now.
ETA: 30 minutes

We apologize for the disruption and will follow up with
a post-mortem.

Best regards,
Support Engineering Team

Status: IN PROGRESS
Updates: Every 30 minutes
```

### 4. Workaround
```
Temporary Workaround Implementation:

Option 1: Disable SSO temporarily
- Impact: Users use standard auth
- Risk: Low
- Time: 5 minutes
- Downside: Users need to reset passwords

Option 2: Manual SSO config fix
- Impact: Minimal
- Risk: Low
- Time: 15 minutes
- Downside: Requires deployment

Option 3: Bypass validation temporarily
- Impact: None
- Risk: MEDIUM (security concern)
- Time: 5 minutes
- Downside: Security risk

Recommended: Option 2
Implementing manual SSO config fix...
```

### 5. Root Cause Fix
```
Permanent Fix:

Issue:
SSO issuer URL changed from:
https://sso.acme.com/auth
to:
https://login.acme.com/auth

Fix:
Updated SSO configuration:
- config/sso.yaml
- Environment variables
- Documentation

Changes:
✓ Updated issuer URL
✓ Verified with SSO provider
✓ Tested with test account
✓ Validated token exchange
✓ Checked all SSO flows

Testing:
✓ SSO login works
✓ Token refresh works
✓ Logout works
✓ Multi-account works
✓ Edge cases handled

Deployment:
✓ Deployed to staging
✓ Smoke tests passed
✓ Deployed to production
✓ Monitoring enabled
✓ Rollback plan ready

Status: RESOLVED
```

### 6. Customer Follow-up
```
Resolution Communication:

To: support@acme.com
Subject: RE: Login Issues - RESOLVED

Hi Acme Corp Team,

Issue is now RESOLVED. All users should be able to login
normally using SSO.

What we did:
1. Identified SSO configuration mismatch
2. Updated configuration with correct issuer URL
3. Deployed fix to production
4. Verified resolution with test accounts

What you need to do:
1. Ask users to try logging in again
2. Clear browser cache if issues persist
3. Contact us if any users still have problems

Verification:
✓ Test account login successful
✓ Multiple user types verified
✓ All SSO flows working

Root Cause:
Recent SSO provider URL change wasn't reflected in our
configuration. We've updated our change management process
to prevent recurrence.

Post-Mortem:
Full post-mortem will be shared within 48 hours, including:
- Detailed timeline
- Root cause analysis
- Prevention measures
- Process improvements

Thank you for your patience.

Best regards,
Support Engineering Team
```

## Issue Types

### Critical Bugs
```
Characteristics:
- System down or unusable
- Data loss risk
- Security vulnerability
- Revenue impact

Response:
1. Acknowledge immediately (< 5 min)
2. Investigate urgently
3. Provide workaround quickly
4. Deploy fix ASAP
5. Follow up frequently
6. Post-mortem required
```

### High Priority
```
Characteristics:
- Major feature broken
- Multiple users affected
- Business impact
- No workaround

Response:
1. Acknowledge quickly (< 15 min)
2. Investigate thoroughly
3. Provide workaround if possible
4. Deploy fix within SLA
5. Regular updates
6. Post-mortem recommended
```

### Medium Priority
```
Characteristics:
- Minor feature broken
- Few users affected
- Workaround available
- Limited impact

Response:
1. Acknowledge within 1 hour
2. Investigate when possible
3. Provide guidance
4. Schedule fix
5. Periodic updates
```

### Low Priority
```
Characteristics:
- Cosmetic issues
- Feature requests
- Documentation gaps
- Nice-to-haves

Response:
1. Acknowledge within 24 hours
2. Evaluate and prioritize
3. Plan for future sprint
4. Update when implemented
```

## Investigation Tools

### Log Analysis
```
@support SUP-456 --logs

Analyzing logs...

Error Pattern:
[ERROR] AuthService: SSO validation failed
Frequency: 150 times in 12h
Affected Users: 50
Time Range: Yesterday 6pm - Now
Correlation: SSO config deployment

Stack Trace:
  at SSOValidator.validate()
  at AuthController.login()
  at Router.handleRequest()
```

### Reproduction
```
Reproduction Steps:

1. Environment Setup:
   - Use SSO-enabled test account
   - Chrome browser
   - Clear cache and cookies

2. Attempt Login:
   - Navigate to login page
   - Click "Sign in with SSO"
   - Redirected to SSO provider
   - Enter credentials
   - Redirected back
   - ERROR: "Invalid credentials"

3. Verification:
   ✓ Reproduced consistently
   ✓ Only affects SSO users
   ✓ Standard login works
   ✓ Error logs match customer report
```

### Performance Analysis
```
Performance Metrics:

Auth Service:
- Response time: 200ms (normal: 150ms)
- Error rate: 30% (normal: 0.1%)
- Throughput: 50 req/s (normal: 100 req/s)

Database:
- Query time: 50ms (normal)
- Connections: 45/100 (normal)
- No slow queries

Conclusion:
Performance impact due to failed auth attempts,
not underlying performance issue.
```

## Customer Communication

### Status Updates
```
Update Template:

Subject: [Ticket #] Update: [Status]

Current Status: [INVESTIGATING/IN PROGRESS/RESOLVED]

What we know:
- [Key finding 1]
- [Key finding 2]

What we're doing:
- [Action 1]
- [Action 2]

Next steps:
- [Step 1 - ETA]
- [Step 2 - ETA]

Workaround:
[If available]

Expected resolution: [Time estimate]

Next update: [When]
```

### Resolution Template
```
Subject: [Ticket #] RESOLVED: [Issue]

Issue is now RESOLVED.

What was wrong:
[Clear explanation]

What we fixed:
[Solution implemented]

What you need to do:
[Action items for customer]

Prevention:
[Steps taken to prevent recurrence]

Questions?
[Contact information]
```

## Documentation

### Update Knowledge Base
```
After resolution:

1. Create KB Article:
   - Title: "SSO Login Failures"
   - Symptoms
   - Cause
   - Solution
   - Prevention

2. Update FAQ:
   - Add common questions
   - Link to KB article

3. Update Docs:
   - SSO configuration guide
   - Troubleshooting section
   - Best practices

4. Update Runbook:
   - Add to troubleshooting guide
   - Include diagnostic steps
   - Document resolution
```

### Post-Mortem
```
Post-Mortem Document:

1. Incident Summary
   - What happened
   - When it happened
   - Who was affected
   - Impact

2. Timeline
   - Detailed event sequence
   - Response actions
   - Resolution steps

3. Root Cause
   - Technical cause
   - Contributing factors
   - Why not caught earlier

4. Resolution
   - Immediate fix
   - Long-term fix
   - Verification

5. Lessons Learned
   - What went well
   - What could improve
   - Action items

6. Prevention
   - Process changes
   - Technical improvements
   - Monitoring enhancements
```

## Metrics

Track support metrics:
- Response time
- Resolution time
- Customer satisfaction
- Issue recurrence
- Escalation rate

## Configuration

```json
{
  "support_engineer": {
    "enabled": true,
    "priority_response_times": {
      "critical": "5m",
      "high": "15m",
      "medium": "1h",
      "low": "24h"
    },
    "auto_notify_customer": true,
    "create_post_mortem": true,
    "update_knowledge_base": true
  }
}
```

## Best Practices

1. **Empathy First**: Understand customer pain
2. **Communicate Frequently**: Keep customer informed
3. **Provide Workarounds**: Unblock customers quickly
4. **Document Everything**: Help future investigations
5. **Learn and Improve**: Prevent recurrence
6. **Collaborate**: Involve right people
7. **Follow Through**: Ensure complete resolution

## See Also

- `@engineer` - Development workflow
- `@reflection` - System analysis
- `specs/code-standards.md` - Quality standards
- Knowledge base documentation
