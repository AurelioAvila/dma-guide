# IOMMU

## What an IOMMU is

The I/O Memory Management Unit (IOMMU) translates device-visible addresses into physical memory addresses. It is similar to the CPU MMU, but it applies to DMA-capable devices instead of the CPU itself.

## Why the IOMMU matters

Without an IOMMU, a DMA-capable device can potentially access any physical address that the driver exposes to it. That makes DMA powerful, but it also creates a serious isolation problem if the device, firmware, or driver is compromised.

## Core concepts

- Device address space: the address range visible to the device.
- Translation domain: the set of mappings assigned to a device or group of devices.
- Page tables: mappings between device-visible addresses and physical memory.
- Access control: rules that limit DMA to authorized buffers.
- Interrupt remapping: a related feature that helps isolate interrupt handling for devices.

## Typical IOMMU workflow

1. The OS allocates and pins physical memory for DMA.
2. The OS creates IOMMU mappings for the device's DMA buffers.
3. The device uses device-visible addresses from the IOMMU.
4. The IOMMU translates those addresses to physical memory.
5. Any access outside the authorized range is blocked and reported.

## Common implementations

- Intel VT-d
- AMD-Vi
- ARM SMMU

## What the IOMMU protects

The IOMMU prevents devices from accessing unrelated physical memory regions. It is a key defense against DMA-based attacks and a foundation for secure device isolation. In practice, it acts as both an address translator and a policy engine: it decides which memory can be reached and under which conditions.
