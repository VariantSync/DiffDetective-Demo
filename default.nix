{
  system ? builtins.currentSystem,
  pkgs ?
    import (builtins.fetchTarball {
      name = "sources";
      url = "https://github.com/nixos/nixpkgs/archive/6832d0d99649db3d65a0e15fa51471537b2c56a6.tar.gz";
      sha256 = "1ww2vrgn8xrznssbd05hdlr3d4br6wbjlqprys1al8ahxkyl5syi";
    }) {
      config = {};
      modules = [];
      inherit system;
    },
  TrueDiffDetective ?
    import (builtins.fetchTarball {
      name = "TrueDiffDetective";
      url = "https://github.com/VariantSync/TrueDiffDetective/archive/a0943a74947bf3e9e070084ae41d07d9d713cbba.tar.gz";
      sha256 = "1vl0lsjzcmvyjid3790g7i3nybpyddllb7jbv4s8y2x23b7x42dr";
    }) {
      inherit system pkgs;
    },
  doCheck ? true,
  dependenciesHash ? "sha256-rB6izXdtsq6GEvNPZBGz3AJze3n6zEhWVDQzkijUsJY=",
}:
pkgs.stdenvNoCC.mkDerivation rec {
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

  nativeBuildInputs = with pkgs; [
    maven
    makeWrapper
    graphviz
  ];

  mavenRepo = pkgs.stdenv.mkDerivation {
    pname = "${pname}-mavenRepo";
    inherit version;
    src = pkgs.lib.sourceByRegex ./. ["^pom.xml$" "^local-maven-repo(/.*)?$"];

    nativeBuildInputs = with pkgs; [maven];

    buildPhase = ''
      runHook preBuild

      # make a mutable copy of the input maven repository
      cp -L -r ${TrueDiffDetective.maven} "$out"
      chmod u+w -R "$out"

      mvn org.apache.maven.plugins:maven-dependency-plugin:3.6.0:go-offline -Dmaven.repo.local="$out"

      runHook postBuild
    '';

    # Keep only *.{pom,jar,sha1,nbm} and delete all ephemeral files with lastModified timestamps inside.
    installPhase = ''
      runHook preInstall

      find "$out" -type f \
        \( -not \( -name "*.pom" -o -name "*.jar" -o -name "*.sha1" -o -name "*.nbm" \) \
            -o -name "maven-metadata*" \) \
        -delete

      runHook postInstall
    '';

    dontFixup = true;
    dontConfigure = true;
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = dependenciesHash;
  };

  # - `out` contains jars, an executable wrapper and optionally documentation
  #   (see `buildGitHubPages`)
  # - `maven` contains a local maven repository with DiffDetective and all its
  #   build-time and run-time dependencies.
  outputs = ["out" "maven"];

  buildPhase = ''
    runHook preBuild

    mvn --offline -Dmaven.repo.local="$mavenRepo" -Dmaven.test.skip=true clean package

    runHook postBuild
  '';

  inherit doCheck;
  checkPhase = ''
    runHook preTest

    mvn --offline -Dmaven.repo.local="$mavenRepo" test

    runHook postTest
  '';

  installPhase = ''
    runHook preInstall

    # install jars in "$out"
    install -Dm644 "target/diffdetectivedemo-${version}.jar" "$out/share/java/diffdetectivedemo.jar"

    local jar="$out/share/java/DiffDetective-Demo/DiffDetective-Demo.jar"
    install -Dm644 "target/diffdetectivedemo-${version}-jar-with-dependencies.jar" "$jar"
    makeWrapper "${pkgs.jdk17}/bin/java" "$out/bin/DiffDetective-Demo" \
      --add-flags "-cp \"$jar\" org.variantsync.diffdetectivedemo.Main" \
      --prefix PATH : "${pkgs.graphviz}/bin"

    # install DiffDetective-Demo in "$maven" by creating a copy of "$mavenRepo" as base
    cp -r "$mavenRepo" "$maven"
    chmod u+w -R "$maven"
    mvn --offline -Dmaven.repo.local="$maven" -Dmaven.test.skip=true install

    # keep only *.{pom,jar,sha1,nbm} and delete all ephemeral files with lastModified timestamps inside
    find "$maven" -type f \
      \( -not \( -name "*.pom" -o -name "*.jar" -o -name "*.sha1" -o -name "*.nbm" \) \
          -o -name "maven-metadata*" \) \
      -delete

    runHook postInstall
  '';

  meta = {
    description = "A demo of DiffDetective, a library for analysing changes to software product lines";
    homepage = "https://github.com/VariantSync/DiffDetectiveDemo";
    license = pkgs.lib.licenses.lgpl3;
    platforms = pkgs.maven.meta.platforms;
    maintainers = [
      {
        name = "Benjamin Moosherr";
        email = "Benjamin.Moosherr@uni-ulm.de";
        github = "ibbem";
        githubId = 61984399;
      }
    ];
  };
}
