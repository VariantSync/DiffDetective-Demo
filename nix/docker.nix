{
  sources ? import ./sources.nix,
  system ? builtins.currentSystem,
  pkgs ?
    import sources.nixpkgs {
      overlays = [];
      config = {};
      inherit system;
    },
}: let
  DiffDetectiveDemo = import ../default.nix {};
in {
  esecfse24 = pkgs.dockerTools.buildImage rec {
    name = "DiffDetective-Demo";
    tag = DiffDetectiveDemo.version;

    copyToRoot = pkgs.buildEnv {
      name = "DiffDetective-Demo-image-root";
      paths = [(DiffDetectiveDemo.src + "/data")];
      extraPrefix = config.WorkingDir + "/data";
    };

    runAsRoot = ''
      install -Dm644 ${import ./fontconfig.nix {inherit sources system pkgs;}} /etc/fonts/fonts.conf
      mkdir -p /var/cache/fontconfig
      ${pkgs.fontconfig}/bin/fc-cache
    '';

    config = {
      Cmd = ["${DiffDetectiveDemo}/bin/DiffDetective-Demo"];
      WorkingDir = "/home/user";
      Env = [
        "DISPLAY=:0"
        "HOME=/home/user"
      ];
    };
  };
}
