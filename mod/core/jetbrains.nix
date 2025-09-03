{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.rider
    jetbrains.clion
  ];

  user.persist.directories = [
    ".cache/JetBrains"
    ".config/JetBrains"
    ".local/share/JetBrains"
    ".java/.userPrefs/jetbrains/" # wtf?
  ];
}
