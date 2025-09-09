{ inputs, pkgs, ... }:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      #settings = {
      #  General = {
      #	 Enable = "Source,Sink,Media,Socket";
      #  };
      #};
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu = {
      # load the amdgpu driver earlier
      initrd.enable = true;

      # rocm clr drivers
      opencl.enable = true;

      # additional Vulkan drivers for AMD
      amdvlk.enable = true;
    };
  };

  environment.variables = {
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
  };
}