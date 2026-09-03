{ ... }:
{
  flake.homeModules.xdg-mimes =
    {
      lib,
      pkgs,
      ...
    }:
    with lib;
    let
      defaultApps = {
        audio = [ "mpv.desktop" ];
        browser = [ "firefox.desktop" ];
        directory = [ "nemo.desktop" ];
        discord = [ "webcord.desktop" ];
        image = [ "imv-dir.desktop" ];
        office = [ "libreoffice.desktop" ];
        terminal = [ "kitty.desktop" ];
        video = [ "mpv.desktop" ];
      };

      mimeMap = {
        audio = [
          "audio/aac"
          "audio/mpeg"
          "audio/ogg"
          "audio/opus"
          "audio/wav"
          "audio/webm"
          "audio/x-matroska"
        ];
        browser = [
          "text/html"
          "x-scheme-handler/about"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/unknown"
        ];
        directory = [ "inode/directory" ];
        discord = [ "x-scheme-handler/discord" ];
        image = [
          "image/bmp"
          "image/gif"
          "image/jpeg"
          "image/jpg"
          "image/png"
          "image/svg+xml"
          "image/tiff"
          "image/vnd.microsoft.icon"
          "image/webp"
        ];
        office = [
          "application/vnd.oasis.opendocument.text"
          "application/vnd.oasis.opendocument.spreadsheet"
          "application/vnd.oasis.opendocument.presentation"
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          "application/vnd.openxmlformats-officedocument.presentationml.presentation"
          "application/msword"
          "application/vnd.ms-excel"
          "application/vnd.ms-powerpoint"
          "application/rtf"
        ];
        terminal = [ "terminal" ];
        video = [
          "video/mp2t"
          "video/mp4"
          "video/mpeg"
          "video/ogg"
          "video/webm"
          "video/x-flv"
          "video/x-matroska"
          "video/x-msvideo"
        ];
      };

      associations =
        with lists;
        listToAttrs (
          flatten (mapAttrsToList (key: map (type: attrsets.nameValuePair type defaultApps."${key}")) mimeMap)
        );
    in
    {
      home.packages = with pkgs; [ junction ];
      home.sessionVariables = {
        # prevent wine from creating file associations
        WINEDLLOVERRIDES = "winemenubuilder.exe=d";
      };
      xdg.configFile."mimeapps.list".force = true;
      xdg.mimeApps.associations.added = associations;
      xdg.mimeApps.defaultApplications = associations;
      xdg.mimeApps.enable = true;
    };
}
