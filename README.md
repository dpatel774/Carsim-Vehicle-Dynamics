# Tire & Road Interaction Modeling

Independent vehicle dynamics project modeling how a car's tires generate grip, lose grip, and respond to steering and braking inputs, using CarSim for simulation and MATLAB for analysis.

- **Vehicle:** D-Class Sedan (CarSim 2020), held constant across all tests
- **Tools:** CarSim (simulation), MATLAB (analysis and plotting)
- **Scope:** 3 standardized test maneuvers, 10 analysis deliverables

---

## Objective

I wanted a hands-on way to apply vehicle dynamics concepts I hadn't gotten to use in a real analysis before, tire slip, grip limits, understeer, brake proportioning, using a professional-grade simulator instead of a simplified textbook model. The goal was to run standardized tests, pull real data out of them, and see whether the numbers actually told a coherent physical story rather than just producing plots for their own sake.

---

## Key Findings

**1. The car's cornering limit is rear-limited, not front-limited.**
A steering-angle sweep at fixed speed showed front tire lateral force peaking and saturating near 4° slip angle. The rear tires never saturated, still climbing with no sign of a peak. The front axle hits its limit first; the rear axle is what's actually still holding the car up.

<p float="left">
  <img src="figures/test1_grip_ceiling_front.png" width="49%" />
  <img src="figures/test1_grip_ceiling_rear.png" width="49%" />
</p>

**2. Braking grip is almost entirely a front-axle event.**
Under combined braking and cornering, front tires reached ~2800 N of longitudinal force versus ~250 N at the rear, consistent with front-biased brake proportioning and forward weight transfer.

![Friction ellipse showing front tires tracing the grip boundary while rear tires stay clustered near the origin](figures/test3_friction_ellipse.png)

**3. Three transient grip-loss events, explained.**
Sharp dips in front-right slip ratio and force appeared at three points during hard braking-in-turn, ruled out as ABS or input noise, and traced instead to the tire transiently exceeding its combined friction limit under peak demand.

**4. Understeer gradient validated two ways.**
A two-point calibration estimated K ≈ 16.5 deg/g. A full linear regression across 7 speed points landed at K = 17.35 deg/g, within ~5%.

---

## The Three Tests

| # | Test | What it isolates |
|---|---|---|
| 1 | Constant-radius cornering & grip-limit sweep | Steering angle needed to hold a 100m radius across a full speed sweep, extending through the point where grip runs out |
| 2 | Step-steer transient response | How cleanly the car settles after a sudden steering input, across speeds |
| 3 | Brake-in-turn | How braking eats into cornering grip |

Full methodology, findings, and setup for each test:
- [`docs/test1-cornering-griplimit.md`](docs/test1-cornering-griplimit.md)
- [`docs/test2-stepsteer.md`](docs/test2-stepsteer.md)
- [`docs/test3-brakeinturn.md`](docs/test3-brakeinturn.md)

---

## Deliverables

1. Tire force curves (Fx vs. slip ratio, Fy vs. slip angle)
2. Load sensitivity
3. Slip ratio analysis
4. Friction ellipse
5. Handling diagram
6. Understeer gradient
7. Step-steer time response
8. Stability margin
9. Cornering performance summary, extended into a front/rear axle grip-ceiling investigation
10. Combined summary figure

---

## Repo Structure

```
├── matlab/     MATLAB analysis scripts, organized by test
├── figures/    Final exported plots for all 10 deliverables
└── docs/       Per-test methodology and findings write-ups
```
