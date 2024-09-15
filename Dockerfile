FROM ubuntu:20.04

WORKDIR /mnt/workspace

# Install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git curl build-essential pkg-config \
    libudev-dev llvm libclang-dev \
    protobuf-compiler libssl-dev

# Install nodejs, rustup, and solana
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash && apt-get install -y nodejs
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y && \
    curl -sSf https://release.anza.xyz/v1.18.23/install | sh

# Pin rust version 1.78.0 to avoid type error: https://github.com/rust-lang/rust/issues/127343
# Install avm and anchor
ENV PATH="${PATH}:/root/.cargo/bin:/root/.local/share/solana/install/active_release/bin:/root/.avm/bin/"
RUN rustup default 1.78.0 && \
    cargo install --git https://github.com/coral-xyz/anchor avm --locked --force && \
    avm install 0.30.1 && \
    avm use 0.30.1
