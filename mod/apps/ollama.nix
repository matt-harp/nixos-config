{
  user.persist.directories = [ ".ollama/models" ];

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    rocmOverrideGfx = "12.0.1";
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1201";
    };

    loadModels = [ "llama3.1:8b" ];
  };
}