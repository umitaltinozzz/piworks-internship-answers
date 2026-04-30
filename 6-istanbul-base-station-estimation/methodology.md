# Methodology

**Objective:** Estimate the total number of base stations in Istanbul as of April 2026.  
**Approach:** Four independent estimation methods, each grounded in official anchor data, combined through a weighted average.

---

## Step 1: Establish Anchor Points

The strongest anchor is the **January 2020 BTK-TBMM data** from BTK's official report to the TBMM Petition Commission:

```
Turkey total:  196,976
Istanbul:       48,684  (24.7%)
Ankara:         15,129   (7.7%)
Izmir:          11,751   (6.0%)
```

The three cities together account for 38.4% of Turkey's total, confirming the disproportionate density in metropolitan areas.

A secondary anchor is **December 2015 — Istanbul: 27,110** (Minister Yıldırım's parliamentary response, reported by press). These two data points form the basis for the 2015–2020 CAGR calculation.

---

## Step 2: Growth Rate Analysis

### Istanbul CAGR (2015 → 2020)

```
start = 27,110
end   = 48,684
years = 5

ratio = 48,684 / 27,110 = 1.79579
CAGR  = exp(ln(1.79579) / 5) − 1
      = exp(0.11708) − 1
      = 12.42% per year
```

### Turkey CAGR (2016 → 2020)

```
start = 126,776
end   = 196,976
years = 4

CAGR = exp(ln(1.55376) / 4) − 1 = 11.65% per year
```

### Growth Rate Deceleration

| Period | Turkey CAGR | Driver |
|--------|-------------|--------|
| 2016–2019 | 14.0% | Intensive 4.5G rollout phase |
| 2019–2020 | 4.9% | Saturation beginning |
| 2020–2026 | ~4–5% | Capacity expansion and rural coverage |

The high-intensity phase of 4.5G deployment concluded around 2016–2018. Subsequent growth is driven primarily by capacity augmentation and rural coverage extension. BTK's consumer documentation states explicitly that most urban stations are installed for capacity rather than coverage purposes — this explains why Istanbul's share of base stations (24.7%) significantly exceeds its population share (18.5%), yielding a density multiplier of 1.34.

**Selected rate for 2020–2026:**
- Istanbul: 4.5% CAGR (slightly above national average due to sustained capacity pressure)
- Turkey: 4.5% CAGR

---

## Step 3: Four Independent Methods

### Method 1 — Istanbul Direct CAGR Projection

```
2020 anchor = 48,684
years = 6 (2020 → 2026)

Scenario    | r      | (1+r)^6 | 2026 Istanbul
------------|--------|---------|---------------
Conservative| 3.5%   | 1.2293  | 59,833
Central     | 5.0%   | 1.3401  | 65,239
Moderate    | 7.0%   | 1.5007  | 73,056
```

**Central estimate: 65,239**

### Method 2 — Turkey Total × Istanbul Share

**Turkey 2026 projection:**

```
2020 base = 196,976, years = 6

Scenario    | r    | Multiplier | 2026 Turkey
------------|------|------------|-------------
Conservative| 3.5% | 1.2293     | 242,064
Central     | 4.5% | 1.3023     | 256,542
Moderate    | 5.0% | 1.3401     | 263,978
```

**× Istanbul share (24.72%):**

```
Conservative → 242,064 × 0.2472 = 59,838
Central      → 256,542 × 0.2472 = 63,417
Moderate     → 263,978 × 0.2472 = 65,255
```

**Central estimate: 63,417**

### Method 3 — Per-Capita Density Extrapolation

**Historical density:**

```
2015: 27,110 / 14.657M = 1,849 per million
2020: 48,684 / 15.462M = 3,149 per million
Per-capita CAGR (2015→2020) = 11.23% per year
```

**2026 density projection (saturation → 5% CAGR):**

```
Scenario    | r   | 2026 per million
------------|-----|------------------
Conservative| 4%  | 3,985
Central     | 5%  | 4,220
Moderate    | 7%  | 4,725
```

**Istanbul 2026 population estimate:**

```
2020→2024: 15,462,452 → 15,701,602 (annual growth ≈ 0.38%)
2024→2026: 15,701,602 × 1.0038² ≈ 15,821,000
```

**× per-million density:**

```
Conservative → 15.78M × 3,985 = 62,883
Central      → 15.78M × 4,220 = 66,592
Moderate     → 15.78M × 4,725 = 74,561
```

**Central estimate: 66,592**

### Method 4 — 5G Delta (4.5G Analogy)

**4.5G benchmark (2016):**

```
Turkey base before 4.5G (2G+3G): 118,724
New 4.5G stations (first 6 months): 8,052
Rate: 8,052 / 118,724 = 6.78% over 6 months
```

**Adaptation to 5G:**

Fewer new physical sites are expected under 5G because early deployment is dominated by co-siting — adding equipment to existing towers. This is partially offset by the short range of 3.5 GHz, which requires a high density of small cells. The net effect is a deployment rate close to the 4.5G benchmark.

5G commercial launch: 1 April 2026. As of the estimation date (30 April 2026), 29 days have elapsed — 29 of 180 days = 16.1% of the first six-month window.

```
Turkey base (Apr 2026) ≈ 250,000
Projected 6-month 5G additions (~6.5%): 16,250
29-day linear share (×16.1%): 2,616
Istanbul share (5G priority ~35%): 916

Adjusted for co-siting dominance (slow ramp-up): 150–600
```

**Method 4 contribution: +400 (point estimate)**

---

## Step 4: Synthesis

```
Method 1 center: 65,239
Method 2 center: 63,417
Method 3 center: 66,592
Method 4 delta:    +400

Weighted average (M1×0.35 + M2×0.30 + M3×0.25 + M4):
  65,239 × 0.35 = 22,834
  63,417 × 0.30 = 19,025
  66,592 × 0.25 = 16,648
  Sum (weight 0.90): 58,507 / 0.90 = 65,008
  + M4 delta: 65,008 + 400 = 65,408
  Rounded: ~65,000
```

**Confidence intervals:**

```
80% CI: 58,000 – 75,000
66% CI: 63,000 – 70,000
Central: 65,000
```

---

## Step 5: Sanity Checks

### Check 1 — Per-Capita Density Trend

| Year | Istanbul stations | Population (M) | Stations / million |
|------|------------------|----------------|--------------------|
| 2015 | 27,110 | 14.66 | 1,849 |
| 2020 | 48,684 | 15.46 | 3,149 |
| 2026 | ~65,000 | ~15.80 | ~4,114 |

The annual increment in density is declining (260 → 161 new stations per million per year), consistent with the conclusion of the intensive 4.5G rollout phase. ✓

### Check 2 — Istanbul's Share of Turkey Total

```
2020: 24.7%
2026: 65,000 / 265,000 = 24.5%  (26% with 5G urban weighting)
```

A stable or marginally increasing share is expected given Istanbul's sustained capacity pressure relative to the national average. ✓

### Check 3 — Technology Transition Comparison

```
4.5G first 5 years (2016→2020) Istanbul: +21,574 new stations
Pre-5G organic + 5G first wave (2020→2026): +16,316 new stations
```

The 2020–2026 increment is lower than the 4.5G period, which is expected: 5G early deployment adds equipment to existing infrastructure rather than building new physical sites at the same rate. ✓

### Check 4 — Technology Transition Rate

```
4.5G: 8,052 / 118,724 = 6.78% (first 6 months)
5G:  ~15,600 / 240,000 = 6.50% (projected full 6-month rate)
```

The rates are closely aligned. The reduction in new physical sites under 5G (co-siting) is offset by the increased small-cell density requirements of 3.5 GHz spectrum. ✓

### Check 5 — International Comparison

| City | Population | Stations per million |
|------|------------|----------------------|
| London | ~9M | ~3,500–4,400 |
| Seoul | ~10M | ~5,000+ |
| Istanbul 2026 (estimated) | ~15.8M | ~4,114 |

Istanbul's estimated density falls between two comparable high-density metropolitan benchmarks. ✓

---

## Key Uncertainties

1. **Definition of "base station"** — physical site vs. operator-antenna unit; the difference can be a factor of 3–4×.
2. **Absence of province-level BTK data for 2021–2025** — filling this gap would significantly narrow the confidence interval.
3. **5G deployment pace** — operator investment commitments from the spectrum auction are not yet publicly disclosed.
4. **Co-siting ratio** — the proportion of 5G deployment that reuses existing towers without registering as new sites is uncertain.
