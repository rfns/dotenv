Include %occStatus

Class DotEnv.Parser [ Abstract ]
{

ClassMethod FromOS(Output sc As %Status = {$$$OK}) As %ArrayOfDataTypes
{
  set command = ##class(DotEnv.Command).%New()
  set sc = command.CaptureEnvsFromHostOS(.output)
  quit ..CreateArray(output)
}

ClassMethod FromPath(path As %String, Output sc As %Status = {$$$OK}, dotenv As %String = ".env") As %ListOfDataTypes
{
  #dim dotEnvs, envs As %ArrayOfDataTypes

  set envs = ..FromOS(.sc)
  if $$$ISERR(sc) return envs
  set fs = ##class(%Stream.FileCharacter).%New()
  set sc = fs.LinkToFile(path_"//"_dotenv)
  set dotEnvs = ..CreateArray(fs)
  set envName = ""

  for i=1:1:dotEnvs.Count() {
    set envName = dotEnvs.Next(envName)
    set envValue = dotEnvs.GetAt(envName)

    if 'envs.IsDefined(envName) {
      set sc = envs.SetAt(envValue, envName)
      if $$$ISERR(sc) quit
    }
  }
  quit envs
}

ClassMethod CreateArray(out As %Stream.Object) As %ArrayOfDataTypes [ Internal ]
{
  set envs = ##class(%ArrayOfDataTypes).%New()
  if '$isobject(out) quit envs

  while 'out.AtEnd {
    set line = out.ReadLine()
    continue:line=""
    set envName = $piece(line, "=")
    set envValue = $piece(line, "=", 2, *)
    if $extract(envValue) = $char(34) && ($extract(envValue, *) = $char(34)) {
      set envValue = $zconvert($extract(envValue, 2, *-1), "I", "JS")
    }
    do envs.SetAt(envValue, envName)
  }
  quit envs
}

}

