{
  sources ? import ./sources.nix,
  system ? builtins.currentSystem,
  pkgs ?
    import sources.nixpkgs {
      overlays = [];
      config = {};
      inherit system;
    },
}:
pkgs.writeTextFile {
  name = "fonts.conf";
  text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <description>Configuration file</description>
      <dir>${pkgs.dejavu_fonts}/share/fonts</dir>
      <cachedir>/var/cache/fontconfig</cachedir>
    </fontconfig>
  '';
}
