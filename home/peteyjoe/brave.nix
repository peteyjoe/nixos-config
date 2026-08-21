{ ... }:

{
  programs.brave-origin = {
    enable = true;

    commandLineArgs = [
      "--enable-unsafe-webgpu"
      "--use-webgpu-adapter=opengles"
      "--use-webgpu-power-preference=force-high-performance"
    ];

    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
    ];
  };
}
