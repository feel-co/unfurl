import std/[parseopt,strformat,strscans]

proc showHelp() =
  stderr.writeLine("TBI") # TODO implement
  quit()

var
  optParser = initOptParser(shortNoVal = {'h', 'v'}, longNoVal = @["help", "verbose"])
  argCount = 0
  argUrl = ""
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
  branch, owner, pr, repo: string
if scanf(argUrl, "https://github.com/$+/$+/tree/$+", owner, repo, branch):
  echo &"github:{owner}/{repo}?ref={branch}"
elif scanf(argUrl, "https://github.com/$+/$+/pull/$+", owner, repo, pr):
  echo &"github:{owner}/{repo}/refs/pull/{pr}/head"
elif scanf(argUrl, "https://github.com/$+/$+", owner, repo):
  echo &"github:{owner}/{repo}"
