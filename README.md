# Tire & Road Interaction Modeling

Independent vehicle dynamics project modeling how a car's tires generate grip, lose grip, and respond to steering and braking inputs — using CarSim for simulation and MATLAB for analysis.

**Vehicle:** D-Class Sedan (CarSim 2020), held constant across all tests for methodological consistency
**Tools:** CarSim (simulation) · MATLAB (analysis and plotting)
**Scope:** 3 standardized test maneuvers → 10 analysis deliverables

---

## Key Findings

**1. The car's cornering limit is rear-limited, not front-limited.**
A dedicated steering-angle sweep at fixed speed showed the front tires' lateral force peaking and saturating (~2150 N near 4° slip angle) — a textbook grip ceiling. The rear tires, however, showed no saturation at all across the same sweep, still climbing in force with no sign of a peak. Vehicle-level lateral acceleration kept rising through 0.80g as a result. The front axle hits its limit first; the rear axle is what's actually still holding the car up.

**2. Braking grip is almost entirely a front-axle event.**
Under combined braking + cornering, the front tires reached ~2800 N of longitudinal force versus ~250 N at the rear — consistent with front-biased brake proportioning and forward weight transfer concentrating nearly all the braking work on the front axle.

**3. Three transient grip-loss events, explained.**
Sharp dips in front-right slip ratio and force appeared at three points during hard braking-in-turn. Cross-referencing against brake pressure (smooth, no glitch) and normal load (matching oscillations) ruled out ABS activity or input noise, pointing instead to the front-right tire transiently exceeding its combined friction limit under peak demand.

**4. Understeer gradient validated two ways.**
A two-point calibration estimated K ≈ 16.5 deg/g; a full linear regression across 7 speed points (20–80 km/h) landed at K = 17.35 deg/g — within ~5%, confirming linear-range handling behavior as expected.

---

## The Three Tests

| # | Test | What it isolates |
|---|---|---|
| 1 | Constant-radius cornering & grip-limit sweep | Steering angle needed to hold a 100m radius across a full speed sweep, extending through the point where grip runs out → handling diagram + cornering performance ceiling |
| 2 | Step-steer transient response | How cleanly the car settles after a sudden steering input, across speeds → stability margin |
| 3 | Brake-in-turn | How braking eats into cornering grip → slip ratio, friction ellipse, per-tire force split |

---

## Deliverables

1. Tire force curves (Fx vs. slip ratio, Fy vs. slip angle)
2. Load sensitivity (resultant force vs. normal load)
3. Slip ratio analysis (slip ratio vs. time, force overlaid)
4. Friction ellipse
5. Handling diagram
6. Understeer gradient
7. Step-steer time response
8. Stability margin
9. Cornering performance summary (extended from the grip-limit sweep: front/rear axle grip-ceiling investigation)
10. Combined summary figure

Full methodology, data-cleaning decisions, and detailed findings are in [`docs/methodology.md`](docs/methodology.md).

---

## Repo Structure

```
├── matlab/     MATLAB analysis scripts, organized by test
├── figures/    Final exported plots for all 10 deliverables
└── docs/       Full methodology and findings write-up
```

---

## Notes on Scope

All results reflect dry-surface conditions only; wet/low-grip surface comparisons were part of the original plan but not executed within project time constraints. The vehicle's absolute cornering ceiling (where the rear axle also saturates) was not fully captured — the front axle's limit was confirmed directly, but the rear axle still had reserve capacity at the highest steering angle tested.
