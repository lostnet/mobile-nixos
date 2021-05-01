{
  mobile-nixos
, stdenv
, fetchFromGitHub
, ...
}:

#
# Note:
# This kernel build is special, it supports both armv7l and aarch64.
# This is because motorola ships an armv7l userspace from stock ROM.
#
# in local.nix:
#  mobile.system.system = lib.mkForce "armv7l-linux";
#

mobile-nixos.kernel-builder-gcc6 {
  version = "3.18.140-lineage";
  configfile = ./. + "/config.${stdenv.hostPlatform.parsed.cpu.name}";

  src = fetchFromGitHub {
    owner = "LineageOS";
    repo = "android_kernel_motorola_msm8937";
    rev = "24639793cfec156b39ed3527bbf8ed39282bdb7f"; # lineage-16
    sha256 = "0pnbpj92rkzmzcq4hddq4p3bbsd7gh2f0agm6nk3fmv5a0p2r8aa";
  };

  patches = [
    ./04_fix_camera_msm_isp.patch
    ./05_misc_msm_fixes.patch
    ./06_prima_gcc6.patch
#    ./07_otghub.patch
    ./99_framebuffer.patch
    ./0001-Allow-building-WCD9335_CODEC-without-REGMAP_ALLOW_WR.patch
    ./0005-Allow-building-with-sound-disabled.patch
  ];

  enableRemovingWerror = true;
  isModular = false;
  isQcdt = true;
}
