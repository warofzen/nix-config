{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto";
      ao = "pipewire";
    };
  };
}
