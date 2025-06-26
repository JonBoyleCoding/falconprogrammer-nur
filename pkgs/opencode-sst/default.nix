{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchzip,
  autoPatchelfHook,
}: let
  arch_string = platform:
    if platform == "x86_64-linux"
    then "linux-x64"
    else if platform == "aarch64-linux"
    then "linux-arm64"
    else if platform == "x86_64-darwin"
    then "darwin-x64"
    else if platform == "aarch64-darwin"
    then "darwin-arm64"
    else throw "Unsupported architecture: ${platform}";
in
  stdenv.mkDerivation rec {
    pname = "opencode";
    version = "0.1.141";

    src = fetchzip {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-${arch_string stdenv.hostPlatform.system}.zip";
      hash = "sha256-bCr3V7nSPwM/pJmZXh0Q7wqdyYZDfeCFf1/gTw3CyD0=";
    };

    dontBuild = true;
    dontStrip = true;

    nativeBuildInputs = [autoPatchelfHook];

    installPhase = ''
      runHook preInstall
      ls
      mkdir -p $out/bin
      cp opencode $out/bin/
      chmod +x $out/bin/opencode
      runHook postInstall
    '';

    meta = {
      description = "AI coding agent, built for the terminal";
      homepage = "https://github.com/sst/opencode";
      license = lib.licenses.mit;
      mainProgram = "opencode";
      platforms = lib.platforms.all;
    };
  }
