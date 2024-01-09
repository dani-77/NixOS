# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only

  networking.hostName = "lt1000"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_PT.UTF-8";
  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "pt-latin1";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.setupCommands = ''
${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --mode "1920x1080"
'';
  
  # Configure keymap in X11
  services.xserver.xkb.layout = "pt";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dani77 = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ steam firefox thunderbird ranger feh cmus mpv htop nextcloud-client st dmenu (st.overrideAttrs (oldAttrs: rec { 
	patches = [
     (fetchpatch { 
	url = "http://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff";
	sha256 = "10gvwnpbjw49212k25pddji08f4flal0g9rkwpvkay56w8y81r22";
	})
      (fetchpatch { 
 	url = "http://st.suckless.org/patches/dracula/st-dracula-0.8.5.diff";
	sha256 = "0ldy43y2xa8q54ci6ahxa3iimfb4hmjsbclkmisx0xjr88nazzhz";
	})	
    ];
  }))
];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  nixpkgs.config = {
  allowUnfree = true;
};
  services.flatpak.enable = true;  
  services.pcscd.enable = true;
  services.compton.enable = true;
  #services.picom = {
#		enable = true;
#		backend = "glx";
#		fade = true;
#		settings = {
#			blur = { 
#				method = "dual_kawase";
 #   			        size = 20;
  # 			 	deviation = 5.0;
  #			};
#		};
#		inactiveOpacity = 0.8;
#	};
# Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}
