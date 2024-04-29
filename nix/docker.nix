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
      paths = [ (DiffDetectiveDemo.src + "/data") ];
      extraPrefix = config.WorkingDir + "/data";
    };

    runAsRoot = ''
      mkdir -p /etc/fonts

      cat >/etc/fonts/fonts.conf <<"EOF"
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <description>Configuration file</description>
        <dir>${pkgs.dejavu_fonts}/share/fonts</dir>
        <cachedir>/var/cache/fontconfig</cachedir>
      </fontconfig>
      EOF

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
