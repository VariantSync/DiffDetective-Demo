# syntax=docker/dockerfile:1

# We use Nix to build DiffDetective.
FROM nixos/nix:2.22.0 AS builder

# Create and navigate to a working directory
WORKDIR /home/user

# Copy all of the source code into the working directory. Impurities like
# additional files and previous build results will be filtered by Nix. Note that
# All files which are considered *tracked* by Git will be used for the build,
# even if they are modified.
COPY . .

# Patch Windows line endings if the repository was cloned on Windows.
RUN nix-shell -p dos2unix --run 'find . -exec dos2unix {} +'

# Build the DiffDetective demo. This also all dependencies (e.g., DiffDetective
# itselves) using the default nix binary cache.
RUN nix-build

# Build required fonts and their cache.
RUN mkdir -p /etc/fonts && nix-build nix/fontconfig.nix --out-link /etc/fonts/fonts.conf
RUN mkdir -p /var/cache/fontconfig && nix-shell -p fontconfig --run fc-cache

# We need `cp` to copy out the jar.
RUN nix-build '<nixpkgs>' -A coreutils -o coreutils

# Copy DiffDetective with all runtime dependencies (ignoring build-time
# dependencies) to a separate folder. Such a subset of the Nix store is called a
# closure and enables us to create a minimal Docker container.
RUN mkdir closure
RUN nix-store -qR result /etc/fonts/fonts.conf coreutils | xargs cp -Rt closure

# Start building the final container.
FROM scratch

# Create another working directory for runtime files (e.g., cloned repositories).
WORKDIR /home/user

# Copy DiffDetective (it's runtime closure) to the final container.
COPY --from=builder /home/user/closure /nix/store

# Copy the Symlink to the DiffDetective derivation, mostly for convenience.
COPY --from=builder /home/user/result /DiffDetective

# Copy the necessary data. Beware that this directory might have impure files.
COPY data /home/user/data

# Install fonts
COPY --from=builder /etc/fonts/fonts.conf /etc/fonts/fonts.conf
COPY --from=builder /var/cache/fontconfig /var/cache/fontconfig

# Install `cp`
COPY --from=builder /home/user/coreutils/bin/cp /bin/cp

ENV DISPLAY=:0 HOME=/home/user
CMD ["/DiffDetective/bin/DiffDetective-Demo"]
