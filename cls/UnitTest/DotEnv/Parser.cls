Class UnitTest.DotEnv.Parser Extends Port.UnitTest.TestCase
{

Method TestFromOS()
{
  set envs = ##class(DotEnv.Parser).FromOS()
  do $$$AssertTrue($isobject(envs) && envs.%IsA("%ArrayOfDataTypes"), "returns an %ArrayOfDataTypes")

  do $$$AssertTrue(envs.Count() > 0, "parsed envs from host OS")
}

Method TestFromPath()
{

  set envs = ##class(DotEnv.Parser).FromPath(..GetTestDirectory("../fixtures"))
  do $$$AssertTrue($isobject(envs) && envs.%IsA("%ArrayOfDataTypes"), "returns an %ArrayOfDataTypes")

  do $$$AssertTrue($isobject(envs) && envs.%IsA("%ArrayOfDataTypes") && envs.Count() > 0, "returns an array containing var names and values")
  set envsFromOS = ##class(DotEnv.Parser).FromOS()

#if $$$isWINDOWS
  do $$$AssertTrue(envs.GetAt("Path") = envsFromOS.GetAt("Path"), "never overwrites existing variables")
#else
  // UNIX
  do $$$AssertTrue(envs.GetAt("PATH") = envsFromOS.GetAt("PATH"), "never overwrites existing variables")
#endif

  do $$$AssertTrue(envs.GetAt("DOTENV_HELLO") = "Hello from "".env""", "parses escaped strings")
  do $$$AssertTrue(envs.GetAt("DOTENV_NUMBER_TEST") = 1234, "parses numbers")
}

}

