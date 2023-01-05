@echo on
REM Please adjust CUP_HOME to suit your needs
REM (please do not add a trailing backslash)

set CUP_HOME=C:\cup
set CUP_VERSION=11b
set PARSER_CLASS_NAME = "MPParser"
set CUP_SPEC_NAME = "MPParser.cup"


java -Xmx128m -jar "%CUP_HOME%\lib\java-cup-%CUP_VERSION%.jar" %*
