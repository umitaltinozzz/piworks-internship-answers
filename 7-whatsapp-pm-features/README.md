# WhatsApp — Two New Features & Prioritization

**Decision: Feature A first — On-Device AI Assistant**

---

## Proposed Features

### Feature A — On-Device AI Assistant
A privacy-first AI layer powered by Meta's Llama model running entirely on the user's phone — no conversation data ever leaves the device. Meta already owns this infrastructure (Llama, Meta AI, Manus acquisition), making this a natural extension of existing assets. Enables: scheduled messages sent at the right time in the recipient's local timezone, AI-assisted message drafting, group summaries, and for business accounts, auto-replies within user-defined rules and reservation management.

### Feature B — Emotionally-Aware Translation
A per-message translate button that renders the cultural and emotional tone of the original, not just its literal meaning. Slang, profanity, and register are mapped to their target-language equivalents rather than neutralized. Runs on the same on-device model as Feature A — no additional server dependency.

---

## Prioritization

Framework: RICE score + 4 strategic filters.

| Factor | Feature A | Feature B |
|--------|-----------|-----------|
| Reach | ~3B (all users benefit from scheduled send alone) | ~800M (cross-language conversations) |
| Impact (1–3) | 3.0 — foundational platform shift | 2.5 — high for affected segment |
| Confidence | 0.80 — Meta Llama infrastructure already exists | 0.75 — translation models well-established |
| Effort (person-months) | 90 | 30 (runs on Feature A's model) |
| **RICE score** | **~80M / person-month** | **~50M / person-month** |

| Strategic Filter | Winner |
|-----------------|--------|
| Privacy differentiation | A (core architectural decision) |
| Platform leverage (future features built on top) | A |
| Competitive pressure | A (no major app has local AI) |
| Standalone value without Feature A | B loses dependency advantage |

**Feature A is built first** — it establishes the on-device model infrastructure that Feature B runs on. Once A is live, Feature B's engineering effort drops significantly.

---

## Repository Structure

| File | Contents |
|------|----------|
| `problem.md` | Original problem statement |
| `analysis.md` | Full feature analysis, RICE, strategic filters, risk mitigation |
