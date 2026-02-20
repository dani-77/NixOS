{
  description = "Flake local para o pwm";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      rustPlatform = pkgs.rustPlatform;
    in {
      packages.${system}.default = rustPlatform.buildRustPackage {
        pname = "pwm";
        version = "0.2.0";
        src = ./.;
        cargoLock.lockFile = ./Cargo.lock;

        nativeBuildInputs = with pkgs; [ pkg-config ];
        buildInputs = with pkgs; [
          # Core X11 (com xorg. prefixo para nixos-25.11)
          xorg.libX11
          xorg.libXrandr
          xorg.libXinerama
          xorg.libXft
          xorg.libXrender
          xorg.libXext
          # Fontconfig para Xft
          fontconfig
          freetype
          # Para tracing
          xorg.libxcb
        ];
      };

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/pwm";
      };

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          rustc cargo rust-analyzer pkg-config
        ];
        buildInputs = with pkgs; [
          xorg.libX11 xorg.libXrandr xorg.libXinerama 
          xorg.libXft xorg.libXrender xorg.libXext
          fontconfig freetype xorg.libxcb
        ];
	postInstall = ''
  	mkdir -p $out/etc/xdg/pwm
  	cp ${./etc/xdg/pwm/startup.sh} $out/etc/xdg/pwm/startup.sh
  	chmod +x $out/etc/xdg/pwm/startup.sh
	'';
      };
    };
}
