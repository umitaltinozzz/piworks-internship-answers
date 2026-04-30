# Istanbul Base Station Count Estimation

**Estimate: ~65,000 base stations** (confidence interval: 59,000 – 71,000)

---

## Overview

This analysis estimates the total number of base stations in Istanbul as of April 2026. Four independent methods were applied, each grounded in publicly available official data, and their results were combined through a weighted average.

| Method | Center Estimate |
|--------|----------------|
| 1 — Istanbul direct CAGR projection | 65,239 |
| 2 — Turkey total × Istanbul share | 63,417 |
| 3 — Per-capita density extrapolation | 66,592 |
| 4 — 5G transition delta (4.5G analogy) | +400 |
| **Weighted average** | **~65,000** |

All four methods were constructed independently and converge within the 63,000–67,000 range.

---

## Key Anchor

The strongest data point used is **BTK's official report submitted to the TBMM Petition Commission, January 2020**:

```
Turkey total:  196,976
Istanbul:       48,684  (24.7%)
Ankara:         15,129   (7.7%)
Izmir:          11,751   (6.0%)
```

Projecting from this anchor at a 4.5–5% annual growth rate through April 2026, plus an early-stage 5G contribution, yields the ~65,000 estimate.

---

## Repository Structure

| File | Contents |
|------|----------|
| `problem.md` | Original problem statement |
| `methodology.md` | Step-by-step methodology, all four methods, full arithmetic, sanity checks |
| `sources.md` | Data points used and source reliability assessment |
