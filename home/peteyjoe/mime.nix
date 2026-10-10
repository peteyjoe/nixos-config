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
      "image/jpeg" = [ "org.xfce.ristretto.desktop" ];
      "image/png" = [ "org.xfce.ristretto.desktop" ];
      "image/gif" = [ "org.xfce.ristretto.desktop" ];
      "image/webp" = [ "org.xfce.ristretto.desktop" ];
      "image/svg+xml" = [ "org.xfce.ristretto.desktop" ];
      "image/tiff" = [ "org.xfce.ristretto.desktop" ];
      "image/avif" = [ "org.xfce.ristretto.desktop" ];
      "image/heif" = [ "org.xfce.ristretto.desktop" ];
    };
  };
}
