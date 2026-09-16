{ pkgs, ... }:

{
  environment.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.ncurses}/lib:${pkgs.stdenv.cc.cc.lib}/lib";
  };

  environment.systemPackages = [
    (pkgs.unityhub.override {
      extraPkgs = fhsPkgs: with fhsPkgs; [
        harfbuzz
        libogg
        ncurses
        stdenv.cc.cc
        libGL
        libglvnd
        vulkan-loader
      ];
    })
  ];
}