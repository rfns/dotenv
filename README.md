<p>
    <img src="https://img.shields.io/badge/Port-enabled-green.svg" height="18">
</p>

# dotenv

Almost every language has dotenv. So why not Caché?

Add the capability of reading environment variables from a .dotenv file or straight from your running OS.

## Installing

The easiest way is to simply import the [dotenv.xml](https://github.com/rfns/dotenv/blob/master/dotenv.xml) provided.

## Usage

Quick and easy:

* If you want to read from your OS use `##class(DotEnv.Parser).FromOS()`
* If you want to read from a file use `##class(DotEnv.Parser).FromPath()`

Each method returns an %ArrayOfDataTypes instance populated with your env variables. When using `FromPath`, existing ones aren't overwritten.

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
