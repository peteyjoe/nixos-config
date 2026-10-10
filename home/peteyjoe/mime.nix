{ ... }:

{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Video
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];

      # Audio
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];
      "audio/ogg" = [ "mpv.desktop" ];
      "audio/opus" = [ "mpv.desktop" ];
      "audio/x-wav" = [ "mpv.desktop" ];

      # Images
      "image/jpeg" = [ "ristretto.desktop" ];
      "image/png" = [ "ristretto.desktop" ];
      "image/gif" = [ "ristretto.desktop" ];
      "image/webp" = [ "ristretto.desktop" ];
      "image/svg+xml" = [ "ristretto.desktop" ];
      "image/tiff" = [ "ristretto.desktop" ];
      "image/avif" = [ "ristretto.desktop" ];
      "image/heif" = [ "ristretto.desktop" ];
    };
  };
}
