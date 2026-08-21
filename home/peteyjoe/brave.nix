{ ... }:

{
  programs.brave-origin = {
    enable = true;

    commandLineArgs = [
      "--enable-features=Vulkan"
    ];

    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    ];
  };
}
