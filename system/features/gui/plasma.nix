{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ../hardware/audio.nix
  ];

  services = {
    xserver.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
  ];
}
