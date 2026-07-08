# What's Behind DMA and How People Use It

DMA sounds simple on paper, but it is one of those mechanisms that quietly sits underneath a lot of modern computing. A peripheral can move data directly to or from system memory without the CPU shuttling every byte itself. That is why DMA is so useful in SSDs, network cards, GPUs, capture devices, and other high-throughput hardware.

The same feature that makes DMA efficient also makes it interesting from a security point of view. Once a device can talk to memory directly, the usual assumptions about trust and visibility change. That is why DMA matters in discussions about anti-cheat systems, firmware integrity, IOMMU enforcement, and the boundaries between the OS, drivers, and hardware.

This repository explains the core ideas behind DMA:
- how a DMA transfer works
- which components participate in the flow
- how the IOMMU and OS protections shape the threat model
- where DMA is used legitimately
- why it becomes controversial in security-sensitive environments

## What this guide covers

- DMA fundamentals and transaction flow
- PCIe, bus mastering, and device-to-memory transfers
- IOMMU concepts, address translation, and isolation
- operating-system and firmware protections
- real-world use cases and threat awareness

## Why DMA matters

DMA is not inherently malicious. It is a performance mechanism. What makes it important is that it changes the trust model: if a device can access memory directly, then the system must enforce strong rules about who can use that path, which addresses are allowed, and how much of the system is exposed.

That is also why anti-cheat products care so much about DMA. In practice, the concern is not simply that a device can transfer data. The concern is that memory visibility can be expanded through a path that bypasses the normal application-level software flow.

## Notes

This repository is educational and defensive in tone. It explains how DMA works and why modern systems rely on hardware and software controls to keep it safe.
