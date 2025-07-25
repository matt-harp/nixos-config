{ ... }:
{
  programs.ssh = {
    enable = true;

    # use 1password for SSH keys
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
      '';
  };
}