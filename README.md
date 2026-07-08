![DMA Guide cover](assets/cover.svg)

# DMA Guide

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![Topics](https://img.shields.io/badge/topics-systems%2Csecurity%2Chardware-blue)](https://github.com/topics)

A compact, defensive guide to DMA, IOMMU, operating-system protections, and why DMA matters in security-sensitive environments.

DMA allows a peripheral to move data to or from system memory without the CPU handling every byte itself. That makes it essential for SSDs, network cards, GPUs, capture devices, and other high-throughput hardware.

At the same time, DMA shifts the system's trust boundary: devices with direct memory access must be constrained by firmware and OS controls so they cannot read or modify memory they shouldn't.

This repository is written for engineers and security practitioners who want a practical understanding of DMA, how to reason about risk, and which controls matter in real systems.

## Quick start

1. Read the fundamentals: [docs/dma-basics.md](docs/dma-basics.md)
2. Learn why IOMMU matters: [docs/iommu.md](docs/iommu.md)
3. Review protections and threat modeling: [docs/os-protections.md](docs/os-protections.md) and [docs/threat-model.md](docs/threat-model.md)

## What is inside

- [docs/dma-basics.md](docs/dma-basics.md) — DMA fundamentals, actors, and transfer flow
- [docs/iommu.md](docs/iommu.md) — IOMMU concepts, translation domains, and isolation
- [docs/os-protections.md](docs/os-protections.md) — kernel, firmware, and platform protections
- [docs/threat-model.md](docs/threat-model.md) — threat modeling and anti-cheat relevance
- [docs/use-cases.md](docs/use-cases.md) — legitimate use cases and the security controversy around DMA

## Why DMA matters

DMA is not inherently malicious — it's a performance feature. What makes it security-relevant is that it provides a path for devices to observe or alter memory outside normal software-mediated channels. Modern platforms mitigate that risk through address translation (IOMMU), firmware validation, driver policies, and runtime kernel protections.

## Note

This repository is educational and defensive in tone. Use the material to inform system design, threat models, and secure deployment rather than as an attack playbook.
