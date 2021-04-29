{ config, lib, pkgs, ... }:

let
  kernel = pkgs.linuxPackages_4_19.kernel;
in
{ 
  mobile.device.name = "trekstor-breeze";
  mobile.device.info = rec {
    inherit kernel;
    kernel_file = "${kernel}/bzImage";
    format_version = "0";
    name = "Trekstor SurfTab Breeze 9.6 Quad";
    manufacturer = "Trekstor";
    date = "";
    modules_initfs = "";
    arch = "x86_64";
    keyboard = false;
    external_storage = true;
    screen_width = "1280";
    screen_height = "800";
    dev_touchscreen = "";
    dev_touchscreen_calibration = "";
    dev_keyboard = "";
    flash_method = "fastboot";
    # kernel_cmdline = "androidboot.hardware=qcom ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 androidboot.selinux=permissive";
    kernel_cmdline = "lpm_levels.sleep_disabled=1";
    generate_bootimg = true;
    bootimg_qcdt = false;
    flash_offset_base = "0x10000000";
    flash_offset_kernel = "0x00008000";
    flash_offset_ramdisk = "0x02000000";
    flash_offset_second = "0x00f00000";
    flash_offset_tags = "0x00000100";
    flash_pagesize = "2048";
    pm_name = "trekstor-breeze";

    # TODO : make kernel part of options.
    dtb = "";
  };
  mobile.hardware = {
    # This could also be pre-built option types?
    soc = "generic-x86_64";
    ram = 1024 * 1;
    screen = {
      width = 1280; height = 800;
    };
  };

  mobile.system.type = "android";
}
