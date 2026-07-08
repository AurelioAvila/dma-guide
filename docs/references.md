# References

Primary sources behind this guide. Where a canonical URL is stable it is included;
for vendor documentation, titles are given so the current page can be located directly
on the vendor's site.

## Academic

- **"If It Looks Like a Rootkit and Deceives Like a Rootkit: A Critical Examination of
  Kernel-Level Anti-Cheat Systems"** — ARES 2024.
  Analyzes kernel-level anti-cheat software (including FACEIT AC and Vanguard) through the
  lens of rootkit taxonomy: kernel-level operation, system-wide callback registration,
  broad OS visibility. https://arxiv.org/abs/2408.00500

## Vendor / platform documentation

- **Kernel DMA Protection** — Microsoft Learn (Windows hardware security).
  Describes how the IOMMU is used to block drive-by DMA from Thunderbolt and hot-plug
  PCIe devices. (Locate the current page on Microsoft Learn under Windows → Hardware
  security.)

- **Intel VT-d** — Intel Virtualization Technology for Directed I/O architecture
  specification. Reference for IOMMU behavior on Intel platforms.

- **AMD-Vi / IOMMU** — AMD I/O Virtualization Technology (IOMMU) specification.
  Reference for IOMMU behavior on AMD platforms.

## Tooling (defensive / forensic)

- **PCILeech** — Ulf Frisk. DMA acquisition framework used in security research and
  memory forensics. https://github.com/ufrisk/pcileech

- **MemProcFS** — Ulf Frisk. Mounts physical memory (live or from a dump) as a navigable
  file system for analysis. https://github.com/ufrisk/MemProcFS

- **Volatility 3** — Volatility Foundation. Memory forensics framework for analyzing
  acquired memory images. https://github.com/volatilityfoundation/volatility3

## Related attack surface

- **Thunderspy** — Björn Ruytenberg. Research on Thunderbolt security weaknesses and
  the DMA attack surface exposed by external ports. https://thunderspy.io
