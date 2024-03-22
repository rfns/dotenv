<p>
    <img src="https://img.shields.io/badge/Port-enabled-green.svg" height="18">
</p>

# dotenv

Almost every language has dotenv. So why not Caché?

Add the capability of reading environment variables from a .env file or straight from your running OS.

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
## What's new
Added dockerization of the project and the ability to publish it in IPM if the author makes an update.


## Installation with ZPM

If ZPM the current instance is not installed, then in one line you can install the latest version of ZPM.
```
zn "%SYS" d ##class(Security.SSLConfigs).Create("z") s r=##class(%Net.HttpRequest).%New(),r.Server="pm.community.intersystems.com",r.SSLConfiguration="z" d r.Get("/packages/zpm/latest/installer"),$system.OBJ.LoadStream(r.HttpResponse.Data,"c")
```
If ZPM is installed, then can be set with the command
```
zpm:USER>install dotenv
```
## Installation with Docker

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 
Clone/git pull the repo into any local directory

```
git clone https://github.com/rfns/dotenv
```

Open the terminal in this directory and run:

```
docker-compose build
```

3. Run the IRIS container with your project:

```
docker-compose up -d
```

## How to Test it
Open IRIS terminal:

```
docker-compose exec iris iris session iris
```
And execute commands from shell history
```
USER>set v = ##class(DotEnv.Parser).FromOS(,.env)

USER>zw env
env("CACHELIBPATH")=""
env("COMLIB")="/usr/irissys/bin"
env("HOME")="/home/irisowner"
...

USER>w v.GetAt("HOME")
/home/irisowner

USER>!env | grep HO
HOSTNAME=dde47b2be44e
HOME=/home/irisowner

```

## CONTRIBUTING

Got some idea? Follow this [guide](https://github.com/rfns/dotenv/blob/master/CONTRIBUTING.md).

## LICENSE

[MIT](https://github.com/rfns/dotenv/blob/master/LICENSE).
