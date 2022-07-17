# python-c-extensions
Demonstrations of creating and accessing C extensions from python. Based on The Python Cookbook, Beazley 2011.

## Installation of gcc on Windows
To install gcc on Windows, see [this tutorial for MSYS2](https://www.msys2.org/). This should be sufficient, but you may also like to [read the docs](https://code.visualstudio.com/docs/cpp/config-mingw) from Visual Studio for working with C/C++ on Windows.

Note that if you're on an x64 architecture, you really will need to install gcc for an x64 architecture. Many solutions
online will be for x32, and they simply won't work.

## Building the C code
On Windows, run from a powershell
```
./setup_library_win.bat
```

On Linux, run
```
./setup_library_linux.sh
```

After you've built the C code, you're ready to run (from outside the directory above the repo)
```
python python-c-extensions
```
from your favourite console