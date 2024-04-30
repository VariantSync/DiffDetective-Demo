{
  outputs = inputs: rec {
      packages.x86_64-linux.default = packages.x86_64-linux.DiffDetective.data-wrapper;
      packages.x86_64-linux.DiffDetective = import inputs.self {system = "x86_64-linux";};
  };
}
