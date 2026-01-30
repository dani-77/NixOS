{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    # Standard .config/directory
    configs = {
        alacritty = "alacritty";
        awesome = "awesome";
        kitty = "kitty";
        nvim = "nvim";
        qtile = "qtile";
        redshift = "redshift";
        rofi = "rofi";
        xmobar = "xmobar";
        xmonad = "xmonad";
    };
in

{
  home.username = "dani77";
  home.homeDirectory = "/home/dani77";
  programs.git.enable = true;
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
	abiword
	arc-theme
	ast-grep
        brightnessctl
     	dunst
	fd
     	feh
	fzf
  	gcc
	github-cli
	gnumeric
	ghostscript
	gmrun
	haskell-language-server
	imagemagick
     	jgmenu
	kitty
	lazygit
	lua51Packages.lua
	luajitPackages.luarocks_bootstrap
	neofetch
  	neovim
  	nil
  	nixpkgs-fmt
  	nodejs
	papirus-icon-theme
  	pcmanfm
	redshift
  	ripgrep
  	rofi
	scrot
	slstatus
	stylua
	tectonic
	thunderbird
	unzip
	vimPlugins.LazyVim
	xautolock
	xcompmgr
	xmobar
  ];

    xdg.configFile = builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
    }) configs;

  imports = [
    ./modules/suckless.nix
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
    };
  };
}
