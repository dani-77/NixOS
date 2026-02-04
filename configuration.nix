{ config, lib, pkgs, ... }:

{ imports =
    [
      ./hardware-configuration.nix ];

  boot.loader.grub.enable = true; boot.loader.grub.device = "/dev/sda";

  networking.hostName = "loki-btw";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "pt_PT.UTF-8"; console = {
    keyMap = "pt-latin1";
  };

  services.displayManager.ly.enable = true; 
  services.xserver = {
	enable = true; 
	windowManager.qtile = {
		enable = true; 
		extraPackages = python3Packages: with python3Packages; [
			qtile-extras
			];
	};
	windowManager.oxwm.enable = true; 
	windowManager.awesome.enable = true; 
	windowManager.xmonad = { 
		enable = true; 
		enableContribAndExtras = true; 
		extraPackages = hpkgs: [
          		hpkgs.xmonad hpkgs.xmonad-extras hpkgs.xmonad-contrib
        		];
      	};
  };
  

  services.xserver.xkb.layout = "pt";

  services.printing.enable = true;

  # services.pulseaudio.enable = true; OR
  services.pipewire = { enable = true; pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.dani77 = { isNormalUser = true; extraGroups = [ "wheel" "networkmanager" "audio"]; packages = with pkgs; [
      tree
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  fonts.packages = with pkgs; [ hack-font nerd-fonts.symbols-only nerd-fonts.iosevka nerd-fonts.jetbrains-mono font-awesome
  ];

  environment.systemPackages = with pkgs; [ alacritty alsa-tools alsa-utils git nwg-look udiskie vim wget xdg-user-dirs xdg-user-dirs-gtk
  ];

  programs.gnupg.agent = { enable = true; enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.pcscd.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall 
  # altogether. networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; system.stateVersion = "25.11";

}

