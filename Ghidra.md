# Ghidra

## Tricks

### Statically compiled libs

To identify functions from libraries that are statically compiled with the
program.

#### How to identify them
- Googling strings in the methods will usually lead you to the source code or at
    least will tell you the name of lib.
- searching for strings in the binary with the lib name sometimes gives you the
    version of the lib.
- Download the source code for that version and then find the name of the
    relevant functions.


#### Finding the compiled binary

- Usually they are provided by the system's package system. In that case try to
    download the same version
- In case of MacOS, more often they are from Homebrew.
  - Go to the formula's repo: https://github.com/Homebrew/homebrew-core
  - Find the formula for the lib.
  - Go to history and find the version corresponding to the version with which
      the binary is compiled.
  - Find the SHA of the bottle for that version
  - Download the bottle, ref: https://stackoverflow.com/a/69858397
  - Extract the compiled lib from the tar file.

#### Function ID

Ref:
https://github.com/NationalSecurityAgency/ghidra/blob/master/Ghidra/Features/FunctionID/src/main/doc/fid.xml

This is an automatic way, but I haven't been able to make it work.

- Find the compiled library
- Load the lib into Ghidra and analyze it in CodeBrowser
- In the CodeBrowser, select Tools->Function ID->Create new empty FidDb menu.
- Fill in the details.
- Open the our binary which we are analysing in CodeBrowser
- Select Analysis->One Shot->Function ID

#### Manually finding the function
- Try to find a function with some string.
- Search the string in the source code or the library loaded in Ghidra.
- If the library is loaded in Ghidra, we can also manually compare the function
    body to be sure if we have the binary that we want.
- For functions without any strings, try to name at least 2 or more functions
    being called by applying this recursively or finding functions with strings.
  - Try to use multi-line regex to search for functions calling those
      functions in the source code. Alternatively you can use the following grep
      trick.
      ```
      $ git grep -A 20 <func 1> | grep <func 2>
      ```

## Plugin Development

### Setup

All the documents talk about the tight integration with Eclipse Java IDE. The
following instructions are taken from
<https://github.com/NationalSecurityAgency/ghidra/blob/master/GhidraBuild/EclipsePlugins/GhidraDev/GhidraDevPlugin/GhidraDev_README.html>.
You can search online for "GhidraDev README" to find a rendered version.

- Install Eclipse Java IDE
- Open Ghidra, create/open a project and then open the Code Browser (just empty
    is fine).
- Open Window -> ScriptManager. Select any script (I chose HelloWorldPopup) and
    click the button to edit it in Eclipse. It will automatically install the
    GhidraDev Plugin. It might ask you to locate Eclipse installation first.


### ABCL Plugin

Aim is to start a swank(slynk) server from ABCL running in the JVM so that we
can interact with Ghidra form Eclipse for scripting or analysis.

- Create a new script in Ghidra's ScriptManager. Edit it Eclipse.
- Add ABCL's jar file to the dependency for the project.
- Start ABCL's instance from the script's `run()` method.
    ```java
    Interpreter interpreter = Interpreter.createInstance();
    ```
- Create a lisp file for init code that starts the Swank server. We also define
    a function to save the GhidraScript instance to be used from common lisp
    code.
    ```lisp
    (require :asdf)

    (push #p"/Users/username/.emacs.d/elpa/sly-20221108.2234/slynk/" asdf:*central-registry*)
    (push #p"/Users/username/eclipse-workspace/GhidraScripts/abcl-src-1.9.2/contrib/jss/" asdf:*central-registry*)

    (print  asdf:*central-registry*)

    (defun set-ghidra-script (ghidra-script)
        (defparameter *ghidra-script* ghidra-script))

    (asdf:load-system :slynk)
    (asdf:load-system :jss)
    (slynk:create-server :port 4008)
    ```
- Run the file from the instance we crated above.
    ```
    interpreter.eval("(load \"lispfunction.lisp\")");
    ```
- Call the lisp method that we defined to save the GhidraScript instance.
    ```java
    org.armedbear.lisp.Package defaultPackage = Packages.findPackage("CL-USER");
    Symbol setGhidraScript = defaultPackage.findAccessibleSymbol("SET-GHIDRA-SCRIPT");
    Function setGhidraScriptFunc = (Function) setGhidraScript.getSymbolFunction();
    setGhidraScriptFunc.execute(new JavaObject(this));
    ```
- Run the script from Ghidra's script manager. If you use the debug button on
    Eclipse, a new instance of Ghidra is started and you can add breakpoints in
    the script.

- Launch Emacs with SLIME (or SLY), and connect to the server started.
