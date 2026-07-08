# DMA Threat Model

## Secure DMA vs. DMA attacks

A secure DMA design restricts device memory access to authorized buffers only. A DMA attack occurs when a device is able to read or write memory outside its permitted regions.

## Assets and trust boundaries

The main assets in a DMA threat model are memory contents, process state, driver integrity, and the confidentiality of sensitive runtime data. The trust boundary is the line between what the CPU and OS consider authorized and what a device is permitted to reach.

## Threat actors

- compromised device firmware
- malicious or buggy drivers
- untrusted external devices connected via PCIe, Thunderbolt, or similar interfaces
- weakly protected platforms where firmware or OS policy does not enforce isolation

## Attack surface

- physical access to expansion slots or external ports
- weak or absent IOMMU configurations
- unsafe buffer sharing between devices and software
- permissive DMA policies in firmware or the OS

## Defensive controls

- IOMMU and device isolation
- kernel DMA protection
- bus and port security
- driver-level validation and pinning
- secure boot and firmware integrity

## Example scenario (high level)

In a basic attack scenario, an untrusted DMA device could attempt to use bus master access to transfer data to arbitrary physical addresses. The IOMMU and OS protections prevent that by allowing only mapped and authorized buffers.

## Why DMA is relevant to anti-cheat

DMA matters in anti-cheat discussions because it changes the way memory can be observed. Normal checks usually happen through the CPU and the operating system. DMA gives a device a much more direct route into memory, which means the system can no longer assume that only the intended software paths are seeing sensitive state.

That is why serious anti-cheat systems do not rely on secrecy alone. They depend on isolation, verified drivers, secure boot, IOMMU enforcement, and strict boundaries around what devices are allowed to touch. The real issue is not that DMA is secretly magic. It is that when those protections are weak, a device can end up seeing far more than it should, and that is exactly the kind of thing that makes anti-cheat systems nervous.

## Ethical note

This document is educational. Unauthorized DMA access to another system is unethical and often illegal. The goal is to understand and mitigate risks rather than exploit them.
