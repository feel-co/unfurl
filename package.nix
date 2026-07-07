{
  lib,
  buildNimPackage,
  pandoc,
}:
let
  fs = lib.fileset;
in
buildNimPackage (finalAttrs: rec {
  pname = "unfurl";
  version = "0.0.1";

  src = fs.toSource {
    root = ./.;
    fileset = (
      fs.fileFilter (
        file:
        builtins.any file.hasExt [
          "md"
          "nim"
          "nimble"
        ]
      ) ./.
    );
  };

  nativeBuildInputs = [
    pandoc
  ];

  postBuild = ''
    pandoc -s -o ${finalAttrs.pname}.1 doc/${pname}.man1.md
  '';

  postInstall = ''
    install -Dm644 ${finalAttrs.pname}.1 -t "$out/share/man/man1/"
  '';

  meta = {
    description = "unfurl";
    homepage = "https://github.com/feel-co/unfurl";
    license = lib.licenses.cc-by-nc-sa-40;
    mainProgram = pname;
    platforms = with lib.platforms; linux ++ darwin;
  };
})
