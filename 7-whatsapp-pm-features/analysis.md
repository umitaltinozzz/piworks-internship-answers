# Feature Analysis & Prioritization

---

## 1. Context

**WhatsApp, April 2026:**
- 3B+ MAU across 180+ countries
- Revenue model: WhatsApp Business Platform (B2B API), Click-to-WhatsApp Ads, WhatsApp Pay
- Core brand promise: end-to-end encryption — non-negotiable
- Strategic direction: Meta AI integration, Business platform expansion

**Key tensions:**
- Users increasingly distrust cloud-based AI with personal conversations
- Messaging behavior is global but translation tools break emotional context
- Business users manage scheduling and reservations outside the app

Both features address these tensions while sharing a single architectural decision: an on-device AI model.

---

## 2. Feature A — On-Device AI Assistant

### Problem

Users have two unresolved friction points that no current messaging app solves together:

**Privacy barrier to AI:** Most users would find value in AI-assisted messaging — drafting responses, summarizing long threads, managing schedules. The blocker is that they do not want their private conversations sent to a remote server. This is not a niche concern; it is the primary reason AI adoption in messaging has stalled for privacy-conscious users.

**Timezone-blind scheduling:** Sending a message at the right time for the recipient requires the sender to mentally convert timezones, check the clock, and remember to send later. There is no native tool in WhatsApp to handle this. Users in international personal and professional relationships deal with this daily.

### Solution

An on-device AI layer powered by Meta's Llama model running locally on the user's device — all processing happens on-device; no message content is transmitted to any server. Meta already owns this infrastructure (Llama, Meta AI, Manus acquisition), making deployment feasible without third-party model dependencies.

**Scheduled send with recipient timezone awareness:**
When composing a message, the user can tap "Send later." The interface shows the current local time for the recipient based on their registered or detected timezone, and suggests optimal send windows (e.g. morning in their timezone). The message is queued on-device and sent automatically at the specified time.

```
┌─────────────────────────────────────────┐
│  Send later                             │
│                                         │
│  Recipient's time: 02:14 AM (Tokyo)     │
│                                         │
│  Suggested windows:                     │
│  ○ 09:00 AM Tokyo  →  01:00 AM here    │
│  ○ 06:00 PM Tokyo  →  10:00 AM here    │
│                                         │
│  Or pick a time: [ 09 : 00 ] [ Tokyo ▾]│
│                                [Schedule]│
└─────────────────────────────────────────┘
```

**AI-assisted drafting:**
The user describes what they want to say in natural language; the on-device model generates a draft in the appropriate tone. Example: "Tell the group we're moving the meeting to Thursday, keep it short." The user reviews and sends.

**For business accounts — rules-based auto-reply:**
Business users define response rules with explicit boundaries: topics the AI may address, tone, and escalation triggers. The model handles routine queries (hours, pricing, availability) and flags anything outside the defined scope for human review. No customer conversation data leaves the device.

**Group summary:**
Available as a downstream use of the same model — no additional infrastructure required.

### Privacy Architecture

The on-device model (Gemma 4 or equivalent) runs entirely within the device's secure enclave. Message content is never transmitted for AI processing. The user's choice to enable the assistant is explicit and opt-in; the feature is disabled by default.

For older or low-RAM devices: a lightweight Llama variant with reduced capability, or the feature remains unavailable rather than falling back to cloud processing.

### Success Metrics

| Metric | Type |
|--------|------|
| Scheduled message feature adoption rate (D30) | Primary |
| Messages sent via scheduled send that fall within recipient's active hours | Quality |
| Business account retention at 6 months | Primary (Business segment) |
| Auto-reply escalation rate (should stay below 15%) | Guardrail |
| User-reported trust score for AI features | Guardrail |

### Risks

| Risk | Mitigation |
|------|------------|
| On-device model quality below user expectation | Conservative capability claims at launch; clear "AI draft — review before sending" label |
| Recipient timezone detection inaccurate | Default to manually entered timezone; pull from contact profile if available |
| Business auto-reply gives incorrect information | Hard rule boundaries set by business owner; out-of-scope queries always escalated to human |
| Low-end device exclusion | Lightweight model variant; explicit messaging about device requirements |

---

## 3. Feature B — Emotionally-Aware Translation

### Problem

WhatsApp is used across 180+ countries. Cross-language conversations are common — between diaspora families, international colleagues, and across cultures on social topics. Existing translation tools have two failures:

**Literal translation strips emotional content.** When someone writes in casual, expressive, or profanity-laden language, a literal translation produces a formal, emotionally flat output that misrepresents the speaker's tone and intent. Platforms like X (Twitter) have established a global baseline for this type of language — dense, register-aware, emotionally loaded — yet no translation tool handles it accurately. A Japanese user venting with informal profanity does not want their message translated as if they were filing a complaint. The cultural equivalent in the target language — not a sanitized substitute — is what preserves the actual communication.

**Switching apps creates friction.** Copy → switch to Google Translate → paste → switch back. This breaks conversation flow and is impractical for rapid exchanges.

### Solution

A **Translate** button rendered beneath each message, available on tap. Translation is not automatic — it respects the user's choice to engage with the original text.

```
┌──────────────────────────────────────┐
│  Yuki                                │
│  "マジでこれ最悪すぎるんだけど笑"   │
│                                      │
│  [Translate ▾]                       │
│                                      │
│  → "Ya bu gerçekten berbat いや    │
│     gülmekten öldüm"                 │
│     (casual / frustrated + amused)   │
└──────────────────────────────────────┘
```

The translation maps **register, slang, and emotional tone** to the closest cultural equivalent in the target language — not a dictionary-accurate rendering. A profanity translates to the corresponding profanity. A joke translates to a construction that reads as a joke. Formal language stays formal.

A small register label (casual / formal / frustrated / sarcastic) optionally appears below the translation to orient the reader where tone mapping was most active.

**For voice messages:** transcription followed by emotionally-aware translation in the same tap flow.

The model runs on-device using the same Meta Llama infrastructure established by Feature A. No text is transmitted externally.

### Why This Approach

Current alternatives fail in a specific way: they optimize for accuracy over fidelity. A precise translation of "amk" that produces "my friend" has destroyed the message. The user reading the translation has received different information than the one who read the original. Emotionally-aware translation treats register as content, not noise.

No major messaging platform currently offers this. Google Translate, DeepL, and iMessage translation all normalize emotional register. This is a defensible and technically achievable gap.

### Success Metrics

| Metric | Type |
|--------|------|
| Translate button usage rate in cross-language conversations | Primary |
| User rating of translation accuracy (in-app thumbs up/down) | Quality |
| Repeat translation usage per conversation thread | Engagement |
| Incorrect register mapping rate (human eval sample) | Guardrail |

### Risks

| Risk | Mitigation |
|------|------------|
| Profanity in translation causes user complaints | Opt-in register fidelity setting; default to "moderate" with option for "exact" |
| Model handles common language pairs well but fails on rare ones | Launch with top 20 language pairs; expand based on usage data |
| Users expect perfect translation, not tone-mapped translation | Clear framing: "translated with tone" not "exact translation" |

---

## 4. Prioritization Framework

### 4.1 RICE Score

| Criterion | Feature A | Feature B |
|-----------|-----------|-----------|
| **Reach** | ~3B — scheduled send alone is universally useful | ~800M — users in cross-language conversations |
| **Impact** (1–3) | 3.0 — foundational; enables multiple use cases | 2.5 — high within the affected segment |
| **Confidence** | 0.80 — on-device models are production-ready (Gemma 4) | 0.75 — translation models are mature; tone mapping adds complexity |
| **Effort** (person-months) | 90 — on-device model integration, scheduling system, business rules engine | 30 — runs on Feature A's model; incremental UI only |
| **RICE score** | (3B × 3.0 × 0.80) / 90 ≈ **~80M / pm** | (800M × 2.5 × 0.75) / 30 ≈ **~50M / pm** |

### 4.2 Strategic Filters

| Filter | Feature A | Feature B | Assessment |
|--------|-----------|-----------|------------|
| **Privacy differentiation** | Core architectural statement — on-device is the product decision | Inherits from A | A establishes the foundation |
| **Platform leverage** | Every future AI feature builds on this infrastructure | Dependent on A's model | A is the prerequisite |
| **Competitive pressure** | No major messaging app has a local AI layer — first-mover window | No competitor offers tone-aware translation natively | Both have open space; A's window may close faster |
| **Standalone value** | High — scheduled send alone justifies the feature | Reduced if A's model is not yet on-device | A must ship first |
| **Effort efficiency** | Higher absolute effort | Dramatically cheaper once A's model exists | A unlocks B at low cost |

### 4.3 Decision

**Feature A ships first.**

The on-device model is the architectural foundation. Feature B is dependent on it — without A's local model, Feature B either does not exist or requires a cloud fallback that contradicts the core privacy proposition. Once A is live, Feature B's incremental engineering cost is low: the model is already on the device, and the change is primarily a UI addition (translate button + register label).

Sequencing:

```
Feature A  ──[ 90 person-months ]──►  Launch
                                          │
Feature B  ──[ discovery + design ]───────►  [ 30 person-months ]──►  Launch
```

Feature B is not deferred because it lacks merit — it is deferred because it is structurally cheaper and more impactful after A is in place.

---

## 5. Anticipated Questions

**"Scheduled send based on recipient timezone — what if timezone is wrong?"**
Timezone is pulled from the contact's profile if available, or from their last known active time signal. The user can override it manually before scheduling. The suggestion is advisory, not automatic.

**"What stops the on-device model from being too slow or too large?"**
Gemma 4 and similar models are designed for mobile deployment. Feature capability is tied to device tier — higher-end devices get full capability, lower-end devices get a reduced feature set. No cloud fallback is offered; the privacy guarantee must hold.

**"Why not partner with Google Translate for the translation feature?"**
A partnership routes message text through an external API, breaking the on-device privacy model. The translation must run locally to be consistent with the product's core proposition. Additionally, Google Translate and DeepL normalize emotional register — they would not preserve the tone that makes this feature differentiated. Meta's Llama, fine-tuned on register-aware data from platforms like X, is the right tool for this.

**"How do you measure success for emotionally-aware translation at 90 days?"**
Translate button used in ≥ 20% of cross-language conversation threads where it is shown; thumbs-up rate on translation output ≥ 70%; repeat usage within same thread ≥ 40%.

**"What if the business auto-reply gives a wrong answer to a customer?"**
The business owner defines explicit topic boundaries during setup. Any query outside those boundaries is flagged and forwarded to the business owner rather than answered by the model. The model does not speculate or respond outside its defined scope.
