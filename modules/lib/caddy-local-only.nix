{
  upstream,
  allowedIPs ? [
    "192.168.0.0/24"
    "fd69:dead:beef:2::/64"
    "10.69.69.0/24"
    "127.0.0.1/8"
    "::1"
  ],
}:

''
  @allowed remote_ip ${builtins.concatStringsSep " " allowedIPs}

  handle @allowed {
    reverse_proxy ${upstream}
  }

  handle {
    respond "Forbidden" 403
  }
''
