import std/[parseopt, strformat, strscans]

proc showHelp() =
  stderr.writeLine("TBI") # TODO implement
  quit()

var
  optParser = initOptParser(shortNoVal = {'h', 'v'}, longNoVal = @["help", "verbose"])
  argCount = 0
  argUrl = ""
  cleanUrl: string
  optVerbose: bool

for kind, key, val in optParser.getopt():
  case kind
  of cmdArgument:
    # TODO logic here with `key`
    argUrl = key
    inc argCount
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": showHelp()
    of "verbose", "v":
      optVerbose = true
  of cmdEnd: discard # impossible


var
  branch, owner, pr, preTag, repo: string

if scanf(argUrl, "$+#", preTag):
  cleanUrl = preTag
else:
  cleanUrl = argUrl

if scanf(cleanUrl, "https://github.com/$+/$+/tree/$+", owner, repo, branch):
  echo &"github:{owner}/{repo}?ref={branch}"
elif scanf(cleanUrl, "https://github.com/$+/$+/pull/$+", owner, repo, pr):
  echo &"github:{owner}/{repo}/refs/pull/{pr}/head"
elif scanf(cleanUrl, "https://github.com/$+/$+", owner, repo):
  echo &"github:{owner}/{repo}"
