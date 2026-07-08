# DMA Basics

## What DMA is

Direct Memory Access (DMA) is a mechanism that lets a peripheral device move data directly to or from system memory without the CPU handling every byte. It improves throughput and reduces CPU overhead, which is why it is used so widely in storage, networking, graphics, and media hardware.

## Main actors

- Device: the hardware component that needs to move data
- DMA controller or bus master: the logic that performs the transfer
- System memory: the DRAM region that stores the data
- CPU: allocates buffers, programs the device, and starts the transfer
- Bus fabric: the interconnect, often PCIe, that carries the requests and data

## DMA transfer workflow

1. The driver allocates a memory buffer and pins it so it stays resident.
2. The driver programs the device with a valid address, often through an IOMMU-managed mapping.
3. The device requests control of the bus and becomes the bus master.
4. The device issues read or write transactions directly to memory.
5. Data flows between the device and RAM without the CPU copying every byte.

## DMA types

- Bus-master DMA: the device initiates and controls the transfer.
- Scatter/gather DMA: the device can handle noncontiguous memory regions.
- Streaming DMA: used for continuous flows such as audio or video.
- Block DMA: used for large transfers such as storage or network packets.

## Why DMA is used

DMA exists because it is more efficient than CPU-driven transfers for high-bandwidth I/O. It lowers CPU load, reduces latency, and allows devices such as SSDs, NICs, and GPUs to move data quickly.

## Why DMA matters for security

DMA is not magic by itself. It simply moves bytes according to the addresses and permissions that software exposes to a device. The security concern is that if a device or driver can access memory outside the intended boundaries, the normal CPU-mediated trust model becomes much weaker. That is why anti-cheat systems and security vendors care so much about the OS, the IOMMU, kernel protections, and the trust level of device firmware.

## Common misconceptions

- DMA is not automatically dangerous; it is a mechanism, not a threat by itself.
- DMA does not bypass all security automatically; it only becomes a problem when the platform does not enforce strong isolation.
- A secure system does not usually disable DMA everywhere; it limits it using policy, firmware, and hardware enforcement.
