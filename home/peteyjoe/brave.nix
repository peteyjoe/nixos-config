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
      "--enable-unsafe-webgpu"
      #"--use-webgpu-adapter=vulkan"
      #"--disable-software-rasterizer"
      "--enable-features=Vulkan"
      "--use-angle=vulkan"
    ];

    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    ];
  };
}
