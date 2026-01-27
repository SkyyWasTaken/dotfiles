{
  description = "Dev environment for VRChat avatar creation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = (pkgs.buildFHSEnv {
          name = "vrc-unity-env";
          targetPkgs = pkgs: with pkgs; [
            unityhub
            alcom

            # Unity Hub ldd dependencies
            cups
            gtk3
            expat
            libxkbcommon
            lttng-ust_2_12
            krb5
            alsa-lib
            nss
            libdrm
            libgbm
            nspr
            atk
            dbus
            at-spi2-core
            pango
            xorg.libXcomposite
            xorg.libXext
            xorg.libXdamage
            xorg.libXfixes
            xorg.libxcb
            xorg.libxshmfence
            xorg.libXScrnSaver
            xorg.libXtst

            # Unity Hub additional dependencies
            libva
            openssl
            cairo
            libnotify
            libuuid
            libsecret
            udev
            libappindicator
            wayland
            cpio
            icu
            libpulseaudio

            # Unity Editor dependencies
            libglvnd # provides ligbl
            xorg.libX11
            xorg.libXcursor
            xorg.libXrandr
            glib
            gdk-pixbuf
            libxml2_13
            zlib
            clang
            git # for git-based packages in unity package manager

            # Unity Editor 6000 specific dependencies
            harfbuzz
            vulkan-loader

            # Unity Bug Reporter specific dependencies
            xorg.libICE
            xorg.libSM

            # Fonts used by built-in and third party editor tools
            corefonts
            dejavu_fonts
            liberation_ttf
          ];
          runScript = "bash";
        }).env;
      }
    );
}