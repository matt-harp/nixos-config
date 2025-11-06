{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];

  user.persist.directories = [
    ".cache/JetBrains"
    ".config/JetBrains"
    ".local/share/JetBrains"
    ".java/.userPrefs/jetbrains/" # wtf?
  ];
}
