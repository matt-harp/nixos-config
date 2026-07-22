{
  inputs,
  pkgs,
  config,
  lib,
  username,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ]; # conditional imports are a bad idea

  options = {
    system.impermanent = lib.mkEnableOption "Impermanence";
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

  config = lib.mkIf config.system.impermanent {
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
          "nixos-config"
        ]
        ++ config.user.persist.directories;

        files = [ ] ++ config.user.persist.files;
      };
    };

    users.users.${username}.hashedPasswordFile = "/persist/passwords/${username}";
    users.users.root.hashedPasswordFile = "/persist/passwords/root";

    boot.initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "btrfs" ];
  
      systemd.services.rollback = {
        description = "Rollback Btrfs root subvolume to a pristine state";
        
        # Essential ordering for systemd initrd
        after = [ "initrd-root-device.target" ];
        before = [ "sysroot.mount" ];
        wants = [ "initrd-root-device.target" ];
        wantedBy = [ "initrd.target" ];
  
        # Explicitly pull in necessary binaries for the sparse initrd environment
        path = [ pkgs.coreutils pkgs.btrfs-progs pkgs.gawk pkgs.util-linux ];
  
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          Script = ''
            mkdir -p /mnt
  
            # Mount the btrfs root to /mnt to manipulate subvolumes
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
  
            # Fix the nested root directory
            rmdir /mnt/root/root
            mkdir /mnt/root/root
  
            # Unmount and clean up
            umount /mnt
          '';
        };
      };
    };

    security.sudo.extraConfig = ''
      # rollback results in sudo lectures after each reboot
      Defaults lecture = never
    '';
  };
}
