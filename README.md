# iniq

Grab values or complete sections from INI filies on the command line with ease.

Since the output is a sanitized version of the input you may also use it as a code beautifier. 

## Installation

```
git clone git@github.com:tijn/iniq.git
cd iniq
crystal build src/iniq.cr
```

This will get you a binary called `iniq` that you can run. And you can throw it somewhere in a directory from your $PATH of course; `/usr/local/bin` for example.

## Usage

```terminal
~ » iniq -h
Usage: iniq [OPTION]... INI-FILE KEY
       iniq [OPTION]... INI-FILE "[SECTION]" KEY
       iniq [OPTION]... INI-FILE "[SECTION]"
       cat INI-FILE | iniq [OPTION]... ["[SECTION]"] KEY

  Query an INI file for a value using a key and maybe a section.

  Grab a whole section by providing its name within square brackets. The special
  section "[]" refers to the keys that have no section. Sections are printed
  as INI files that can be parsed (by iniq) again. Comments will be stripped.

Examples:
       $ iniq /usr/lib/firefox/application.ini "[App]" Version
       56.0.1
       $ iniq /usr/lib/firefox/application.ini "[Gecko]"
       MinVersion=56.0.1
       MaxVersion=56.0.1
       $ iniq test.ini "[App]" | iniq Version
       56.0.1

    -e, --exit-status                Exit with a non-zero status if value cannot be found
    -h, --help                       Display this screen
    -v, --verbose                    Verbose output
```

## Contributing

1. Fork it ( https://github.com/tijn/iniq/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tijn](https://github.com/tijn) Tijn Schuurmans - creator, maintainer
