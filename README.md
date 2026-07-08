# DMA Guide

A practical, defensive overview of DMA, IOMMU, operating-system protections, and why DMA matters in security-sensitive environments.

DMA allows a peripheral to move data to or from system memory without the CPU handling every byte itself. That makes it essential for SSDs, network cards, GPUs, capture devices, and other high-throughput hardware. At the same time, it changes the trust boundary of a system: once a device can access memory directly, the OS and firmware must enforce strong isolation rules.

This repository is intended as a compact guide for readers who want to understand:
- how a DMA transfer works end to end
- which components participate in the flow
- why IOMMU matters for isolation
- what protections the OS and firmware can provide
- why DMA is relevant in anti-cheat and defensive threat modeling

## What is inside

- [docs/dma-basics.md](docs/dma-basics.md) — DMA fundamentals, actors, and transfer flow
- [docs/iommu.md](docs/iommu.md) — IOMMU concepts, translation domains, and isolation
- [docs/os-protections.md](docs/os-protections.md) — kernel, firmware, and platform protections
- [docs/threat-model.md](docs/threat-model.md) — threat modeling and anti-cheat relevance
- [docs/use-cases.md](docs/use-cases.md) — legitimate use cases and the security controversy around DMA

## Why DMA matters

DMA is not inherently malicious. It is a performance mechanism. What makes it important is that it changes the assumptions around who can observe or alter memory. In practice, that is why DMA shows up in discussions about device isolation, firmware trust, anti-cheat systems, and system hardening.

## Note

This repository is educational and defensive in tone. The goal is to explain how DMA works and why modern systems rely on hardware and software controls to keep it safe.
