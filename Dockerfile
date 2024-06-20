FROM ubuntu:20.04

WORKDIR /mnt/workspace

# Install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git curl build-essential pkg-config \
    libudev-dev llvm libclang-dev \
    protobuf-compiler libssl-dev

# Install nodejs, rust, and solana
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash && apt-get install -y nodejs
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y && \
    curl -sSf https://release.solana.com/stable/install | sh

# Install anchor and avm, pin solana version
ENV PATH="${PATH}:/root/.cargo/bin:/root/.local/share/solana/install/active_release/bin:/root/.avm/bin/"
RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force && \
    solana-install-init 1.18.17 && \
    avm install 0.29.0 && \
    avm use 0.29.0 && \
    rustup default stable
