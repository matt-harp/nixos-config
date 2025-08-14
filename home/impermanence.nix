{ username, ... }:
{
  home.persistence."/persist/home/${username}" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
    ];
    files = [];
    allowOther = true;
  }
}