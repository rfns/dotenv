Class UnitTest.DotEnv.Command Extends Port.UnitTest.TestCase
{

Property Command As DotEnv.Command;

Method OnBeforeOneTest() As %Status
{
  set ..Command = ##class(DotEnv.Command).%New()
  quit $$$OK
}

Method OnAfterOnTest() As %Status
{
  set ..Command = ""
  quit $$$OK
}

Method TestErrorFilePath()
{
  do $$$AssertTrue(..Command.OutputFilePath '= "", "generates a temp file for errors")
}

Method TestOutputFilePath()
{
  do $$$AssertTrue(..Command.ErrorFilePath '= "", "generates a output file for command logs")
}

Method TestOnCloseDeleteTempFiles()
{
  set errorFilePath = ..Command.ErrorFilePath
  set outputFilePath = ..Command.OutputFilePath
  
  set ..Command = ""
  
  do $$$AssertNotTrue(errorFilePath '= "" && ##class(%File).Exists(errorFilePath), "deletes error temp file")
  do $$$AssertNotTrue(outputFilePath '= "" && ##class(%File).Exists(outputFilePath), "deletes output temp file")
}

Method TestCaptureEnvsFromHostOS()
{
  do $$$AssertStatusOK(..Command.CaptureEnvsFromHostOS(), "normally doesn't return an error")
  do ..Command.CaptureEnvsFromHostOS(.output)
  
  do $$$AssertTrue($isobject(output) && output.%Extends("%Stream.Object") && output.Size > 0, "returns a stream containg env variables")
}

}

