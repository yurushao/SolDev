# SolDev

A container image with all essential Solana dev tools installed.

The current release pins:

- nodejs v20
- solana 1.18.18
- anchor 0.29.0

To use the image:

```
$ docker pull ghcr.io/yurushao/soldev:release
```

We use the same tags to track upstream solana releases https://github.com/solana-labs/solana/releases. If you'd like to use a specfic solana version (for example v1.18.18), you can do:

```
$ docker pull ghcr.io/yurushao/soldev:v1.18.18
```
