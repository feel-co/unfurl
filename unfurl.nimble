version       = "0.0.1"
author        = "éclairevoyant"
description   = "unfurl"
license       = "CC-by-nc-sa-4.0"
srcDir        = "src"
bin           = @["unfurl"]

requires "nim >= 2.2.0"

task release, "Release build":
  exec "nimble build -d:release --opt:speed"
  exec "pandoc -s -o unfurl.1 doc/unfurl.man1.md"
