> [!WARNING]
> This is a very early version and we're still stabilizing the project.

# Git CoAuth

Git CoAuth is an extension for Git that helps you give credit to your co-authors when committing to GitHub. 
The extension works like git commit but suggests a list of possible co-authors. 
Co-authors are suggested from the existing committers of a repo and from your local configuration file.
The goal is to simplify the process of finding the right name and email for co-authors.

The extension is written purely in SWI-Prolog and is free of any external dependencies, so you are ready to go. 
The project currently focuses solely on supporting macOS and Linux derivatives and is built upon the script git-polite from the repo AwesomeScripts.

## Installation

To extend Git, you should put the executable in your path and then it should be ready to use with the command git coauth. 
Alternatively, you can build the executable from source and then move it into your path.

## Build from Source

To build the project, please ensure that you have installed the latest version of SWI-Prolog and have make available on your system.

```
git clone <repo-address>
cd git-coauth
make
```

make produces a compiled file called git-coauth that is the executable to be placed in your path.

## Contributing

Feel free to submit pull requests or issues if you experience any errors. 
Suggestions for enhancements are also welcome. Just submit your suggestion as an issue.
