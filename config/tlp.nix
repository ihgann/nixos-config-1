{
  services.tlp = {
    enable = true;
    extraConfig = /* config */ ''
      CPU_SCALING_GOVERNOR_ON_AC=performance
      CPU_SCALING_GOVERNOR_ON_BAT=powersave

      CPU_SCALING_MIN_FREQ_ON_AC=800000
      CPU_SCALING_MAX_FREQ_ON_AC=4800000
      CPU_SCALING_MIN_FREQ_ON_BAT=400000
      CPU_SCALING_MAX_FREQ_ON_BAT=3000000

      CPU_HWP_ON_AC=balance_performance
      CPU_HWP_ON_BAT=power

      CPU_MIN_PERF_ON_AC=0
      CPU_MAX_PERF_ON_AC=100
      CPU_MIN_PERF_ON_BAT=0
      CPU_MAX_PERF_ON_BAT=50

      CPU_BOOST_ON_AC=1
      CPU_BOOST_ON_BAT=0

      SCHED_POWERSAVE_ON_AC=0
      SCHED_POWERSAVE_ON_BAT=1

      ENERGY_PERF_POLICY_ON_AC=performance
      ENERGY_PERF_POLICY_ON_BAT=powersave

      PCIE_ASPM_ON_AC=default
      PCIE_ASPM_ON_BAT=powersave

      START_CHARGE_THRESH_BAT0=75
      STOP_CHARGE_THRESH_BAT0=80
      
      START_CHARGE_THRESH_BAT1=75
      STOP_CHARGE_THRESH_BAT1=80
      
      DEVICES_TO_DISABLE_ON_DOCK="wifi wwan"
      DEVICES_TO_ENABLE_ON_UNDOCK="wifi"
    '';
  };
}
