{ lib
, buildPythonApplication
, fetchFromGitHub
, hatchling
, typer
, rich
, httpx
, platformdirs
, readchar
, truststore
, ...
}:

buildPythonApplication rec {
  pname = "spec-kit";
  version = "0.1.10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "github";
    repo = "spec-kit";
    rev = "v${version}";
    hash = "sha256-iJ8O2W3o0iWneIrT3xNH8yYxkajuUoXuW3a3OBfEaNc=";
  };

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    typer
    rich
    httpx
    platformdirs
    readchar
    truststore
  ];

  pythonImportsCheck = [ "specify_cli" ];

  meta = with lib; {
    description = "Toolkit to help you get started with Spec-Driven Development";
    homepage = "https://github.com/github/spec-kit";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "specify";
    broken = lib.versionOlder truststore.version "0.10.4";
  };
}
