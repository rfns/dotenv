Class UnitTest.DotEnv.Parser Extends %UnitTest.TestCase
{

Method TestFromOS()
{
  set envs = ##class(DotEnv.Parser).FromOS()
  do $$$AssertTrue($isobject(envs) && envs.%IsA("%ArrayOfDataTypes"), "returns an %ArrayOfDataTypes")

  do $$$AssertTrue(envs.Count() > 0, "parsed envs from host OS")
}

}

