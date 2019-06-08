# iniq

TODO: Write a description here

## Installation

TODO: Write installation instructions here

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

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/tijn/iniq/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tijn](https://github.com/tijn) Tijn Schuurmans - creator, maintainer
