{ pkgs, headless, isWSL, ... }:

{
  programs.git = {
    enable = true;
    userName = "Matt Harper";
    userEmail = "matt.harper3415@gmail.com";
    extraConfig = if (!headless) then {
      gpg = {
        format = "ssh";
        "ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9lKc1FkgIqa0hlBObrFQI9FEHgivL1CQdXbhTeoOJt";
      };
    }
    else if isWSL then {
      core.sshCommand = "ssh.exe";
      
      gpg = {
        format = "ssh";
        "ssh".program = "/mnt/c/Users/matt/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9lKc1FkgIqa0hlBObrFQI9FEHgivL1CQdXbhTeoOJt";
      };
    }
    else {};
  };
}
