# Amazon Q Developer CLI for Nix

This repository provides a Nix flake for the Amazon Q Developer CLI, making it easy to install and use Amazon Q in Nix environments.

## What is Amazon Q?

Amazon Q Developer is an AI-powered assistant designed to help developers build on AWS. It can help with code generation, debugging, AWS service recommendations, and more.

## Features

- Installs the Amazon Q Developer CLI in a Nix environment
- Handles all dependencies automatically
- Works on NixOS and other Linux distributions with Nix installed

## Requirements

- Nix package manager with flakes enabled
- Linux x86_64 system

## Installation

### Using this flake directly

```bash
# Run Amazon Q directly
nix run github:mpontus/amazon-q-nix

# Or install it to your profile
nix profile install github:mpontus/amazon-q-nix
```

### Adding to your own flake

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    amazon-q-nix.url = "github:mpontus/amazon-q-nix";
  };

  outputs = { self, nixpkgs, amazon-q-nix, ... }:
    {
      # Use in your outputs
      # amazon-q-nix.packages.${system}.default
    };
}
```

## Usage

After installation, you can use the Amazon Q CLI:

```bash
q chat
```

For more information on using Amazon Q, refer to the [official documentation](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is-q-developer.html).

## How it works

This flake:
1. Downloads the official Amazon Q Developer CLI binary from AWS
2. Uses autoPatchelfHook to handle library dependencies
3. Wraps the binary to ensure it has access to required runtime dependencies

## License

The Amazon Q Developer CLI is proprietary software owned by Amazon Web Services.
This Nix packaging is provided under [your chosen license].

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
