# python-c-extensions
Demonstrations of creating and accessing C extensions from python

## Installation of gcc on Windows
To install gcc on Windows, see
- https://www.msys2.org/
see also support from Visual Studio for working with C/C++ on Windows
- https://code.visualstudio.com/docs/cpp/config-mingw
Note that if you're on an x64 architecture, you really will need to install gcc for an x64 architecture. Many solutions
online will be for x32, and they simply won't work.

## Building the C code
On Windows, run from a powershell
```
./setup_library_win.bat
```

On Linux, run
```
./setup_library_linux.bat
```

After you've built the C code, you're ready to run
```
python sample.py
```
from your favourite console