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
    # kernel.package = pkgs.callPackage pkgs.linuxPackages_latest { };
    # kernel.package = pkgs.linux_5_11;
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
  mobile.boot.stage-1.compression = lib.mkDefault "gzip";

  boot.kernelParams = [
    "sched_enable_hmp=1"
#    "console=ttyHSL0,115200,n8"
    "lpm_levels.sleep_disabled=1"
    "androidboot.selinux=permissive"
#    "androidboot.console=ttyHSL0"
    "androidboot.hardware=qcom"
    "msm_rtb.filter=0x237"
    "ehci-hcd.park=3"
    "androidboot.bootdevice=7824900.sdhci"
    "movablecore=160M"
    "vmalloc=400M"
    "buildvariant=eng"
    "mdss_mdp.panel=1:dsi:0:qcom,mdss_dsi_mot_tianma_497_1080p_video_v0"
  ];


  mobile.system.vendor.partition = "/dev/disk/by-partlabel/vendor";
  mobile.system.type = "android";

  mobile.quirks.qualcomm.fb-notify.enable = true;
#  mobile.quirks.qualcomm.dwc3-otg_switch.enable = true;
  mobile.quirks.qualcomm.wcnss-wlan.enable = false;
  mobile.boot.stage-1.crashToBootloader = true;

  mobile.usb.mode = "android_usb";
  mobile.usb.idVendor  = "22B8"; # Motorola
  mobile.usb.idProduct = "2E81"; # "Moto G"

#  mobile.usb.gadgetfs.functions = {
   #  rndis = "rndis_bam.rndis";
#    adb = "ffs.adb";
#  };

}
