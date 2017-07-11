Include (%occOptions, %occStatus)

Class DotEnv.Command Extends %RegisteredObject
{

Property ErrorFilePath As %String;

Property OutputFilePath As %String;

Method %OnNew() As %Status
{
  set ..ErrorFilePath = ##class(%File).TempFilename()
  set ..OutputFilePath = ##class(%File).TempFilename()
  quit $$$OK
}

Method %OnClose() As %Status
{
  set sc = $$$OK
  set sc = $$$ADDSC(sc, ##class(%File).Delete(..ErrorFilePath))
  set sc = $$$ADDSC(sc, ##class(%File).Delete(..OutputFilePath))
  quit sc
}

Method CaptureEnvsFromHostOS(Output outputBuffer As %Stream.Object = "") As %Status [ Internal ]
{
  set commmandString = ""
  
  if $$$isWINDOWS {
    set commmandString = $$$FormatText("set 2> ""%1"" > ""%2""", ..ErrorFilePath, ..OutputFilePath)
  } elseif $$$isUNIX {
    set commmandString = $$$FormatText("printenv 2> ""%1"" > ""%2""", ..ErrorFilePath, ..OutputFilePath)
  }
  
  do $zf(-1, commmandString)
  
  set outputBuffer = ##class(%FileCharacterStream).%New()  
  set outputBuffer.Filename = ..OutputFilePath
  
  set errorBuffer = ##class(%FileCharacterStream).%New()  
  set errorBuffer.Filename = ..ErrorFilePath 
  
  if outputBuffer.Size = 0 quit $$$ERROR(5001, "Unable to execute OS command, failed due to: "_errorBuffer.Read())
  
  quit $$$OK
}

}

