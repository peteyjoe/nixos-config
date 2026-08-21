{ pkgs, ... }:

{
  programs.brave-origin = {
    enable = true;

    package = pkgs.brave-origin.override {
      # Make NixOS's Vulkan driver environment visible to Brave.
      vulkanSupport = true;

      # Don't force the whole browser/compositor onto Vulkan yet.
      enableVulkan = false;
    };

    commandLineArgs = [
      "--ozone-platform=x11"
      "--enable-unsafe-webgpu"
      "--use-gl=angle"
      "--use-angle=vulkan"
      "--enable-features=AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"

      #"--use-webgpu-adapter=vulkan"
      #"--disable-software-rasterizer"
      #"--enable-features=Vulkan"
      #"--use-angle=vulkan"
    ];

    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    ];
  };
}
