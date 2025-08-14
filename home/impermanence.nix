{ username, ... }:
{
  home.persistence."/persist/home/${username}" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "nixos-config"
    ];
    files = [];
    allowOther = true;
  };
}
