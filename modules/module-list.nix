# Keep sorted, <nixpkgs> imports first.
[
  <nixpkgs/nixos/modules/misc/nixpkgs.nix>
  <nixpkgs/nixos/modules/misc/assertions.nix>
  ./boot-initrd.nix
  ./hardware-qualcomm.nix
  ./hardware-screen.nix
  ./hardware-soc.nix
  ./initrd-framebuffer.nix
  ./initrd-network.nix
  ./initrd-splash-late.nix
  ./initrd-splash.nix
  ./initrd-ssh.nix
  ./mobile-device.nix
  ./quirks-qualcomm.nix
  ./system-build.nix
  ./system-types.nix
]