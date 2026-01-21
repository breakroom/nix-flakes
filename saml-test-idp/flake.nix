{
  description = "saml-test-idp - A test SAML identity provider";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule (finalAttrs: {
          pname = "saml-test-idp";
          version = "0.1.0-0d67d16";

          src = pkgs.fetchFromGitHub {
            owner = "breakroom";
            repo = "saml-test-idp";
            rev = "0d67d16e60109d9dc1f539296efc0c842d58a6d4";
            hash = "sha256-1OfHqG0TrmC0+Bdh3UX/v88reDHCeo6r4P2SJlgTifM=";
          };

          subPackages = [ "cmd/saml-test-idp" ];
          ldflags = [ "-s" "-w" ];
          vendorHash = "sha256-a4cWLtbfI9NSpg6DRX0VDY84R/XmadCJ8exk2m5c794=";

          meta = with pkgs.lib; {
            description = "A test SAML identity provider";
            homepage = "https://github.com/breakroom/saml-test-idp";
            license = licenses.mit;
            mainProgram = "saml-test-idp";
          };
        });

        packages.saml-test-idp = self.packages.${system}.default;
      }
    );
}
