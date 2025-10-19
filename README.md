## Delphi Projects at Exercism
[https://github.com/Rafuchex/Delphi.Exercism.Projects/tree/main]

I learned Turbo Pascal when I was 12 years old, and 6 years later (like 1997), I was programming Windows applications in Borland Delphi. I learned that language just by reading the programming columns in PC Magazine, and one or another book on Turbo Pascal, QuickBASIC, and Visual Basic. Then in 2005, I learned .NET and C# programming with the Visual Studio Express Editions, and since then, I've been programming applications and Office add-ins using Visual Studio and C#.

Recently, I found the PDFs of some good old magazines on Delphi, like "The Delphi Informant Magazine" and "The Delphi Magazine", and I could see that I still maintain Pascal knowledge, since I could translate the Pascal source code I found in those PDFs to .NET without any problem.

Now, I find myself in a situation where those skills are required, so I decided to see what it is like to return to Delphi after 20 years of C# programming, and started practicing with exercises at [Exercism](https://exercism.org/tracks/delphi).

This repository contains all the source code of those practices, and it wasn't bad at all. Here's what I found:

* Some units have namespaces, like .NET Framework, but I can choose to use the standard unit name or the namespace (i.e. SysUtils and System.SysUtils).
* There is no garbage collection. Only TInterfacedObject is managed by the compiler. All other classes must be disposed of using the Free method.
* In previous versions of Delphi, I had to use GetMem and FreeMem to manage dynamic arrays. Now there is the TArray<T> and SetLength procedure, and the compiler does the rest.
* All other components remain in the same place, except for the VCL visual enhancements, like the form skins, just like DevExpress does.
