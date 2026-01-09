{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Matt Harper";
        email = "matt.harper3415@gmail.com";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9lKc1FkgIqa0hlBObrFQI9FEHgivL1CQdXbhTeoOJt";
      };
      gpg = {
        format = "ssh";
        "ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
      commit = {
        gpgsign = true;
      };
    };
  };
}
