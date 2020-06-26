{
  services.tlp = {
    enable = true;
    extraConfig = /* config */ ''
      # ------------------------------------------------------------------------------
      # /etc/tlp.conf - TLP user configuration
      # See full explanation: https://linrunner.de/en/tlp/docs/tlp-configuration.html
      #
      # New configuration scheme (TLP 1.3). Settings are read in the following order:
      # 1. Intrinsic defaults
      # 2. /etc/tlp.conf.d/*.conf - Drop-in customizations
      # 3. /etc/tlp.conf          - User configuration
      # In case of identical parameters, the last occurence has precedence.
      #
      # Notes:
      # - IMPORTANT: all parameters are disabled, remove the leading '#' to enable
      #   them; shown values may be suggestions rather than defaults
      # - Default *: intrinsic default that is effective when the parameter is missing
      #   or disabled by a leading '#'; use PARAM="" to disable intrinsic defaults for
      #   parameters with text string values
      # - Default <none>: do nothing or use kernel/hardware defaults

      # ------------------------------------------------------------------------------
      # tlp - Parameters for power saving

      # Set to 0 to disable, 1 to enable TLP.
      # Default: 1

      #TLP_ENABLE=1

      # Operation mode when no power supply can be detected: AC, BAT.
      # Concerns some desktop and embedded hardware only.
      # Default: <none>

      #TLP_DEFAULT_MODE=AC

      # Operation mode select: 0=depend on power source, 1=always use TLP_DEFAULT_MODE
      # Hint: use in conjunction with TLP_DEFAULT_MODE=BAT for BAT settings on AC.
      # Default: 0

      #TLP_PERSISTENT_DEFAULT=0

      # Seconds laptop mode has to wait after the disk goes idle before doing a sync.
      # Non-zero value enables, zero disables laptop mode.
      # Default: 0 (AC), 2 (BAT)

      #DISK_IDLE_SECS_ON_AC=0
      #DISK_IDLE_SECS_ON_BAT=2

      # Dirty page values (timeouts in secs).
      # Default: 15 (AC), 60 (BAT)

      #MAX_LOST_WORK_SECS_ON_AC=15
      #MAX_LOST_WORK_SECS_ON_BAT=60

      # Note: CPU parameters below are disabled by default, remove the leading #
      # to enable them, otherwise kernel defaults will be used.
      #
      # Select a CPU frequency scaling governor.
      # Intel Core i processor with intel_pstate driver:
      #   powersave(*), performance.
      # Other hardware with acpi-cpufreq driver:
      #   ondemand(*), powersave, performance, conservative, schedutil.
      # (*) is recommended.
      # Use tlp-stat -p to show the active driver and available governors.
      # Important:
      #   powersave for intel_pstate and ondemand for acpi-cpufreq are power
      #   efficient for *almost all* workloads and therefore kernel and most
      #   distributions have chosen them as defaults. If you still want to change,
      #   you should know what you're doing!
      # Default: <none>

      CPU_SCALING_GOVERNOR_ON_AC=powersave
      CPU_SCALING_GOVERNOR_ON_BAT=powersave

      # Set the min/max frequency available for the scaling governor.
      # Possible values depend on your CPU. For available frequencies see
      # the output of tlp-stat -p.
      # Default: <none>

      #CPU_SCALING_MIN_FREQ_ON_AC=0
      #CPU_SCALING_MAX_FREQ_ON_AC=0
      #CPU_SCALING_MIN_FREQ_ON_BAT=0
      #CPU_SCALING_MAX_FREQ_ON_BAT=0
      #CPU_SCALING_MIN_FREQ_ON_AC=800000
      #CPU_SCALING_MAX_FREQ_ON_AC=4800000
      #CPU_SCALING_MIN_FREQ_ON_BAT=400000
      #CPU_SCALING_MAX_FREQ_ON_BAT=1100000

      # Set Intel CPU energy/performance policies HWP.EPP and EPB:
      #   performance, balance_performance, default, balance_power, power
      # Values are given in order of increasing power saving.
      # Notes:
      # - Requires an Intel Core i processor
      # - HWP.EPP requires kernel 4.10 and intel_pstate driver
      # - EPB requires kernel 5.2 or module msr and x86_energy_perf_policy
      #   from linux-tools
      # - When HWP.EPP is available, EPB is not set
      # Default: balance_performance (AC), power (BAT)

      #CPU_ENERGY_PERF_POLICY_ON_AC=balance_performance
      #CPU_ENERGY_PERF_POLICY_ON_BAT=power

      # Set Intel CPU P-state performance: 0..100 (%).
      # Limit the max/min P-state to control the power dissipation of the CPU.
      # Values are stated as a percentage of the available performance.
      # Requires an Intel Core i processor with intel_pstate driver.
      # Default: <none>

      #CPU_MIN_PERF_ON_AC=8
      #CPU_MAX_PERF_ON_AC=100
      #CPU_MIN_PERF_ON_BAT=8
      #CPU_MAX_PERF_ON_BAT=100

      # Set the CPU "turbo boost" feature: 0=disable, 1=allow
      # Requires an Intel Core i processor.
      # Important:
      # - This may conflict with your distribution's governor settings
      # - A value of 1 does *not* activate boosting, it just allows it
      # Default: <none>

      CPU_BOOST_ON_AC=0
      CPU_BOOST_ON_BAT=0

      # Minimize number of used CPU cores/hyper-threads under light load conditions:
      #   0=disable, 1=enable.
      # Default: 0 (AC), 1 (BAT)

      #SCHED_POWERSAVE_ON_AC=0
      #SCHED_POWERSAVE_ON_BAT=1

      # Kernel NMI Watchdog:
      #   0=disable (default, saves power), 1=enable (for kernel debugging only).
      # Default: 0

      #NMI_WATCHDOG=0

      # Change CPU voltages aka "undervolting" - Kernel with PHC patch required.
      # Frequency voltage pairs are written to:
      #   /sys/devices/system/cpu/cpu0/cpufreq/phc_controls
      # CAUTION: only use this, if you thoroughly understand what you are doing!
      # Default: <none>.

      #PHC_CONTROLS="F:V F:V F:V F:V"

      # Disk devices; separate multiple devices with spaces.
      # Devices can be specified by disk ID also (lookup with: tlp diskid).
      # Note: DISK parameters below are effective only when this option is configured.
      # Default: "nvme0n1 sda"

      #DISK_DEVICES="nvme0n1 sda"

      # Disk advanced power management level: 1..254, 255 (max saving, min, off).
      # Levels 1..127 may spin down the disk; 255 allowable on most drives.
      # Separate values for multiple disks with spaces. Use the special value 'keep'
      # to keep the hardware default for the particular disk.
      # Default: 254 (AC), 128 (BAT)

      #DISK_APM_LEVEL_ON_AC="254 254"
      #DISK_APM_LEVEL_ON_BAT="128 128"

      # Hard disk spin down timeout:
      #   0:        spin down disabled
      #   1..240:   timeouts from 5s to 20min (in units of 5s)
      #   241..251: timeouts from 30min to 5.5 hours (in units of 30min)
      # See 'man hdparm' for details.
      # Separate values for multiple disks with spaces. Use the special value 'keep'
      # to keep the hardware default for the particular disk.
      # Default: <none>

      #DISK_SPINDOWN_TIMEOUT_ON_AC="0 0"
      #DISK_SPINDOWN_TIMEOUT_ON_BAT="0 0"

      # Select I/O scheduler for the disk devices.
      # Multi queue (blk-mq) schedulers:
      #   mq-deadline(*), none, kyber, bfq
      # Single queue schedulers:
      #   deadline(*), cfq, bfq, noop
      # (*) recommended.
      # Separate values for multiple disks with spaces. Use the special value 'keep'
      # to keep the kernel default scheduler for the particular disk.
      # Notes:
      # - Multi queue (blk-mq) may need kernel boot option 'scsi_mod.use_blk_mq=1'
      #   and 'modprobe mq-deadline-iosched|kyber|bfq' on kernels < 5.0
      # - Single queue schedulers are legacy now and were removed together with
      #   the old block layer in kernel 5.0
      # Default: keep

      #DISK_IOSCHED="mq-deadline mq-deadline"

      # AHCI link power management (ALPM) for disk devices:
      #   min_power, med_power_with_dipm(*), medium_power, max_performance.
      # (*) Kernel >= 4.15 required, then recommended.
      # Multiple values separated with spaces are tried sequentially until success.
      # Default:
      #  - "med_power_with_dipm max_performance" (AC)
      #  - "med_power_with_dipm min_performance" (BAT)

      #SATA_LINKPWR_ON_AC="med_power_with_dipm max_performance"
      #SATA_LINKPWR_ON_BAT="med_power_with_dipm min_power"

      # Exclude host devices from AHCI link power management.
      # Separate multiple hosts with spaces.
      # Default: <none>

      #SATA_LINKPWR_BLACKLIST="host1"

      # Runtime Power Management for AHCI host and disks devices:
      #   on=disable, auto=enable.
      # EXPERIMENTAL ** WARNING: auto may cause system lockups/data loss.
      # Default: <none>

      #AHCI_RUNTIME_PM_ON_AC=on
      #AHCI_RUNTIME_PM_ON_BAT=auto

      # Seconds of inactivity before disk is suspended.
      # Note: effective only when AHCI_RUNTIME_PM_ON_AC/BAT is activated.
      # Default: 15

      #AHCI_RUNTIME_PM_TIMEOUT=15

      # PCI Express Active State Power Management (PCIe ASPM):
      #   default(*), performance, powersave, powersupersave.
      # (*) keeps BIOS ASPM defaults (recommended)
      # Default: <none>

      #PCIE_ASPM_ON_AC=default
      #PCIE_ASPM_ON_BAT=default

      # Set the min/max/turbo frequency for the Intel GPU.
      # Possible values depend on your hardware. For available frequencies see
      # the output of tlp-stat -g.
      # Default: <none>

      #INTEL_GPU_MIN_FREQ_ON_AC=300
      #INTEL_GPU_MIN_FREQ_ON_BAT=300
      #INTEL_GPU_MAX_FREQ_ON_AC=1150
      #INTEL_GPU_MAX_FREQ_ON_BAT=500
      #INTEL_GPU_BOOST_FREQ_ON_AC=1150
      #INTEL_GPU_BOOST_FREQ_ON_BAT=700

      # Radeon graphics clock speed (profile method): low, mid, high, auto, default;
      # auto = mid on BAT, high on AC.
      # Default: default

      #RADEON_POWER_PROFILE_ON_AC=default
      #RADEON_POWER_PROFILE_ON_BAT=default

      # Radeon dynamic power management method (DPM): battery, performance.
      # Default: <none>

      #RADEON_DPM_STATE_ON_AC=performance
      #RADEON_DPM_STATE_ON_BAT=battery

      # Radeon DPM performance level: auto, low, high; auto is recommended.
      # Note: effective only when RADEON_DPM_STATE_ON_AC/BAT is activated.
      # Default: auto

      #RADEON_DPM_PERF_LEVEL_ON_AC=auto
      #RADEON_DPM_PERF_LEVEL_ON_BAT=auto

      # WiFi power saving mode: on=enable, off=disable; not supported by all adapters.
      # Default: off (AC), on (BAT)

      #WIFI_PWR_ON_AC=off
      #WIFI_PWR_ON_BAT=on

      # Disable wake on LAN: Y/N.
      # Default: Y

      #WOL_DISABLE=Y

      # Enable audio power saving for Intel HDA, AC97 devices (timeout in secs).
      # A value of 0 disables, >=1 enables power saving (recommended: 1).
      # Default: 0 (AC), 1 (BAT)

      #SOUND_POWER_SAVE_ON_AC=0
      #SOUND_POWER_SAVE_ON_BAT=1

      # Disable controller too (HDA only): Y/N.
      # Note: effective only when SOUND_POWER_SAVE_ON_AC/BAT is activated.
      # Default: Y

      #SOUND_POWER_SAVE_CONTROLLER=Y

      # Power off optical drive in UltraBay/MediaBay: 0=disable, 1=enable.
      # Drive can be powered on again by releasing (and reinserting) the eject lever
      # or by pressing the disc eject button on newer models.
      # Note: an UltraBay/MediaBay hard disk is never powered off.
      # Default: 0

      #BAY_POWEROFF_ON_AC=0
      #BAY_POWEROFF_ON_BAT=0

      # Optical drive device to power off
      # Default: sr0

      #BAY_DEVICE="sr0"

      # Runtime Power Management for PCI(e) bus devices: on=disable, auto=enable.
      # Default: on (AC), auto (BAT)

      #RUNTIME_PM_ON_AC=on
      #RUNTIME_PM_ON_BAT=auto

      # Exclude PCI(e) device adresses the following list from Runtime PM
      # (separate with spaces). Use lspci to get the adresses (1st column).
      # Default: <none>

      #RUNTIME_PM_BLACKLIST="bb:dd.f 11:22.3 44:55.6"

      # Exclude PCI(e) devices assigned to the listed drivers from Runtime PM.
      # Default when unconfigured is "amdgpu nouveau nvidia radeon" which
      # prevents accidential power-on of dGPU in hybrid graphics setups.
      # Separate multiple drivers with spaces.
      # Default: "amdgpu mei_me nouveau nvidia pcieport radeon", use "" to disable
      # completely.

      #RUNTIME_PM_DRIVER_BLACKLIST="amdgpu mei_me nouveau nvidia pcieport radeon"

      # Set to 0 to disable, 1 to enable USB autosuspend feature.
      # Default: 1

      #USB_AUTOSUSPEND=1

      # Exclude listed devices from USB autosuspend (separate with spaces).
      # Use lsusb to get the ids.
      # Note: input devices (usbhid) are excluded automatically
      # Default: <none>

      #USB_BLACKLIST="1111:2222 3333:4444"

      # Bluetooth devices are excluded from USB autosuspend:
      #   0=do not exclude, 1=exclude.
      # Default: 0

      #USB_BLACKLIST_BTUSB=0

      # Phone devices are excluded from USB autosuspend:
      #   0=do not exclude, 1=exclude (enable charging).
      # Default: 0

      #USB_BLACKLIST_PHONE=0

      # Printers are excluded from USB autosuspend:
      #   0=do not exclude, 1=exclude.
      # Default: 1

      #USB_BLACKLIST_PRINTER=1

      # WWAN devices are excluded from USB autosuspend:
      #   0=do not exclude, 1=exclude.
      # Default: 0

      #USB_BLACKLIST_WWAN=0

      # Include listed devices into USB autosuspend even if already excluded
      # by the blacklists above (separate with spaces). Use lsusb to get the ids.
      # Default: <none>

      #USB_WHITELIST="1111:2222 3333:4444"

      # Set to 1 to disable autosuspend before shutdown, 0 to do nothing
      # (workaround for USB devices that cause shutdown problems).
      # Default: 0

      #USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN=0

      # Restore radio device state (Bluetooth, WiFi, WWAN) from previous shutdown
      # on system startup: 0=disable, 1=enable.
      # Note: the parameters DEVICES_TO_DISABLE/ENABLE_ON_STARTUP/SHUTDOWN below
      #   are ignored when this is enabled.
      # Default: 0

      #RESTORE_DEVICE_STATE_ON_STARTUP=0

      # Radio devices to disable on startup: bluetooth, wifi, wwan.
      # Separate multiple devices with spaces.
      # Default: <none>

      #DEVICES_TO_DISABLE_ON_STARTUP="wwan"

      # Radio devices to enable on startup: bluetooth, wifi, wwan.
      # Separate multiple devices with spaces.
      # Default: <none>

      #DEVICES_TO_ENABLE_ON_STARTUP="wifi"

      # Radio devices to disable on shutdown: bluetooth, wifi, wwan.
      # (workaround for devices that are blocking shutdown).
      # Default: <none>

      #DEVICES_TO_DISABLE_ON_SHUTDOWN="bluetooth wifi wwan"

      # Radio devices to enable on shutdown: bluetooth, wifi, wwan.
      # (to prevent other operating systems from missing radios).
      # Default: <none>

      #DEVICES_TO_ENABLE_ON_SHUTDOWN="wwan"

      # Radio devices to enable on AC: bluetooth, wifi, wwan.
      # Default: <none>

      #DEVICES_TO_ENABLE_ON_AC="bluetooth wifi wwan"

      # Radio devices to disable on battery: bluetooth, wifi, wwan.
      # Default: <none>

      #DEVICES_TO_DISABLE_ON_BAT="bluetooth wifi wwan"

      # Radio devices to disable on battery when not in use (not connected):
      #   bluetooth, wifi, wwan.
      # Default: <none>

      #DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE="bluetooth"

      # Battery charge thresholds (ThinkPad only).
      # May require external kernel module(s), refer to the output of tlp-stat -b.
      # Charging starts when the remaining capacity falls below the
      # START_CHARGE_THRESH value and stops when exceeding the STOP_CHARGE_THRESH
      # value.

      # Main / Internal battery (values in %)
      # Default: <none>

      #START_CHARGE_THRESH_BAT0=75
      #STOP_CHARGE_THRESH_BAT0=80

      # Ultrabay / Slice / Replaceable battery (values in %)
      # Default: <none>

      #START_CHARGE_THRESH_BAT1=75
      #STOP_CHARGE_THRESH_BAT1=80

      # Restore charge thresholds when AC is unplugged: 0=disable, 1=enable.
      # Default: 0

      #RESTORE_THRESHOLDS_ON_BAT=1

      # Battery feature drivers: 0=disable, 1=enable
      # Default: 1 (all)

      #NATACPI_ENABLE=1
      #TPACPI_ENABLE=1
      #TPSMAPI_ENABLE=1

      # ------------------------------------------------------------------------------
      # tlp-rdw - Parameters for the radio device wizard

      # Possible devices: bluetooth, wifi, wwan.
      # Separate multiple radio devices with spaces.
      # Default: <none> (for all parameters below)

      # Radio devices to disable on connect.

      #DEVICES_TO_DISABLE_ON_LAN_CONNECT="wifi"
      #DEVICES_TO_DISABLE_ON_WIFI_CONNECT=""
      #DEVICES_TO_DISABLE_ON_WWAN_CONNECT=""


      # Radio devices to enable on disconnect.

      #DEVICES_TO_ENABLE_ON_LAN_DISCONNECT="wifi"
      #DEVICES_TO_ENABLE_ON_WIFI_DISCONNECT=""
      #DEVICES_TO_ENABLE_ON_WWAN_DISCONNECT=""

      # Radio devices to enable/disable when docked.

      #DEVICES_TO_ENABLE_ON_DOCK=""
      #DEVICES_TO_DISABLE_ON_DOCK="wifi"

      # Radio devices to enable/disable when undocked.

      #DEVICES_TO_ENABLE_ON_UNDOCK="wifi"
      #DEVICES_TO_DISABLE_ON_UNDOCK=""
    '';
  };
}
