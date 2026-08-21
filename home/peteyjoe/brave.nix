{ ... }:

{
  programs.brave-origin = {
    enable = true;

    commandLineArgs = [
      "--enable-unsafe-webgpu"
      "--use-webgpu-adapter=opengles"
    ];

    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    ];
  };
}
