# Hurricane Agnes 1 — Final Macrobase Setup

## Active files
- `config.yaml` — final FluidNC v4.0.3 configuration; upload as `/littlefs/config.yaml`.
- `fluidnc-dashboard.html` — custom network/USB dashboard with jog, test pulse, and G-code streaming.
- `start-fluidnc-dashboard-usb.bat` — opens the dashboard locally for USB-only control.
- `serve-fluidnc-dashboard.ps1` — dependency-free localhost server used by the launcher.

## Controller
- Macrobase classic ESP32, FluidNC v4.0.3.
- Network: `http://172.16.0.12/` or `http://fluidnc.local/` when reachable.
- USB: run `start-fluidnc-dashboard-usb.bat` in Chrome/Edge, click **USB**, and choose the CH340 COM port.
- Only one application can own the USB COM port at a time.

## Motion
- X: 160 steps/mm, 10,000 mm/min maximum, top-right positive-end homing on GPIO33.
- Y: 160 steps/mm, 10,000 mm/min maximum, top-right positive-end homing on GPIO32.
- Z: 400 steps/mm, 100 mm/min maximum, manual only; no limit or homing cycle.
- **Home XY** runs `$H`; Z is excluded and homing is not mandatory at startup.
- Hard limits remain disabled until the first XY homing cycle is verified.

## Laser
- LPSU blue `IN` → Macrobase `PWM 3.3` / GPIO27.
- LPSU brown `G` → adjacent Macrobase GND.
- LPSU yellow `L/TL` → GND; independent pressure, lid, key, and E-stop interlocks remain in circuit.
- PWM range: `S0`–`S1000`; dashboard test pulse is 30% for 1 second, followed by `M5`.

## Recovery
Everything historical or needed for restore/reflash is under `old backup`.
The verified stock 4 MB image SHA-256 is:
`6C6E0406045F3060562885941BDC03072A5A259336185E48BC50B40C140A01E5`
