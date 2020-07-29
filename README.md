<p>
    <img src="https://img.shields.io/badge/Port-enabled-green.svg" height="18">
</p>

# dotenv

Almost every language has dotenv. So why not Caché?

Add the capability of reading environment variables from a .dotenv file or straight from your running OS.

## Installing

The easiest way is to simply import the released XML from [here](https://github.com/rfns/dotenv/releases/download/v1.0.0/dotenv-v1.0.0.xml)

## Usage

Quick and easy:

* If you want to read from your OS use `##class(DotEnv.Parser).FromOS()`
* If you want to read from a file use `##class(DotEnv.Parser).FromPath("path/to/file", .status, ".env-prod")`

Each method returns an %ArrayOfDataTypes instance populated with your env variables. 

> __NOTE:__ When using `FromPath`, any of the existing ones won't be overwritten. Do NOT include the file name when passing the path to this method. Use the third parameter for that instead: (path, status code, file name). The default file name is `.env`.

## Format

.env files should be composed using the following format:

```
YOUR_VARIABLE="your value"
YOUR_NUMBER=1337
WHATEVER="you want, it\'s also \nescaped"
```

## CONTRIBUTING

Got some idea? Follow this [guide](https://github.com/rfns/dotenv/blob/master/CONTRIBUTING.md).

If you want to run those tests you must have [Port](https://github.com/rfns/port) installed since it uses a different mechanism for running them straight from your repository folder.

## LICENSE

[MIT](https://github.com/rfns/dotenv/blob/master/LICENSE).
