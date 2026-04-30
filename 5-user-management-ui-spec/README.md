# User Management Screen — UI Specification

> **Audience:** Software developers (front-end and back-end) who will implement this screen.
> **Author:** Ümit Altınöz — Product Design Intern application, P.I. Works
> **Date:** April 2026
> **Source material:** One mockup screenshot + a one-paragraph brief.

---

## 0. About this document

I prepared this as a Product Design Intern submission. I had only the mockup and a short brief — no personas, no user research, no design system to reference. So I'm trying to make my reasoning visible: most decisions are followed by a short *"Why"* line, and anything I had to assume is flagged with `[Assumption]`. Open questions for the product team are collected at the end rather than guessed at.

If a section reads "this is what I'd ask before building" — that's intentional. I'd rather flag a gap than invent a fake answer.

---

## 1. Who this screen is for

**Primary user — IT / system administrator at a B2B customer of P.I. Works.**

`[Assumption]` Based on the screen pattern (small admin panel, role-based access, no avatars, `@piworks.net`-style email), I assume the typical user:

- Is an internal IT admin or support engineer.
- Visits this screen *occasionally* — onboarding a colleague, rotating roles, revoking access for a leaver.
- Manages between **5 and ~200 users**, not thousands.
- Cares more about *correctness* (right person, right role) than *speed* (no need for bulk ops yet).

**Why this matters.** A screen designed for "occasional, careful" usage looks different from one for "high-volume daily ops." It's why I prioritised clarity, confirmations, and forgiveness over keyboard speed and density.

---

## 2. Goals & non-goals

**Goals**
- See at a glance who has access to the system.
- Make adding or editing a user a single, focused task — no context switching.
- Prevent admins from accidentally locking themselves or others out.
- Make role assignment legible (admins shouldn't have to memorise what each role can do).

**Non-goals (Phase 1)**
- Bulk operations, password reset flow, audit log view, SSO linkage UI, CSV import/export, hard delete (users are disabled, not deleted).

---

## 3. Layout & rationale

Two-pane layout: list on the left, detail/form on the right.

```
┌──────────────────────────────────────────────────────────┐
│ [+ New User]  [☑ Hide Disabled]              [Save User] │ ← Toolbar
├────────────────────────────┬─────────────────────────────┤
│                            │                             │
│   USER LIST                │   DETAIL / FORM             │
│   (filterable, sortable)   │   (read or edit)            │
│   ~60% width               │   ~40% width                │
│                            │                             │
└────────────────────────────┴─────────────────────────────┘
```

**Why two-pane?** The admin's main loop is "find a user → change something." A modal or separate page would force them between context (list) and action (form). Side-by-side keeps both visible and reduces mental load.

**Responsive fallback** `[Assumption]` — desktop is the primary use case.
- ≥ 1200 px: side-by-side as above.
- 768–1199 px: list on top, form below; clicking a row scrolls form into view.
- < 768 px: list full-width; form opens as a slide-in drawer.

---

## 4. What the user sees on first load

1. **Toolbar** — `+ New User` (primary, left), `Hide Disabled` filter (middle), `Save User` (right, disabled until something is editable).
2. **List** — populated with active users, sorted by ID ascending. A skeleton loader shows for the first ~500 ms so the page never feels blank.
3. **Right panel** — empty state with text: *"Select a user from the list, or click '+ New User' to create one."*

**Why is `Hide Disabled` checked by default?** Most of the time the admin wants to see "who currently has access," not "everyone who has ever existed." Hiding disabled users by default reduces noise and is one click to reveal.

**Empty list state** (no rows match the filter):
> *"No active users. Uncheck 'Hide Disabled User' to see all, or click '+ New User' to add one."*

(I avoided a generic "No data" because it doesn't help the admin decide what to do next.)

---

## 5. Toolbar

### 5.1 `+ New User`

Always enabled. On click: clears any selected row, opens a blank form on the right titled "New User," focuses the `Username` input. If a form has unsaved changes, show a confirmation: *"You have unsaved changes. Discard them?"* — `Discard` / `Keep editing`.

### 5.2 `Hide Disabled User` checkbox

Checked by default. Toggling re-fetches the list. When unchecked, disabled rows are de-emphasised (lighter text + a small "disabled" pill on the `Enabled` column).

**Why a pill, not just lighter text?** Colour alone fails for colourblind users, and "disabled" is a state that drives admin decisions. A short text label removes ambiguity.

The user's preference should persist across sessions.

### 5.3 `Save User` button

| Condition | State |
|---|---|
| No form open, or form is unchanged | Disabled |
| Form is open + dirty + valid | Enabled |
| Submitting | Spinner inside button; form fields disabled |
| Saved successfully | Toast *"User saved."*; row in list refreshes; **form stays open showing the saved user** |
| Server validation error | Inline message next to the offending field; panel stays open |
| Other error | Toast *"Couldn't save user. Please try again."* with `Retry` |

**Why keep the panel open after save?** Admins often realise they wanted one more change ("ah, also disable them"). Closing would force them to re-find the row.

---

## 6. User list

### 6.1 Columns

| Column | Sort | Filter |
|---|:---:|---|
| **ID** | yes | exact match |
| **User Name** | yes | contains |
| **Email** | yes | contains |
| **Enabled** | yes | All / True / False |

Each header shows a sort arrow when active and a funnel icon for filters. **An active filter shows a filled funnel** — small but important, so the admin doesn't get confused why the list looks "incomplete."

### 6.2 Row interactions

- **Click anywhere on a row:** select it, load that user into the form on the right.
- **Hover:** light background tint (affordance — "this is clickable").
- **Selected:** stronger tint plus a left-edge accent bar.
- **Keyboard:** `↑/↓` move selection, `Enter` opens it in the form, `Delete` triggers a *disable confirmation* (never a hard delete).

`[Assumption]` Server-side pagination, default 25 per page, options 50 / 100. Page size remembered for the session.

### 6.3 List states

| State | Display |
|---|---|
| Loading first page | ~6 skeleton rows |
| Loading next page | Subtle spinner over the grid |
| Empty (filtered) | See § 4 |
| Error | Inline error card with `Retry` |

---

## 7. Detail / form panel

Header changes by mode: **"New User"** or **"Edit User: {Username}"**.

### 7.1 Fields

| Field | Required | Validation |
|---|:---:|---|
| Username | yes | 3–32 chars, lowercase letters, digits, `.`, `_`. Must be unique. |
| Display Name | yes | 1–64 chars, free-form. |
| Phone | no | Soft E.164 check. `[Open question — see § 11]` |
| Email | yes | Valid email format + must be unique. |
| User Roles | yes (≥1) | Multi-select from `Guest`, `Admin`, `SuperAdmin`. |
| Enabled | — | Checkbox. Defaults to checked for new users. |

### 7.2 Roles dropdown

Multi-select with chips. Each chip has an `×` to remove. **A small info icon next to each option explains what the role can do** — the admin shouldn't have to memorise the permission matrix.

```
Select user roles…
┌──────────────────────────────────────┐
│  Guest       ⓘ  Read-only access     │
│  Admin       ⓘ  Manage users & data  │
│  SuperAdmin  ⓘ  Full system access   │
└──────────────────────────────────────┘
```

**Permission rule.** An `Admin` cannot grant `SuperAdmin`. The option is **shown but disabled**, with a tooltip: *"Only SuperAdmins can grant SuperAdmin."*

**Why show a disabled option instead of hiding it?** Hiding hides knowledge — the admin won't even learn that role exists. Showing-but-disabling teaches the system without giving away power.

**Self-lockout protection.** A signed-in user cannot remove their own `SuperAdmin` role or disable themselves. The relevant controls are greyed out with a tooltip: *"You can't change your own access."*

### 7.3 Validation & microcopy

Validate **on blur** for individual fields, and again **on submit** as a final pass.

| Case | Message |
|---|---|
| Empty required | "This field is required." |
| Username format | "Use 3–32 lowercase letters, digits, dots, or underscores." |
| Username already taken | "That username is already in use." |
| Invalid email | "Enter a valid email address." |
| Email already taken | "That email is already registered." |
| No role selected | "Select at least one role." |

**Microcopy principles I followed:**
- Plain language ("Use..." not "Must conform to...").
- Never blame the user.
- Inline (under the field), not a global error banner — admins should know exactly which input to fix.

### 7.4 Disabling a user

Toggling `Enabled` from true → false on an existing user opens a confirmation:

> *"Disable user `{username}`? They will be signed out and unable to log in until re-enabled."*

`Disable` / `Cancel`.

**Why a confirmation here, but not on every save?** Disabling has an immediate, externally visible consequence (the user is kicked out). Most other edits don't. Friction proportional to consequence is a basic UX principle.

---

## 8. Key user flows

### Flow A — Create a new user

```
[Page loads]
      │
      ▼
[Click "+ New User"]
      │
      ▼
[Empty form opens, focus on Username]
      │
      ▼
[Admin types Username, Display Name, Email; picks Role(s)]
      │
      ▼
[On blur of each field → inline validation]
      │
   ┌──┴───────────────────────┐
   ▼                          ▼
[All valid]              [Some invalid]
[Save User enables]      [Inline errors guide fix]
   │
   ▼
[Click Save → spinner → toast "User saved."]
      │
      ▼
[Row appears in list, form stays open showing the new user]
```

### Flow B — Disable an existing user

```
[Find user (filter or scroll) → click row]
            │
            ▼
[Form loads on right, "Edit User: {name}"]
            │
            ▼
[Uncheck "Enabled"]
            │
            ▼
[Confirmation modal: "Disable {user}? They will be signed out…"]
            │
        ┌───┴────────────┐
        ▼                ▼
    [Confirm]         [Cancel]
        │                │
        ▼                ▼
[Saved, row dimmed]  [No change, checkbox returns to checked]
```

### Flow C — Admin tries to disable themselves

```
[Admin selects their own row]
        │
        ▼
[Tries to uncheck "Enabled"]
        │
        ▼
[Checkbox is greyed out + tooltip explains why]
        │
        ▼
[No state change, no scary error toast]
```

---

## 9. Accessibility (from a UX angle)

I'm not prescribing ARIA attributes — those belong with the front-end implementer — but I'd ask the team to make sure:

- Every action is reachable by keyboard alone, including row selection, filter popovers, and chip removal.
- Focus indicators are visible (not the browser's near-invisible default).
- `Enabled` status is communicated by **colour + text + position**, not colour alone.
- Field labels stay visible above the input (placeholders are not labels — they vanish on type).
- Validation errors are associated with their input so a screen reader user reads the field *and* the error together.
- Modals trap focus until dismissed.

Contrast values and exact ARIA roles should follow the team's existing design system, which I did not have access to.

---

## 10. Edge cases I would want to test

- Very long display names (~80+ chars) — clean truncation + tooltip showing the full value?
- Network drop mid-save — does the spinner time out with a clear retry path?
- Filter narrows results to zero — distinct empty state from "no users at all"? (Yes: *"No users match your filters. Clear filters to see all."*)
- Admin walks away for 30 min — does Save handle a silently-expired session without losing form data?
- Two admins editing the same user simultaneously — out of scope for v1, but worth flagging.

---

## 11. Open questions for the product team

These are things I'd want to confirm before build, rather than guess at:

1. **Password / first login.** How does a newly-created user get credentials — invite email + set-password link, or admin sets a temporary password here? The mockup has no password field, so I assumed the former; it changes the form if not.
2. **Phone strictness.** Soft warning or hard E.164 block?
3. **`SuperAdmin` cap.** Should the count be capped (e.g., max 3) for safety?
4. **Email domain restriction.** Only `@piworks.net`, or open?
5. **Audit log integration.** Out of scope here, but is there an existing system to plug into later?

---

## 12. Inspirations

For interaction patterns I drew on:

- **Notion's member settings** — for the side-pane edit pattern.
- **Linear's role chips** — for multi-select with inline permission hints.
- **GitHub's People page** — for "disable, not delete" and confirmation copy.

I didn't copy any specific UI; these were references for what feels familiar to a B2B SaaS admin.

---

## 13. Out of scope (Phase 2 candidates)

Bulk actions; password reset trigger; per-user audit log; SSO / SAML linkage; CSV import/export; avatar upload.

---

*End of document. Happy to walk through any part of this in person — and just as happy to be told a decision should go the other way. This is a v1 draft and I expect to iterate.*
