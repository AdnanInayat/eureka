
#!/bin/bash
args=("$@")

function goto
{
label=$1
cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
eval "$cmd"
exit
}

@#  ----------------------------------------------------------------------------
@#  Licensed to the Apache Software Foundation (ASF) under one
@#  or more contributor license agreements.  See the NOTICE file
@#  distributed with this work for additional information
@#  regarding copyright ownership.  The ASF licenses this file
@#  to you under the Apache License, Version 2.0 (the
@#  "License"); you may not use this file except in compliance
@#  with the License.  You may obtain a copy of the License at
@REM
@#     http://www.apache.org/licenses/LICENSE-2.0
@REM
@#  Unless required by applicable law or agreed to in writing,
@#  software distributed under the License is distributed on an
@#  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@#  KIND, either express or implied.  See the License for the
@#  specific language governing permissions and limitations
@#  under the License.
@#  ----------------------------------------------------------------------------

@#  ----------------------------------------------------------------------------
@#  Maven2 Start Up Batch script
@REM
@#  Required ENV vars:
@#  JAVA_HOME - location of a JDK home dir
@REM
@#  Optional ENV vars
@#  M2_HOME - location of maven2's installed home dir
@#  MAVEN_BATCH_ECHO - set to 'on' to enable the echoing of the batch commands
@#  MAVEN_BATCH_PAUSE - set to 'on' to wait for a key stroke before ending
@#  MAVEN_OPTS - parameters passed to the Java VM when running Maven
@#      e.g. to debug Maven itself, use
@#  set MAVEN_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000
@#  MAVEN_SKIP_RC - flag to disable loading of mavenrc files
@#  ----------------------------------------------------------------------------

@#  Begin all #  lines with '@' in case MAVEN_BATCH_ECHO is 'on'
#@echo off
@#  set title of command window
title $0
@#  enable echoing my setting MAVEN_BATCH_ECHO to 'on'
@if  "$MAVEN_BATCH_ECHO" = "on"  echo $MAVEN_BATCH_ECHO

@#  set %HOME% to equivalent of $HOME


@#  Execute a user defined script before this one
if  [ ! "$MAVEN_SKIP_RC"  =  "" ]
then
goto skipRcPre
fi

@#  check for pre script, once with legacy .bat ending and once with .cmd ending
if  exist "$HOME\mavenrc_pre.bat" call "$HOME\mavenrc_pre.bat"
if  exist "$HOME\mavenrc_pre.cmd" call "$HOME\mavenrc_pre.cmd"

goto skipRcPre
skipRcPre:


@setlocal

export  ERROR_CODE=0

@#  To isolate internal variables from possible post scripts, we use another setlocal
@setlocal

@#  ==== START VALIDATION ====
if  [ ! "$JAVA_HOME"  =  "" ]
then
goto OkJHome
fi


echo 
echo Error: JAVA_HOME not found in your environment. >&2
echo Please export  the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo 
goto error


goto OkJHome
OkJHome:

if  exist "$JAVA_HOME\bin\java.exe" goto init

echo 
echo Error: JAVA_HOME is export  to an invalid directory. >&2
echo JAVA_HOME = "$JAVA_HOME" >&2
echo Please export  the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo 
goto error

@#  ==== END VALIDATION ====


goto init
init:


@#  Find the project base dir, i.e. the directory that contains the folder ".mvn".
@#  Fallback to current working directory if not found.

export  MAVEN_PROJECTBASEDIR=$MAVEN_BASEDIR
if  [ ! "$MAVEN_PROJECTBASEDIR" = "" ]
then
goto endDetectBaseDir
fi


export  EXEC_DIR=$CD
export  WDIR=$EXEC_DIR

goto findBaseDir
findBaseDir:

if  EXIST "$WDIR"\.mvn goto baseDirFound
cd ..
if  [ "$WDIR" = "$CD" ]
then
 goto baseDirNotFound
fi

export  WDIR=$CD
goto findBaseDir


goto baseDirFound
baseDirFound:

export  MAVEN_PROJECTBASEDIR=$WDIR
cd "$EXEC_DIR"
goto endDetectBaseDir


goto baseDirNotFound
baseDirNotFound:

export  MAVEN_PROJECTBASEDIR=$EXEC_DIR
cd "$EXEC_DIR"


goto endDetectBaseDir
endDetectBaseDir:


if  !  EXIST "$MAVEN_PROJECTBASEDIR\.mvn\jvm.config" goto endReadAdditionalConfig

@setlocal EnableExtensions EnableDelayedExpansion
for /F "usebackq delims=" $a in ("$MAVEN_PROJECTBASEDIR\.mvn\jvm.config") do export  JVM_CONFIG_MAVEN_PROPS=!JVM_CONFIG_MAVEN_PROPS! $a
@endlocal & export  JVM_CONFIG_MAVEN_PROPS=$JVM_CONFIG_MAVEN_PROPS


goto endReadAdditionalConfig
endReadAdditionalConfig:


export  MAVEN_JAVA_EXE="$JAVA_HOME\bin\java.exe"
export  WRAPPER_JAR="$MAVEN_PROJECTBASEDIR\.mvn\wrapper\maven-wrapper.jar"
export  WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

export  DOWNLOAD_URL="https://repo.maven.apache.org/maven2/io/takari/maven-wrapper/0.4.2/maven-wrapper-0.4.2.jar"
FOR /F "tokens=1,2 delims=" $A IN ($MAVEN_PROJECTBASEDIR\.mvn\wrapper\maven-wrapper.properties) DO (
	if  [ "$A" = "wrapperUrl" ]
then
 export  DOWNLOAD_URL=$B 
fi

)

@#  Extension to allow automatically downloading the maven-wrapper.jar from Maven-central
@#  This allows using the maven wrapper in projects that prohibit checking in binary data.
if  exist $WRAPPER_JAR (
    echo Found $WRAPPER_JAR
) else (
    echo Couldn't find $WRAPPER_JAR, downloading it ...
	echo Downloading from: $DOWNLOAD_URL
    powershell -Command "(New-Object Net.WebClient).DownloadFile('$DOWNLOAD_URL', '$WRAPPER_JAR')"
    echo Finished downloading $WRAPPER_JAR
)
@#  End of extension

$MAVEN_JAVA_EXE $JVM_CONFIG_MAVEN_PROPS $MAVEN_OPTS $MAVEN_DEBUG_OPTS -classpath $WRAPPER_JAR "-Dmaven.multiModuleProjectDirectory=$MAVEN_PROJECTBASEDIR" $WRAPPER_LAUNCHER $MAVEN_CONFIG $*
if  ERRORLEVEL 1 goto error
goto end


goto error
error:

export  ERROR_CODE=1


goto end
end:

@endlocal & export  ERROR_CODE=$ERROR_CODE

if  [ ! "$MAVEN_SKIP_RC"  =  "" ]
then
goto skipRcPost
fi

@#  check for post script, once with legacy .bat ending and once with .cmd ending
if  exist "$HOME\mavenrc_post.bat" call "$HOME\mavenrc_post.bat"
if  exist "$HOME\mavenrc_post.cmd" call "$HOME\mavenrc_post.cmd"

goto skipRcPost
skipRcPost:


@#  pause the script if MAVEN_BATCH_PAUSE is set to 'on'




exit /B $ERROR_CODE