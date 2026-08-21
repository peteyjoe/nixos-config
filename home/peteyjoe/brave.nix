{ ... }:

{
  programs.brave-origin = {
    enable = true;

    commandLineArgs = [
      "--enable-unsafe-webgpu"
      "--enable-features=Vulkan"
    ];

    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    ];
  };
}
