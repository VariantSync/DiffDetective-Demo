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

RUN nix-shell -p dos2unix --run 'find . -exec dos2unix {} +'

# Build the DiffDetective demo. This also all dependencies (e.g., DiffDetective
# itselves) using the default nix binary cache.
RUN nix-build

# Copy DiffDetective with all runtime dependencies (ignoring build-time
# dependencies) to a separate folder. Such a subset of the Nix store is called a
# closure and enables us to create a minimal Docker container.
RUN mkdir closure
RUN nix-store -qR result | xargs cp -Rt closure

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

ENV DISPLAY=:0 HOME=/home/user
CMD ["/DiffDetective/bin/DiffDetective-Demo"]
