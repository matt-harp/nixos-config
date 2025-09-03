{ 
  inputs,
  config,
  lib,
  username,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options = {
    user.persist = {
      files = lib.mkOption {
        description = "Additional User Files to Preserve";
        type = lib.types.listOf lib.types.str;
        default = [ ];
        example = [ ".bash_history" ];
      };

      directories = lib.mkOption {
        description = "Additional User Directories to Preserve";
        type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
        default = [ ];
        example = [ "Downloads" ];
      };
    };
  };

  config = {
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/private/ollama" # todo move to ollama module
      ];
      files = [
        "/etc/machine-id"
      ];

      users.${username} = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "projects"
          "nixos-config"
        ]
        ++ config.user.persist.directories;

        files = [] ++ config.user.persist.files;
      };
    };

    boot.initrd = {
      enable = true;
      supportedFilesystems = [ "btrfs" ];

      postResumeCommands = lib.mkAfter ''
        mkdir -p /mnt

        # We first mount the btrfs root to /mnt
        # so we can manipulate btrfs subvolumes.
        mount -o subvol=/ /dev/disk/by-label/nixos /mnt

        # Delete all subvolumes under /root (deepest first)
        btrfs subvolume list -o /mnt/root |
          awk '{print $NF}' |
          tac |
          while read subvolume; do
            echo "Deleting /$subvolume..."
            btrfs subvolume delete "/mnt/$subvolume"
          done &&
          echo "deleting /root subvolume..." &&
          btrfs subvolume delete /mnt/root

        echo "Restoring blank /root..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root

        # for whatever reason I can't figure out this needs to be remade.
        # just dont put anything in /root for now
        rmdir /mnt/root/root
        mkdir /mnt/root/root

        # Once we're done rolling back to a blank snapshot,
        # we can unmount /mnt and continue on the boot process.
        umount /mnt
      '';
    };

    security.sudo.extraConfig = ''
      # rollback results in sudo lectures after each reboot
      Defaults lecture = never
    '';
  };
}
