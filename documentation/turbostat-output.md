# Turbostat Output

```
turbostat version 17.06.23 - Len Brown <lenb@kernel.org>
CPUID(0): GenuineIntel 13 CPUID levels; family:model:stepping 0x6:3c:3 (6:60:3)
CPUID(1): SSE3 - - - - TSC MSR - -
CPUID(6): No-APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
cpu0: MSR_IA32_MISC_ENABLE: 0x00001801 (No-TCC No-EIST MWAIT PREFETCH TURBO)
CPUID(7): No-SGX
cpu0: MSR_MISC_PWR_MGMT: 0x00000000 (ENable-EIST_Coordination DISable-EPB DISable-OOB)
RAPL: inf sec. Joule Counter Range, at 0 Watts
cpu0: MSR_PLATFORM_INFO: 0x28280000002800
40 * 100.0 = 4000.0 MHz max efficiency frequency
40 * 100.0 = 4000.0 MHz base frequency
cpu0: MSR_IA32_POWER_CTL: 0x00000000 (C1E auto-promotion: DISabled)
cpu0: MSR_TURBO_RATIO_LIMIT: 0x1f1f1f1f1f20
31 * 100.0 = 3100.0 MHz max turbo 6 active cores
31 * 100.0 = 3100.0 MHz max turbo 5 active cores
31 * 100.0 = 3100.0 MHz max turbo 4 active cores
31 * 100.0 = 3100.0 MHz max turbo 3 active cores
31 * 100.0 = 3100.0 MHz max turbo 2 active cores
32 * 100.0 = 3200.0 MHz max turbo 1 active cores
cpu0: MSR_CONFIG_TDP_NOMINAL: 0x00000000 (base_ratio=0)
cpu0: MSR_CONFIG_TDP_LEVEL_1: 0x00000000 ()
cpu0: MSR_CONFIG_TDP_LEVEL_2: 0x00000000 ()
cpu0: MSR_CONFIG_TDP_CONTROL: 0x00000000 ( lock=0)
cpu0: MSR_TURBO_ACTIVATION_RATIO: 0x00000000 (MAX_NON_TURBO_RATIO=0 lock=0)
cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x1e000001 (UNdemote-C3, UNdemote-C1, demote-C3, demote-C1, UNlocked: pkg-cstate-limit=1:
pc2)
NSFOD /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
cpu0: MSR_MISC_FEATURE_CONTROL: 0x00000000 (L2-Prefetch L2-Prefetch-pair L1-Prefetch L1-IP-Prefetch)
cpu0: MSR_CORE_PERF_LIMIT_REASONS, 0x1d200000 (Active: ) (Logged: MultiCoreTurbo, PkgPwrL2, PkgPwrL1, Amps, Auto-HWP, )
cpu0: MSR_GFX_PERF_LIMIT_REASONS, 0x1d000000 (Active: ) (Logged: Amps, PkgPwrL1, PkgPwrL2, )
cpu0: MSR_RING_PERF_LIMIT_REASONS, 0x0d000000 (Active: ) (Logged: Amps, PkgPwrL1, PkgPwrL2, )
cpu0: MSR_RAPL_POWER_UNIT: 0x00000000 (1.000000 Watts, 1.000000 Joules, 0.000977 sec.)
cpu0: MSR_PKG_POWER_INFO: 0x00000000 (0 W TDP, RAPL 0 - 0 W, 0.000000 sec.)
cpu0: MSR_PKG_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: PKG Limit #1: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: PKG Limit #2: DISabled (0.000000 Watts, 0.000977* sec, clamp DISabled)
cpu0: MSR_PP0_POLICY: 0
cpu0: MSR_PP0_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: Cores Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_PP1_POLICY: 0
cpu0: MSR_PP1_POWER_LIMIT: 0x00000000 (UNlocked)
cpu0: GFX Limit: DISabled (0.000000 Watts, 0.000977 sec, clamp DISabled)
cpu0: MSR_PKGC3_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu0: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
cpu0: MSR_PKGC7_IRTL: 0x00000000 (NOTvalid, 0 ns)
```