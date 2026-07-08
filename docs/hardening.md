# Hardening Checklist — Defending Against DMA-Based Memory Access

This is the practical counterpart to the conceptual chapters. DMA attacks bypass
the CPU and the operating system's software controls, so the defense is **architectural
and preventive**, not purely detective. The goal is to make sure a device cannot map
and read memory it has no business reading.

Controls are ordered by leverage: the first items close the widest gap.

---

## 1. Kernel DMA Protection (Windows)

The single highest-impact endpoint control. It uses the IOMMU to block DMA-capable
peripherals (Thunderbolt, hot-plug PCIe) from accessing memory until the device is
authorized and the user has logged in.

**Verify current state:**
- Run `msinfo32` → System Summary → look for **"Kernel DMA Protection"**. `On` is the
  target state.
- Alternatively, in PowerShell, inspect the device's DMA remapping property under
  Device Manager → device → Details → *DMA Remapping Policy*.

**Requirements:** UEFI firmware support + an enabled IOMMU (see item 2). On hardware
that predates the feature, fall back to firmware-level DMA protection and Secure Boot.

---

## 2. IOMMU / VT-d / AMD-Vi enabled in firmware

The IOMMU is the hardware that sits between peripherals and physical memory and
enforces which addresses a device may touch. Without it, Kernel DMA Protection has
nothing to build on.

- Intel platforms: enable **VT-d** in BIOS/UEFI.
- AMD platforms: enable **AMD-Vi / IOMMU** in BIOS/UEFI.
- After enabling, **verify the IOMMU actually initializes** — some firmware reports
  protection as active while the IOMMU is not brought up early enough (a real class of
  firmware bug). Do not trust the firmware's self-report alone; confirm the OS-side
  state.

---

## 3. Secure Boot + up-to-date firmware

- Keep **Secure Boot** enabled so the pre-boot environment is trusted before any
  DMA-capable device can act.
- Apply UEFI/BIOS updates. Several DMA-protection gaps are firmware bugs fixed by the
  board vendor, not by the OS.

---

## 4. Restrict external DMA-capable ports

Thunderbolt and external PCIe are the classic physical vectors ("drive-by DMA",
"evil maid").

- Disable unused Thunderbolt / external PCIe ports in firmware where practical.
- In managed environments, enforce device-authorization policy so unknown peripherals
  cannot enumerate.
- Where Kernel DMA Protection is unavailable, use Thunderbolt security levels to require
  user approval for new devices.

---

## 5. Memory encryption (high-assurance environments)

If a device does manage a read, encrypted memory yields ciphertext rather than usable
data.

- AMD **SME / SEV**, Intel **TME / MKTME**.
- Typical in server, confidential-computing, and high-sensitivity endpoint scenarios.

---

## 6. Detection and monitoring (defense in depth)

DMA activity itself leaves little trace on the target, so watch for **side effects**:

- Unexpected PCIe / Thunderbolt device enumeration in system logs.
- New hardware IDs appearing outside change windows.
- Correlation with physical access events.
- Boot-time anomalies.

The honest takeaway: against a well-built DMA device on an unprotected consumer machine,
pure software detection is close to impossible — there is no process, driver, or module
on the host to find. This is why the controls above are preventive. If the IOMMU is
configured correctly, the device simply cannot map the memory it wants to read.

---

## Quick verification summary

| Control | How to check |
|---|---|
| Kernel DMA Protection | `msinfo32` → "Kernel DMA Protection: On" |
| IOMMU (Intel) | VT-d enabled in UEFI + OS-side confirmation |
| IOMMU (AMD) | AMD-Vi / IOMMU enabled in UEFI + OS-side confirmation |
| Secure Boot | `msinfo32` → "Secure Boot State: On" |
| Firmware | Vendor version vs. latest security release |
| Memory encryption | Platform feature flags (SME/SEV, TME) |
