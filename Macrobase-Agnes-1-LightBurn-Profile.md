# LightBurn Profile — Macrobase Agnes 1

## Create the device
In LightBurn, open **Devices → Create Manually** and enter:

| Setting | Value |
|---|---|
| Controller | **GRBL** |
| Connection | **Serial/USB** |
| Name | **Macrobase Agnes 1 — FluidNC** |
| Baud rate | **115200** |
| Width (X) | **400 mm** |
| Height (Y) | **300 mm** |
| Origin | **Top Right** |
| Auto-home on startup | **Off for now** |

Select the Macrobase CH340 COM port. Close FluidTerm, the custom dashboard, and other serial programs first because only one program can own the COM port.

## Device Settings
Set these under **Edit → Device Settings**:

| Setting | Value |
|---|---|
| S-Value Max | **1000** |
| Z Axis | **Disabled** |
| Scanning Offset Adjustment | **Disabled** |
| Enable Laser Fire Button | **Disabled initially** |
| Transfer mode | **Buffered** (default GRBL mode) |

Use **mm/min** for speed display. FluidNC permits up to 10,000 mm/min on X/Y, but begin travel tests at 5,000 mm/min.

## Coordinates and jobs
- After XY homing is physically verified, run **Home XY** (`$H`) before jobs and use **Start From: Absolute Coords**.
- Machine zero is the **top-right** corner. X and Y machine travel extend in the negative direction from zero.
- Z is manual-only and must not be included in homing or LightBurn job movement.
- Until homing is verified, leave automatic homing off and test framing with the laser inhibited.
- Keep LightBurn's job-origin marker at the **top-right** when using Current Position or User Origin workflows.

## Laser mapping
- FluidNC PWM range is `S0`–`S1000` on GPIO27.
- LightBurn power percentages map directly: 10% = `S100`, 30% = `S300`, 100% = `S1000`.
- Ensure each job finishes with laser output off (`M5`); LightBurn's normal GRBL output does this automatically.

After the first successful top-right homing test, **Auto-home on startup** may be enabled in LightBurn if desired. Hard and soft limits should remain disabled in FluidNC until homing and full travel are verified.