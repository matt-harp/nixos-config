{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ jetbrains.rider jetbrains.clion ];

  user.persist.directories = [ ".cache/JetBrains" ".config/JetBrains" ];
}