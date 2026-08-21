{ ... }:

{
  programs.brave-origin = {
    enable = true;
    
    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    ];
  };
}
