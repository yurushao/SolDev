FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git curl build-essential pkg-config \
    libudev-dev llvm libclang-dev \
    protobuf-compiler libssl-dev \
    libpixman-1-dev libcairo2-dev libpango1.0-dev libjpeg8-dev libgif-dev
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash && apt-get install -y nodejs

WORKDIR /mnt/workspace

RUN curl -sSf https://sh.rustup.rs | sh -s -- -y && \
    curl -sSf https://release.solana.com/stable/install | sh

ENV PATH="${PATH}:/root/.cargo/bin:/root/.local/share/solana/install/active_release/bin:/root/.avm/bin/"
RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
RUN solana-install-init 1.18.11 && avm install 0.29.0 && avm use 0.29.0