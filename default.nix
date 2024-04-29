{
  sources ? import ./nix/sources.nix,
  system ? builtins.currentSystem,
  pkgs ?
    import sources.nixpkgs {
      overlays = [];
      config = {};
      inherit system;
    },
}: let
  DiffDetective =
    import (builtins.fetchGit {
      url = "https://github.com/VariantSync/DiffDetective.git";
      rev = "4adc0b84a390ea138f48dbb98918b9d2317bb896";
      ref = "develop";
      shallow = true;
    }) {
      inherit sources;
      inherit system;
      buildGitHubPages = false;
    };
in
  pkgs.maven.buildMavenPackage rec {
    pname = "DiffDetective-Demo";
    # The single source of truth for the version number is stored in `pom.xml`.
    # Hence, this XML file needs to be parsed to extract the current version.
    version = pkgs.lib.removeSuffix "\n" (pkgs.lib.readFile
      (pkgs.runCommandLocal "DiffDetective-version" {}
        "${pkgs.xq-xml}/bin/xq -x '/project/version' ${./pom.xml} > $out"));

    src = with pkgs.lib.fileset;
      toSource {
        root = ./.;
        fileset = gitTracked ./.;
      };

    mvnHash = "sha256-dw/CXrUj6AW6yhLsloZX5F9O2edsaj3SaigKTPHidSs=";

    mvnFetchExtraArgs = {
      preBuild = ''
        echo "Build dir: $out/.m2"
        mkdir -p $out/.m2
        # Copy the DiffDetective.jar into this build folder because Maven fails
        # when an absolute path is provided.
        cp ${DiffDetective}/share/java/DiffDetective/DiffDetective.jar .
        mvn deploy:deploy-file -e -Durl=file:$out/.m2 -Dmaven.repo.local=$out/.m2 -Dfile=./DiffDetective.jar -Dversion=${DiffDetective.version} -DgroupId=org.variantsync -DartifactId=diffdetective

        # Fix the reproducibility issues of `mvn deploy:deploy-file`
        for f in $(find $out/.m2 -name '*.xml')
        do
          sed -i '/lastUpdated/ c\    <lastUpdated>2</lastUpdated>' "$f"
          if [ -f "$f.md5" ]
          then
            md5sum "$f" | cut -f 1 -d ' ' > "$f.md5"
          fi
          if [ -f "$f.sha1" ]
          then
            sha1sum "$f" | cut -f 1 -d ' ' > "$f.sha1"
          fi
        done
      '';
    };

    nativeBuildInputs = [pkgs.makeWrapper];

    postInstall = ''
      local jar="$out/share/java/DiffDetective-Demo.jar"
      install -Dm644 "target/diffdetectivedemo-${version}-jar-with-dependencies.jar" "$jar"
      makeWrapper "${pkgs.jdk}/bin/java" "$out/bin/DiffDetective-Demo" \
        --add-flags "-cp '$jar' org.variantsync.diffdetectivedemo.Main" \
        --prefix PATH : "${pkgs.graphviz}/bin"
    '';

    meta.mainProgram = "DiffDetective-Demo";
  }
