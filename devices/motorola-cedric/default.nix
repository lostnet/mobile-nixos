{ config, lib, pkgs, ... }:

{
  mobile.device.name = "motorola-cedric";
  mobile.device.identity = {
    name = "Moto G5";
    manufacturer = "Motorola";
  };

  mobile.hardware = {
    soc = "qualcomm-msm8937";
    ram = 1024 * 2;
    screen = {
      width = 1080; height = 1920;
    };
  };

  mobile.boot.stage-1 = {
    kernel.package = pkgs.callPackage ./kernel { };
  };

  # mobile.device.firmware = pkgs.callPackage ./firmware {};

  mobile.system.android.device_name = "cedric";
  mobile.system.android.bootimg = {
    flash = {
      offset_base = "0x80000000";
      offset_kernel = "0x00008000";
      offset_ramdisk = "0x01000000";
      offset_second = "0x00f00000";
      offset_tags = "0x00000100";
      pagesize = "2048";
    };
  };

  # Using `xz` allows us to fit the kernel + dt + initrd in 16MiB
  #   Kernel: ~8.8M
  #   DT:      1.2M
  # We're left with ~6MB for the compressed initrd.
  mobile.boot.stage-1.compression = lib.mkDefault "gz";

  boot.kernelParams = [
    "sched_enable_hmp=1"
    "androidboot.hardware=qcom"
    "ehci-hcd.park=3"
    "androidboot.bootdevice=7824900.sdhci"
    "movablecore=160M"
    "vmalloc=400M"
    "buildvariant=eng"
    "mdss_mdp.panel=1:dsi:0:qcom,mdss_dsi_mot_tianma_497_1080p_video_v0"
  ];

  mobile.usb.mode = "android_usb";
  # Google
  mobile.usb.idVendor = "18D1";
  # "Nexus 4"
  mobile.usb.idProduct = "D001";

  mobile.system.type = "android";

  mobile.quirks.qualcomm.fb-notify.enable = true;

  mobile.quirks.qualcomm.wcnss-wlan.enable = true;
  mobile.boot.stage-1.crashToBootloader = true;

}
