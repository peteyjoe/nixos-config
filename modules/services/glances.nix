{ ... }:

{
  services.glances = {
    enable = true;

    extraArgs = [
      "--webserver"
      "--bind"
      "127.0.0.1"
      "--port"
      "29606"
    ];
  };
}
