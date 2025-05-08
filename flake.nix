{
  description = "Amazon Q Developer CLI flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "amazon-q-cli";
          version = "1.0.0"; # Replace with actual version

          src = pkgs.fetchzip {
            url =
              "https://desktop-release.q.us-east-1.amazonaws.com/latest/q-x86_64-linux.zip";
            hash = "sha256-tjK8pvxHe1h07Ps0X2jFV95kATOICCwXnF+yLPqbaLM=";
          };

          nativeBuildInputs = with pkgs; [ autoPatchelfHook makeWrapper ];

          buildInputs = with pkgs; [ glibc zlib openssl stdenv.cc.cc.lib ];

          installPhase = ''
            mkdir -p $out
            cp -r * $out/
            wrapProgram $out/bin/q \
              --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bash ]}
          '';

          meta = with pkgs.lib; {
            description = "Amazon Q Developer CLI";
            homepage = "https://aws.amazon.com/q/";
            license = licenses.unfree;
            platforms = platforms.linux;
          };
        };

        apps.default =
          flake-utils.lib.mkApp { drv = self.packages.${system}.default; };
      });
}
